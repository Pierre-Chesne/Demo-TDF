 targetScope = 'resourceGroup'
 param serverNameDB string
 param dbName string
 param userName string
 param Password string {
   secure: true   
 }
 param planName string
 //param appPlanId string
 param siteName string
 
 module deployServerDB 'mysql.bicep' = {
  name: 'deployServerDB'
  params:{
    serverNameDB: serverNameDB
    dbName: dbName
    userName: userName
    Password: Password  
    
  }
}

module deployAppPlan 'appPlan.bicep' = {
  name: 'deployAppPlan'
  params:{
    planName :planName
  }
}

module deployWebSite 'site.bicep' = {
  name: 'deployWebSite'
  params: {
    siteName: siteName
    appPlanId:  deployAppPlan.outputs.AppPlanID
    Password: Password
    serverNameDB: serverNameDB    
    userName: userName
  }
}
