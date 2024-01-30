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
import com.konakart.appif.DigitalDownloadIf;
import com.konakart.util.FileUtils;
import com.konakart.util.Utils;

/**
 * Action called just before doing the digital download
 */
public class DigitalDownloadAction extends BaseAction
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

            String ddIdStr = request.getParameter("ddId");

            if (ddIdStr == null)
            {
                return mapping.findForward("MyAccount");
            }

            int ddId;
            try
            {
                ddId = Integer.parseInt(ddIdStr);
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

            // Get the Digital Downloads
            DigitalDownloadIf[] downloads = kkAppEng.getProductMgr().getDigitalDownloads();

            if (downloads == null || downloads.length == 0)
            {
                return mapping.findForward("MyAccount");
            }

            for (int i = 0; i < downloads.length; i++)
            {
                DigitalDownloadIf dd = downloads[i];
                if (dd != null && (dd.getId() == ddId) && dd.getProduct() != null)
                {
                    // Get the file
                    String fullPath = kkAppEng.getDdbasePath();
                    if (dd.getFilePath() != null)
                    {
                        fullPath = dd.getFilePath();
                    } else
                    {
                        fullPath = fullPath + FileUtils.FILE_SEPARATOR
                                + dd.getProduct().getFilePath();
                    }
                    fullPath = Utils.removeMultipleSlashes(fullPath);

                    File file = new File(fullPath);
                    if (file.canRead() == false)
                    {
                        throw new Exception("The file " + fullPath + " cannot be opened");
                    }

                    // Set the content type
                    String contentType = dd.getProduct().getContentType();
                    if (contentType != null && contentType.length() > 0)
                    {
                        response.setContentType(contentType);
                    }

                    // Download as an attachment if configured to do so
                    if (kkAppEng.isDdAsAttachment())
                    {
                        response.setHeader("Content-Disposition", "attachment; filename=\""
                                + file.getName() + "\"");
                    }

                    // Define input and output streams
                    FileInputStream fis = new FileInputStream(file);
                    BufferedInputStream bis = new BufferedInputStream(fis);
                    ServletOutputStream os = response.getOutputStream();

                    /*
                     * Set the downloaded flag as soon as we get the output stream from the
                     * response. Once we have got the output stream we must return null from this
                     * method otherwise we get an exception if we try to do a mapping.findForward()
                     * because it also calls response.getOutputStream
                     */
                    downloaded = true;

                    // Copy from input to output
                    try
                    {
                        byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
                        int n = 0;

                        /*
                         * In the case of IE it stops here until the user decides to download or
                         * cancel out. Therefore if the operation is cancelled we do not update the
                         * download count. In the case of Firefox, this method is run completely
                         * before the download dialogue box is displayed. This means that the
                         * download count is updated even if the user decides to cancel the
                         * operation.
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

                    // Update the downloaded count
                    kkAppEng.getEng().updateDigitalDownloadCountById(kkAppEng.getSessionId(),
                            dd.getId());

                    // Get the Digital Downloads from the engine
                    kkAppEng.getProductMgr().fetchDigitalDownloads();
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
}
