param appPlanId string
param siteName string
param serverNameDB string
param userName string
param Password string {
  secure: true   
}

resource webSite 'Microsoft.Web/sites@2020-06-01' = {
  name: siteName
  location: resourceGroup().location
  properties: {
    siteConfig: {
      numberOfWorkers: 1
      defaultDocuments: [
        'Default.htm'
        'Default.html'
        'Default.asp'
        'index.htm'
        'index.html'
        'iisstart.htm'
        'default.aspx'
        'index.php'
        'hostingstart.html'
      ]
      netFrameworkVersion: 'v4.0'
      phpVersion: '5.6'
      requestTracingEnabled: false
      remoteDebuggingEnabled: false
      httpLoggingEnabled: false
      logsDirectorySizeLimit: 35
      detailedErrorLoggingEnabled: false
      publishingUsername: siteName
      scmType: 'None'
      use32BitWorkerProcess: true
      webSocketsEnabled: false
      alwaysOn: true
      javaVersion: '1.8'
      javaContainer: 'TOMCAT'
      javaContainerVersion: '9.0'
      managedPipelineMode: 'Integrated'
      virtualApplications: [
        {
          virtualPath: '/'
          physicalPath: 'site\\wwwroot'
          preloadEnabled: true
        }
      ]
      loadBalancing: 'LeastRequests'
      experiments: {
        rampUpRules: []
      }
      autoHealEnabled: false
      localMySqlEnabled: false
      ipSecurityRestrictions: [
        {
          ipAddress: 'Any'
          action: 'Allow'
          priority: 1
          name: 'Allow All'
          description: 'Allow all access'
        }
      ]
      scmIpSecurityRestrictions: [
        {
          ipAddress: 'Any'
          action: 'Allow'
          priority: 1
          name: 'Allow all'
          description: 'Allow all access'
        }
      ]
      scmIpSecurityRestrictionsUseMain: false
      http20Enabled: false
      minTlsVersion: '1.2'
      ftpsState: 'AllAllowed'  

      appSettings: [
        {
          name: 'SPRING_DATASOURCE_PASSWORD'
          value: Password
        }
        {
          name: 'SPRING_DATASOURCE_URL'
          value: 'jdbc:mysql://${serverNameDB}.mysql.database.azure.com:3306/hotel_coupon?useSSL=true&requireSSL=false'

        }
        {
          name: 'SPRING_DATASOURCE_USERNAME'
          value: '${userName}@${serverNameDB}'
        }         
      ]
    }
    serverFarmId: appPlanId
  }
}