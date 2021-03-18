targetScope =  'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
 name: 'RG-Demo-GH-Bicep'
 location: deployment().location  
}

module deployServerDB 'mysql.bicep' = {
  name: 'deployServerDB'
  scope: rg
  params: {
    serverNameDB: 'smh360mysql40406cc'
    userName: 'sqladmin'
    Password: 'P2ssw0rd@123'
    dbName: 'hotel_coupon'  
  }
}

module deployAppPlan 'appPlan.bicep' = {
  name: 'deployAppPlan'
  scope: rg
  params:{
     planName: 'smh360plan'
  }
}

module deployWebSite 'site.bicep' = {
  name: 'deployWebSite'
  scope:rg
  params:{
    appPlanId: deployAppPlan.outputs.AppPlanID
    siteName: 'smh360webd4041cc'
    Password: 'P2ssw0rd@123'
    serverNameDB: 'smh360mysql40406cc'
     userName: 'sqladmin'
  }  
}