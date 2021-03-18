param serverNameDB string
param dbName string
param userName string
param Password string {
  secure: true   
}

resource databaseForMySqlName 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name : serverNameDB
  location: resourceGroup().location
  sku:{
    name: 'B_Gen5_1'
    tier:'Basic'
    family: 'Gen5'
    capacity: 1     
  }
  properties: {
    version: '5.7'
    administratorLogin: userName
    administratorLoginPassword: Password
    createMode: 'Default'
    sslEnforcement: 'Disabled'
    publicNetworkAccess:'Enabled'
     storageProfile:{
       backupRetentionDays: 7
       geoRedundantBackup: 'Disabled'
       storageAutogrow: 'Disabled'
       storageMB: 5120
     }        
  }    
}
resource database 'Microsoft.DBForMySQL/servers/databases@2017-12-01' = {
  name: '${serverNameDB}/${dbName}'
  dependsOn:[
     databaseForMySqlName  
  ]
  properties:{
     charset: 'utf8'
     collation: 'utf8_general_ci'
  }
}