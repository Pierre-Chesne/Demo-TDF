 targetScope = 'resourceGroup'
 param serverNameDB string
 param dbName string
 param userName string
 param Password string {
   secure: true   
 }
 param planName string
 
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