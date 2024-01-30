package com.konakart.oleg.actions;

import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.jivesoftware.smack.Chat;
import org.jivesoftware.smack.ChatManager;
import org.jivesoftware.smack.ChatManagerListener;
import org.jivesoftware.smack.MessageListener;
import org.jivesoftware.smack.Roster;
import org.jivesoftware.smack.RosterEntry;
import org.jivesoftware.smack.XMPPConnection;
import org.jivesoftware.smack.packet.Message;
import org.jivesoftware.smack.packet.Message.Type;

import com.konakart.al.KKAppEng;
import com.konakart.al.KKAppException;
import com.konakart.app.EngineConfig;
import com.konakart.appif.CategoryIf;
import com.konakart.appif.EngineConfigIf;
import com.konakart.oleg.ChatUtil;

public class OlegMyChatAction extends DispatchAction {

	// Global Forwards
	public static final String GLOBAL_FORWARD_welcome = "welcome";
	public static final String GLOBAL_FORWARD_Exception = "Exception";
	public static final String GLOBAL_FORWARD_Unavailable = "Unavailable";

	HttpSession session2;

	// Local Forwards

	public OlegMyChatAction() {
	}

	/*
	 * public ActionForward execute(ActionMapping mapping, ActionForm form,
	 * HttpServletRequest request, HttpServletResponse response) throws
	 * Exception {
	 * 
	 * // this.getDataSource(request).getConnection()
	 * System.out.println("OlegSendEmailFromAdminAction.execute()"); return
	 * null; // return mapping.findForward("error");
	 * 
	 * }
	 */

	/*
	 * called by javascript to login
	 */
	public ActionForward login(ActionMapping mapping, ActionForm form,
			final HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		System.out.println("MyChat.login()");

		XMPPConnection doLogin;
		try {
			String username2 = request.getParameter("username2");
			String password2 = request.getParameter("password2");
			HttpSession session = request.getSession();
			session2 = session;

			String status = "";
			// NOT USING BELOW
			String ip = request.getRemoteHost();
			ip += request.getRemoteAddr();
			if(session.getAttribute(ChatUtil.SESSION_CONN)!=null)
			{
				new MyTimer().run();
			}
			
			session.setAttribute(ChatUtil.SESSION_MESSAGE, "");

			if (session.getAttribute(ChatUtil.SESSION_CONN) == null) {
				doLogin = ChatUtil.doLogin(username2, password2, ip);

				if (doLogin.isAnonymous()) {
					session.setAttribute(ChatUtil.SESSION_CONN, doLogin);
					status = "true";
				} else {
					session.setAttribute(ChatUtil.SESSION_CONN, null);
					status = "false";
				}
			} else {
				doLogin = (XMPPConnection) session
						.getAttribute(ChatUtil.SESSION_CONN);
				if (doLogin.isAnonymous()) {
					// doLogin.loginAnonymously();
					// doLogin.login(username2, password2);
					status = "true";
				} else {
					System.out
							.println("No connection still connection on session");
					status = "false";
				}
			}

			Chat createChat = doLogin.getChatManager().createChat(
					"infodulynoted.co.uk@198.38.92.127",
					new MyMessageListener());// admin2

			doLogin.getChatManager().addChatListener(new ChatManagerListener() {

				@Override
				public void chatCreated(Chat arg0, boolean arg1) {
					if (!arg1) {
						System.out.println("Inside chatCreated");
						arg0.addMessageListener(new MyMessageListener());
					}
				}
			});

			Message message = new Message("infodulynoted.co.uk", Type.chat);// admin2
			message.setBody("Hi from user after logging in");
			createChat.sendMessage(message);

			// ////ADDED HERE TIMER START
			session.setAttribute(ChatUtil.SESSION_END_ALERT, "false");
			/*
			 * Hi mith Commented below line since time is unlimted for free chat
			 * as by atul on 14/jun/13 Timer timer = new Timer(); int seconds =
			 * 1000 * 60 * 2; timer.schedule(new MyTimer(), seconds);
			 */
			// ///////////////////////////////////

			System.out.println("Status is =" + status);
			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().write(status);

			// return mapping.findForward("loggedin");
		} catch (Exception e) {
			System.err.println("Eror here " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * called by javascript to send message to user meintion in req param as
	 * "to" and "messagebody" as message
	 */
	public ActionForward sendchat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MyChat.sendchat()");
		try {
			String status = "";

			String message = request.getParameter("messagebody");
			String to = request.getParameter("to");
			if (message == null || to.isEmpty()) {
				status = "ERROR Sorry no message or to text";
			} else {
				HttpSession session = request.getSession();
				session2 = session;
				XMPPConnection conn = (XMPPConnection) session
						.getAttribute(ChatUtil.SESSION_CONN);

				// //////////
				String servermessage = (String) session
						.getAttribute(ChatUtil.SESSION_MESSAGE);
				StringBuffer formatmessage = new StringBuffer("");
				if (servermessage != null)

				{
					formatmessage = new StringBuffer(servermessage);
				}
				Date dnow = new Date();
				SimpleDateFormat ft = new SimpleDateFormat("hh:mm");
				String timenow = ft.format(dnow);

				timenow = "<font color='blue'>(" + timenow + ") Me:</font>";

				if (((String) session.getAttribute(ChatUtil.SESSION_END_ALERT))
						.equals("false")) {

					formatmessage.append(timenow + message + "<br/>");
					session.setAttribute(ChatUtil.SESSION_MESSAGE,
							formatmessage.toString());
				}

				// ///////////////

				if (conn != null && conn.isConnected()
						&& conn.isAuthenticated()) {
					ChatManager chatManager = conn.getChatManager();
					Chat chat = chatManager.createChat(to,
							new MyMessageListener());
					chat.sendMessage(message);
					status = "OK send to " + to;
				}
			}
			// response.setContentType("text/xml; charset=UTF-8");
			// response.getWriter().write(status);

		} catch (Exception e) {
			System.err.println("erro on sending " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	/*
	 * To be called from client javascript inorder to receive incoming chat
	 * messages
	 */
	public ActionForward receivechat(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {

		System.out.println("MyChat.receivechat()");
		try {
			HttpSession session = request.getSession();
			session2 = session;

			String message = (String) session
					.getAttribute(ChatUtil.SESSION_MESSAGE);

			if (message == null || message.isEmpty()) {
				message = " ";
			}
			// if (((String) session.getAttribute(ChatUtil.SESSION_END_ALERT))
			// .equals("false")) {
			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().write(message);
			// }
			System.out.println("Send response to jsp page!");
		} catch (Exception e) {
			System.err.println("Sorry error in recevei chat " + e.getMessage());
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * To logout from connection
	 * 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 */
	public ActionForward logout2(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MyChat.logout()");
		try {

			HttpSession session = request.getSession();
			XMPPConnection conn = (XMPPConnection) session
					.getAttribute(ChatUtil.SESSION_CONN);
			if (conn != null && conn.isConnected()) {
				conn.disconnect();
				System.out.println("Done logout");
			} else {
				System.out
						.println("Sorry could nt logout since is not connected");
			}
			session.setAttribute(ChatUtil.SESSION_CONN, null);
			session.setAttribute(ChatUtil.SESSION_MESSAGE, null);
			session2.setAttribute(ChatUtil.SESSION_CONN, null);
			session2.setAttribute(ChatUtil.SESSION_MESSAGE, null);

			session2 = session;
			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().write("Logout");
			// return mapping.findForward("logout");
		} catch (Exception e) {
			System.err.println("Logout error " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	class MyTimer extends TimerTask {
		@Override
		public void run() {
			System.out.println("OlegMyChatAction.MyTimer.run()");
			String stopnow = "<font color='red'>Your time has expired.<br/>Please Logout</font>";
			// TODO Auto-generated method stub
			XMPPConnection conn = (XMPPConnection) session2
					.getAttribute(ChatUtil.SESSION_CONN);
			Collection<ChatManagerListener> chatListeners = conn
					.getChatManager().getChatListeners();

			for (ChatManagerListener listeners : chatListeners) {
				conn.getChatManager().removeChatListener(listeners);
			}

			/*
			 * KKAppEng kkeng; try { kkeng = new KKAppEng();
			 * 
			 * for (CategoryIf cat : kkeng.getCategoryMgr().getCats()) {
			 * 
			 * if (cat.getName().contains("Chat Service")) { int id =
			 * cat.getId(); stopnow += "<br/>"; stopnow +=
			 * "<a href='SelectCat.do?catId=" + id +
			 * " '>Click to buy chat services</a>"; } } } catch (KKAppException
			 * e) { // TODO Auto-generated catch block e.printStackTrace(); }
			 */
			session2.setAttribute(ChatUtil.SESSION_MESSAGE, stopnow);
			session2.setAttribute(ChatUtil.SESSION_END_ALERT, "true");
		}
	}

	class MyMessageListener implements MessageListener {
		@Override
		protected void finalize() throws Throwable {
			System.out.println("OlegMyChatAction.MyMessageListener.finalize()");
			super.finalize();
		}

		// private HttpServletRequest request2;
		// public MyMessageListener(HttpServletRequest req)
		// {
		// request2=req;
		// }
		@Override
		public void processMessage(Chat chat2, Message message2) {
			System.out.println("MyChat=>MyMessageListener.processMessage()");
			String messagebody = message2.getBody();

			// XMPPConnection conn2=(XMPPConnection)
			// session2.getAttribute(ChatUtil.SESSION_CONN);
			// RosterEntry entry =
			// conn2.getRoster().getEntry(chat2.getParticipant());
			String from = "Admin";// entry.getName();

			StringBuffer body2 = new StringBuffer("");
			body2.append(message2.getBody());
			body2.append("from --" + message2.getFrom());
			// String from = message2.getFrom();
			// int indexOf = from.indexOf('@');
			// from = from.substring(0, indexOf);

			HttpSession session = session2;
			String servermessage = (String) session
					.getAttribute(ChatUtil.SESSION_MESSAGE);

			if (servermessage == null) {
				servermessage = "";
			}
			Date dnow = new Date();
			SimpleDateFormat ft = new SimpleDateFormat("hh:mm");
			String timenow = ft.format(dnow);

			timenow = "<font color='red'>(" + timenow + ")" + from + ":</font>";
			messagebody = timenow + " " + messagebody + "<br/>";

			servermessage += messagebody;

			session.setAttribute(ChatUtil.SESSION_MESSAGE, servermessage);
			System.out.println("Message on server is " + servermessage);
			System.out.println("Hi Message is = " + body2.toString());

			/*
			 * ScriptEngineManager manager=new ScriptEngineManager();
			 * ScriptEngine engineByName =
			 * manager.getEngineByName("javascript");
			 * 
			 * try { engineByName.eval("addMessage('"+body2.toString()+" ');");
			 * 
			 * } catch (ScriptException e1) { // TODO Auto-generated catch block
			 * e1.printStackTrace(); }
			 */

		}
	}

}