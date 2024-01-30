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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.torque.util.BasePeer;

import com.konakart.al.KKAppEng;
import com.konakart.appif.CategoryIf;
import com.konakart.appif.OrderIf;
import com.konakart.appif.OrderProductIf;
import com.konakart.oleg.OlegTasks;
import com.konakart.oleg.actions.OlegSendEmailAction;

/**
 * Gets called at the end of the checkout process.
 */
public class CheckoutFinishedAction extends BaseAction {

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
			HttpServletRequest request, HttpServletResponse response) {

		try {
			int custId;

			KKAppEng kkAppEng = this.getKKAppEng(request, response);

			custId = this.loggedIn(request, response, kkAppEng,
					"CheckoutDelivery");

			// Check to see whether the user is logged in
			if (custId < 0) {
				return mapping.findForward(loginForward);
			}

			// Ensure we are using the correct protocol. Redirect if not.
			ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */
					false);
			if (redirForward != null) {
				return redirForward;
			}

			// Set events
			OrderIf order = kkAppEng.getOrderMgr().getCheckoutOrder();
			if (order != null) {
				insertCustomerEvent(kkAppEng, ACTION_CONFIRM_ORDER,
						order.getId());
				insertCustomerEvent(kkAppEng, ACTION_PAYMENT_METHOD_SELECTED,
						order.getPaymentModuleCode());
				System.out
						.println("CheckoutFinishedAction.execute() -> Inner ");
			}
			// DONE MITHUN added below line for sending email.
			new OlegSendEmailAction().execute(mapping, null, request, response);
			System.out.println("CheckoutFinishedAction.execute()-->Outer");
			kkAppEng.nav
					.set(getCatMessage(request, "header.checkout"), request);
			kkAppEng.nav.add(getCatMessage(request, "header.success"), request);

			// DONE mithun added below line for adding customer chat details to
			// chat log.
			System.out.println("CheckoutFinished->add to chatlog user info");

			for (CategoryIf cat : kkAppEng.getCategoryMgr().getCats()) {

				if (cat.getName().contains("Chat Service")) {
					int id = cat.getId();
					OrderProductIf[] orderProducts = order.getOrderProducts();
					for (OrderProductIf prod : orderProducts) {
						int productId = prod.getProductId();
						System.out.println("Order product ="+prod.getName());
						
						if(prod.getProduct().getCustom1().isEmpty()==false && prod.getProduct().getCategoryId()==id)
						{
							Double secs = Double.parseDouble(prod.getProduct().getCustom1());
							System.out.println("Before saving productid="+productId+" secs="+secs);
							int executeStatement = BasePeer
									.executeStatement("INSERT INTO tbl_chat_log (customers_id,products_id,chatlog_remaintime,chatlog_freeorpaid)  VALUES("
											+ custId
											+ ","
											+ productId
											+ ","
											+secs
											+","
											+"'paid'"
											+ ") ");
							System.out.println("After Done saving productid="+productId+" secs="+secs);
						}
					}
				}
			}
			//////////done mithun here///////

			return mapping.findForward("CheckoutFinished");

		} catch (Exception e) {
			return mapping.findForward(super.handleException(request, e));
		}

	}

}
