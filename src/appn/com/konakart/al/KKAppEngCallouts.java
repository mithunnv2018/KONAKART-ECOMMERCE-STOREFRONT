package com.konakart.al;

/**
 * Callouts to add custom code to the KKAppEng
 */
public class KKAppEngCallouts
{
    /**
     * Called at the start of startup
     * 
     * @param eng
     */
    public void beforeStartup(KKAppEng eng)
    {
        // System.out.println("Set product options for current customer");
        // FetchProductOptionsIf fpo = new FetchProductOptions();
        // fpo.setCatalogId("cat1");
        // fpo.setUseExternalPrice(true);
        // fpo.setUseExternalQuantity(true);
        // eng.setFetchProdOptions(fpo);
    }

    /**
     * Called at the end of startup
     * 
     * @param eng
     */
    public void afterStartup(KKAppEng eng)
    {
    }

    /**
     * Called at the end of the RefreshAllClientConfigs method of KKAppEng
     * 
     * @param eng
     */
    public void afterRefreshAllClientConfigs(KKAppEng eng)
    {
    }

    /**
     * Called from the ConfigCacheUpdater thread whenever the KKAppEng caches are refreshed.
     * 
     * @param eng
     */
    public void afterRefreshCaches(KKAppEng eng)
    {
    }

    /**
     * Called by the CustomerMgr after a login has been successful
     * 
     * @param eng
     */
    public void afterLogin(KKAppEng eng)
    {

    }

}
