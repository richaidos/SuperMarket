package com.supermarket.controllers;

import com.supermarket.dao.implementations.UserBeanImpl;
import com.supermarket.dao.interfaces.ItemsBean;
import com.supermarket.dao.interfaces.RoleBean;
import com.supermarket.dao.interfaces.TransactionHistoryInterface;
import com.supermarket.dao.interfaces.UserBean;
import com.supermarket.models.Items;
import com.supermarket.models.Roles;
import com.supermarket.models.TransactionHistory;
import com.supermarket.models.Users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.management.relation.Role;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;


@Controller
public class HomeController {

    @Autowired
    UserBean userBean;

    @Autowired
    RoleBean roleBean;

    @Autowired
    ItemsBean itemsBean;

    @Autowired
    TransactionHistoryInterface trhistory;

    Users currentUser = null;

    public boolean checkauth(String login, String password){
        currentUser = userBean.getUser(login, password);
        System.out.println(currentUser);
        if(currentUser != null){
            return true;
        }
        return false;
    }

    @RequestMapping(value={"/", "/login"})
    public ModelAndView index(HttpSession session){
        if(session.getAttribute("userData") != null){
            currentUser = (Users)session.getAttribute("userData");
            if(currentUser != null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == true){
                return new ModelAndView("profile");
            }
        }
        ModelAndView view = new ModelAndView("login");
        return view;
    }

    //needs for ajax LOGIN PAGE (login JSP)
    @RequestMapping(value = "/getUserName", method = RequestMethod.GET)
    public @ResponseBody Boolean getCharNum(@RequestParam String text) {
        Boolean result = false;
        if (text != null) {
            Users user = userBean.getUser(text);
            if (user!=null){
                result = true;
            }
        }
        return result;
    }

    //needs for ajax Edit Cashier (profile JSP)
    @RequestMapping(value = "/getUserData", method = RequestMethod.GET)
    public @ResponseBody Users getUserData(@RequestParam String text) {
        Long id = Long.parseLong(text);
        Users user = userBean.getUser(id);
        user.setPassword("null");
        return user;
    }

    //needs for ajax Edit Items (itemlist JSP)
    @RequestMapping(value = "/getItemData", method = RequestMethod.GET)
    public @ResponseBody Items getItemData(@RequestParam String text) {
        int uniCode = Integer.parseInt(text);
        Items item = itemsBean.getItemByUniCode(uniCode);
        return item;
    }

    @RequestMapping (value ="/auth", method = RequestMethod.POST)
    public String authorization(HttpServletResponse response, HttpServletRequest request, HttpSession session, @RequestParam(name = "login") String mylogin, @RequestParam(name = "password") String mypassword){
        if(checkauth(mylogin, mypassword)){
            request.getSession().setAttribute("userData", currentUser);
            return ("redirect:/profile");
        }
        return ("redirect:/");
    }

    @RequestMapping (value = "/logout", method = RequestMethod.GET)
    public String SignOut(HttpServletResponse response, HttpServletRequest request){
        if(null!=request.getSession()&&request.getSession().getAttribute("userData")!= null){
            request.getSession().removeAttribute("userData");
            currentUser = null;
            return "redirect:/";
        }
        return "redirect:/";
    }

    //Delete Cashier
    @RequestMapping (value ="/deletecashier", method = RequestMethod.GET)
    public String deletecashier(HttpServletResponse response, HttpServletRequest request, HttpSession session, @RequestParam(name = "deleteid") Long deleteid){
        Users userfordelete = userBean.getUser(deleteid);
        List<TransactionHistory> historyList = trhistory.transactionHistoryList(userfordelete);
        for(TransactionHistory th: historyList){
            trhistory.deleteTransactionHistory(th);
        }
        userBean.deleteUser(userfordelete);
        return ("redirect:/profile");
    }

    //Add New Cashier
    @RequestMapping (value ="/addnewcashier", method = RequestMethod.POST)
    public String addnewcashier(HttpServletResponse response,
                                HttpServletRequest request,
                                HttpSession session,
                                @RequestParam(name = "login") String login,
                                @RequestParam(name = "username") String username,
                                @RequestParam(name = "password") String password){
        Users newCashier = new Users();
        newCashier.setLogin(login);
        newCashier.setName(username);
        newCashier.setPassword(password);
        Roles role = roleBean.getRoleById(2L); //Get Cashier Role
        newCashier.setRole(role);
        userBean.addOrUpdateUser(newCashier);
        return ("redirect:/profile");
    }

    //Admin PROFILE
    @RequestMapping (value ="/profile", method = RequestMethod.GET)
    public ModelAndView UserProfile(HttpServletResponse response, HttpServletRequest request, HttpSession session){
        if(currentUser == null || session.getAttribute("userData") == null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == false){
            return new ModelAndView("login");
        }
        if(currentUser.getRole().getName().equals("CASHIER")){
            return new ModelAndView("redirect:/cashierprofile");
        }
        List<TransactionHistory> historyList = trhistory.transactionHistoryList();
        List<Items> itemsList = itemsBean.itemsList();
        Roles role = roleBean.getRoleById(2L);
        List<Users> usersList = userBean.usersList(role);
        ModelAndView view = new ModelAndView("profile");
        view.addObject("userList", usersList);
        view.addObject("itemsList", itemsList);
        view.addObject("historyList", historyList);
        return view;
    }

    //Cashier PROFILE
    @RequestMapping (value ="/cashierprofile", method = RequestMethod.GET)
    public ModelAndView CashierProfile(HttpServletResponse response, HttpServletRequest request, HttpSession session){
        if(currentUser == null || session.getAttribute("userData") == null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == false){
            return new ModelAndView("login");
        }

        List<TransactionHistory> historyList = trhistory.transactionHistoryList(currentUser);
        ModelAndView view = new ModelAndView("cashierprofile");
        view.addObject("historyList", historyList);
        return view;
    }

    // Transaction History
    @RequestMapping (value ="/transactionhistory", method = RequestMethod.GET)
    public ModelAndView transactionhistory(HttpServletResponse response, HttpServletRequest request, HttpSession session){
        if(currentUser == null || session.getAttribute("userData") == null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == false){
            return new ModelAndView("login");
        }
        ModelAndView view = new ModelAndView("transactionhistory");
        if(currentUser.getRole().getName().equals("ADMIN")){
            List<TransactionHistory> historyListAdmin = trhistory.transactionHistoryList();
            view.addObject("historyList", historyListAdmin);
        }else{
            List<TransactionHistory> historyListCashier = trhistory.transactionHistoryList(currentUser);
            view.addObject("historyList", historyListCashier);
        }
        return view;
    }

    //New Transaction GET PAGE
    @RequestMapping (value ="/newtransaction", method = RequestMethod.GET)
    public ModelAndView newtransactionhistory(HttpServletResponse response, HttpServletRequest request, HttpSession session){
        if(currentUser == null || session.getAttribute("userData") == null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == false){
            return new ModelAndView("login");
        }

        ModelAndView view = new ModelAndView("newtransaction");

        if(currentUser.getRole().getName().equals("CASHIER")){
            List<TransactionHistory> historyListCashier = trhistory.transactionHistoryList(currentUser);
            view.addObject("historyList", historyListCashier);
        }
        return view;
    }

    //Load Items PAGE
    @RequestMapping (value = "/loaditems", method = RequestMethod.GET)
    public ModelAndView Loaditems(HttpServletResponse response, HttpServletRequest request, HttpSession session){
        if(currentUser == null || session.getAttribute("userData") == null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == false){
            return new ModelAndView("login");
        }
        if(currentUser.getRole().getName().equals("CASHIER")){
            return new ModelAndView("redirect:/cashierprofile");
        }
        List<Items> itemsList = itemsBean.itemsList();
        ModelAndView view = new ModelAndView("itemlist");
        view.addObject("itemsList", itemsList);
        return view;
    }

    //Edit Profile Admin
    @RequestMapping (value ="/editprofile", method = RequestMethod.POST)
    public ModelAndView EditUserData(HttpServletResponse response,
                                     HttpServletRequest request,
                                     HttpSession session,
                                     @RequestParam(name = "myuserid") String id,
                                     @RequestParam(name = "login") String login,
                                     @RequestParam(name = "username") String username,
                                     @RequestParam(name = "oldpassword") String oldpassword,
                                     @RequestParam(name = "newpassword") String newpassword){
        if(currentUser == null || session.getAttribute("userData") == null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == false){
            return new ModelAndView("login");
        }
        Long id2 = Long.parseLong(id);
        Users userforedit = userBean.getUser(id2);
        Boolean status = false;
        if(userforedit.getLogin().equals(currentUser.getLogin())){
            status = true;
        }
        if(userforedit.getPassword().equals(oldpassword)){
            if(login.length()>0){
                userforedit.setLogin(login);
            }
            if(username.length()>0){
                userforedit.setName(username);
            }
            if(newpassword.length()>0){
                userforedit.setPassword(newpassword);
            }
            userBean.addOrUpdateUser(userforedit);
            if(status) {
                session.setAttribute("userData", userforedit);
            }
        }else{
            return new ModelAndView("redirect:/profile");
        }
        return new ModelAndView("redirect:/profile");
    }

    //Edit Profile for Cashiers
    @RequestMapping (value ="/editprofile2", method = RequestMethod.POST)
    public ModelAndView EditUserData2(HttpServletResponse response,
                                     HttpServletRequest request,
                                     HttpSession session,
                                     @RequestParam(name = "myuserid") String id,
                                     @RequestParam(name = "login") String login,
                                     @RequestParam(name = "username") String username,
                                     @RequestParam(name = "newpassword") String newpassword){
        if(currentUser == null || session.getAttribute("userData") == null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == false){
            return new ModelAndView("login");
        }
        Long id2 = Long.parseLong(id);
        Users userforedit = userBean.getUser(id2);
        if(login.length()>0){
            userforedit.setLogin(login);
        }
        if(username.length()>0){
            userforedit.setName(username);
        }
        if(newpassword.length()>0){
            userforedit.setPassword(newpassword);
        }
        userBean.addOrUpdateUser(userforedit);

        return new ModelAndView("redirect:/profile");
    }

    //Add New Item
    @RequestMapping (value ="/addnewitem", method = RequestMethod.POST)
    public String addnewitem(HttpServletResponse response,
                                HttpServletRequest request,
                                HttpSession session,
                                @RequestParam(name = "itemname") String itemname,
                                @RequestParam(name = "itemncode") int itemncode,
                                @RequestParam(name = "itemprice") Double itemprice,
                                @RequestParam(name = "itemamounts") int itemamounts){
        Items checkitem = itemsBean.getItemByUniCode(itemncode);
        if(checkitem!=null){
            return ("redirect:/loaditems");
        }else {
            Items item = new Items(itemname, itemncode, itemprice, itemamounts);
            itemsBean.addOrUpdateItem(item);
            return ("redirect:/loaditems");
        }
    }

    //Delete Item
    @RequestMapping (value ="/deleteitem", method = RequestMethod.GET)
    public String deleteitem(HttpServletResponse response, HttpServletRequest request, HttpSession session, @RequestParam(name = "deleteid") Long deleteid){
        Items deleteItem = itemsBean.getItemsById(deleteid);
        List<TransactionHistory> historyList = trhistory.transactionHistoryList(deleteItem);
        for(TransactionHistory th: historyList){
            trhistory.deleteTransactionHistory(th);
        }
        itemsBean.deleteItem(deleteItem);
        return ("redirect:/loaditems");
    }

    //Edit Item
    @RequestMapping (value ="/updateitem", method = RequestMethod.POST)
    public ModelAndView updateitem(HttpServletResponse response,
                                      HttpServletRequest request,
                                      HttpSession session,
                                      @RequestParam(name = "itemid") Long itemId,
                                      @RequestParam(name = "itemname") String itemName,
                                      @RequestParam(name = "itemprice") String StringitemPrice,
                                      @RequestParam(name = "itemamounts") String StringitemAmounts){
        if(currentUser == null || session.getAttribute("userData") == null || checkauth(currentUser.getLogin(), currentUser.getPassword()) == false){
            return new ModelAndView("login");
        }
        Double itemPrice = Double.parseDouble(StringitemPrice);
        int itemAmounts = Integer.parseInt(StringitemAmounts);
        Items itemforedit = itemsBean.getItemsById(itemId);

        if(itemName.length() > 1){
            itemforedit.setName(itemName);
        }

        if(itemPrice > 0){
            itemforedit.setPrice(itemPrice);
        }
        if(itemAmounts > 0){
            itemforedit.setAmounts(itemAmounts);
        }
        itemsBean.addOrUpdateItem(itemforedit);

        return new ModelAndView("redirect:/loaditems");
    }

    //Sell New Item
    @RequestMapping (value ="/sellnewproduct", method = RequestMethod.POST)
    public String sellnewproduct(HttpServletResponse response,
                             HttpServletRequest request,
                             HttpSession session,
                             @RequestParam(name = "itemamount") int amount,
                             @RequestParam(name = "unicode") int uniCode){
        Items item = itemsBean.getItemByUniCode(uniCode);
        if(item==null){
            return ("redirect:/newtransaction");
        }

        if(item.getAmounts() >= amount){
            int currentAmount = item.getAmounts();
            item.setAmounts(currentAmount-amount); //We take away the sold quantity
        }

        itemsBean.addOrUpdateItem(item);
        Date date = new Date();
        TransactionHistory history = new TransactionHistory(item, currentUser, amount, date);
        trhistory.addTransactionHistory(history);
        return ("redirect:/newtransaction");
    }

}
