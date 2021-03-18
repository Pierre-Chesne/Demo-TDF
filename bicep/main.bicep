 targetScope = 'resourceGroup'
 param serverNameDB string
 param dbName string
 param userName string
 param Password string {
   secure: true   
 }
 
 module deployServerDB 'mysql.bicep' = {
  name: 'deployServerDB'
  params:{
    serverNameDB: serverNameDB
    dbName: dbName
    userName: userName
    Password: Password  
    
  }
}