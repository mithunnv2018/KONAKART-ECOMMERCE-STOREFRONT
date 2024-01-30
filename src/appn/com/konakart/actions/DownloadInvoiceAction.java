//
// (c) 2006 DS Data Systems UK Ltd, All rights reserved.
//
// DS Data Systems and KonaKart and their respective logos, are 
// trademarks of DS Data Systems UK Ltd. All rights reserved.
//
// The information in this document is free software; you can redistribute 
// it and/or modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//

package com.konakart.actions;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.konakart.al.KKAppEng;
import com.konakart.al.KKAppException;
import com.konakart.app.PdfOptions;
import com.konakart.app.PdfResult;
import com.konakart.appif.OrderIf;
import com.konakart.util.FileUtils;
import com.konakart.util.KKConstants;

/**
 * Action called just before downloading the invoice
 */
public class DownloadInvoiceAction extends BaseAction
{

    protected static final int DEFAULT_BUFFER_SIZE = 4096;

    /**
     * 
     * @param mapping
     *            The ActionMapping used to select this instance
     * @param form
     *            The optional ActionForm bean for this request (if any)
     * @param request
     *            The HTTP request we are processing
     * @param response
     *            The HTTP response we are creating
     * 
     */
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
    {
        boolean downloaded = false;

        try
        {
            int custId;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            String orderIdStr = request.getParameter("orderId");

            if (orderIdStr == null)
            {
                return mapping.findForward("MyAccount");
            }

            int orderId;
            try
            {
                orderId = Integer.parseInt(orderIdStr);
            } catch (RuntimeException e)
            {
                return mapping.findForward("MyAccount");
            }

            // Check to see whether the user is logged in
            custId = this.loggedIn(request, response, kkAppEng, "MyAccount");
            if (custId < 0)
            {
                return mapping.findForward(loginForward);
            }

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            // Get the order
            OrderIf order = kkAppEng.getEng().getOrder(kkAppEng.getSessionId(), orderId,
                    kkAppEng.getLangId());

            // Determine whether a pdf document exists on the file system. Otherwise we create it on
            // the fly.
            if (order.getInvoiceFilename() != null && order.getInvoiceFilename().length() > 0)
            {
                // Try to open the file
                String pdfBase = kkAppEng.getConfig(KKConstants.CONF_KEY_PDF_BASE_DIRECTORY);
                if (pdfBase == null)
                {
                    pdfBase = "";
                }
                String fullFileName = pdfBase + FileUtils.FILE_SEPARATOR
                        + KKAppEng.getEngConf().getStoreId() + FileUtils.FILE_SEPARATOR
                        + order.getInvoiceFilename();

                File file = new File(fullFileName);
                if (file.canRead() == false)
                {
                    throw new Exception("The file " + fullFileName + " cannot be opened");
                }

                // set the content type
                response.setContentType("application/pdf");

                // Comment out the following line if you want the invoice to open up in the browser
                // window
                response.setHeader("Content-Disposition", "attachment; filename=\""
                        + order.getInvoiceFilename() + "\"");

                // Define input and output streams
                FileInputStream fis = new FileInputStream(file);
                BufferedInputStream bis = new BufferedInputStream(fis);
                ServletOutputStream os = response.getOutputStream();

                /*
                 * Set the downloaded flag as soon as we get the output stream from the response.
                 * Once we have got the output stream we must return null from this method otherwise
                 * we get an exception if we try to do a mapping.findForward() because it also calls
                 * response.getOutputStream
                 */
                downloaded = true;

                // Copy from input to output
                try
                {
                    byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
                    int n = 0;

                    /*
                     * In the case of IE it stops here until the user decides to download or cancel
                     * out. Therefore if the operation is cancelled we do not update the download
                     * count. In the case of Firefox, this method is run completely before the
                     * download dialogue box is displayed. This means that the download count is
                     * updated even if the user decides to cancel the operation.
                     */
                    while ((n = bis.read(buffer)) > -1)
                    {
                        os.write(buffer, 0, n);
                    }
                } finally
                {
                    bis.close();
                    if (os != null)
                    {
                        os.flush();
                        os.close();
                    }
                }
            } else
            {
                // Create the invoice
                PdfResult pdfResult = createInvoice(kkAppEng, order);

                if (pdfResult == null || pdfResult.getPdfBytes() == null)
                {
                    throw new KKAppException("Unable to create the PDF invoice");
                }

                // set the content type
                response.setContentType("application/pdf");

                // Comment out the following line if you want the invoice to open up in the browser
                // window
                response.setHeader("Content-Disposition", "attachment; filename=\"" + "order_"
                        + order.getId() + ".pdf" + "\"");

                ServletOutputStream os = null;
                try
                {
                    os = response.getOutputStream();

                    /*
                     * Set the downloaded flag as soon as we get the output stream from the
                     * response. Once we have got the output stream we must return null from this
                     * method otherwise we get an exception if we try to do a mapping.findForward()
                     * because it also calls response.getOutputStream
                     */
                    downloaded = true;

                    // Write the pdf to the output stream
                    os.write(pdfResult.getPdfBytes());

                } finally
                {
                    if (os != null)
                    {
                        os.flush();
                        os.close();
                    }
                }
            }
            if (downloaded)
            {
                return null;
            }

            return mapping.findForward("MyAccount");

        } catch (Exception e)
        {
            if (downloaded)
            {
                return null;
            }
            return mapping.findForward(super.handleException(request, e));
        }
    }

    /**
     * Creates the PDF invoice using the AdminPdfMgr if the code is present. This is normally
     * available only for the enterprise version of KonaKart. If the invoice already exists in the
     * file system then this copy of the invoice is used, otherwise it is created temporarily.
     * 
     * @param order
     * @throws Exception
     */
    private PdfResult createInvoice(KKAppEng kkAppEng, OrderIf order) throws Exception
    {

        int langId = kkAppEng.getLangId();

        PdfOptions options = new PdfOptions();
        options.setId(order.getId());
        options.setType(KKConstants.HTML_ORDER_INVOICE);
        options.setLanguageId(langId);
        options.setReturnFileName(false);
        options.setReturnBytes(true);
        options.setCreateFile(false);

        PdfResult pdfResult = (PdfResult) kkAppEng.getEng().getPdf(kkAppEng.getSessionId(),options);

        return pdfResult;
    }

}
