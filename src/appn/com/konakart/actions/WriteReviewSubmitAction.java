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

import com.konakart.al.KKAppEng;
import com.konakart.bl.ConfigConstants;
import com.konakart.forms.WriteReviewForm;

/**
 * Gets called after submitting the write review page.
 */
public class WriteReviewSubmitAction extends BaseAction
{

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

        try
        {
            int custId;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, "WriteReview");

            // Ensure we are using the correct protocol. Redirect if not.
            ActionForward redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                return redirForward;
            }

            // Go to login page if session has timed out
            if (custId < 0)
            {
                return mapping.findForward(loginForward);
            }

            WriteReviewForm wrf = (WriteReviewForm) form;

            kkAppEng.getReviewMgr().writeReview(wrf.getReviewText(), wrf.getRating(), custId);
            
            // Set reward points if applicable
            if (kkAppEng.getRewardPointMgr().isEnabled())
            {
                String pointsStr = kkAppEng.getConfig(ConfigConstants.REVIEW_REWARD_POINTS);
                if (pointsStr != null)
                {
                    int points = 0;
                    try
                    {
                        points = Integer.parseInt(pointsStr);
                        kkAppEng.getRewardPointMgr().addPoints(points, "REV", getCatMessage(request, "reward.points.review"));
                    } catch (Exception e)
                    {
                        log
                                .warn("The REVIEW_REWARD_POINTS configuration variable has been set with a non numeric value: "
                                        + pointsStr);
                    }
                }
            }

            kkAppEng.nav.set(getCatMessage(request, "header.reviews"), request);
            return mapping.findForward("WriteReviewSubmit");

        } catch (Exception e)
        {
            return mapping.findForward(super.handleException(request, e));
        }

    }

}
