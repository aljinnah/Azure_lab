# Add the service principal application ID and secret here
ServicePrincipalId="78e3e942-67db-46fd-a6be-191cda020b88";
ServicePrincipalClientSecret="rk32M~p5q2EH-qhhI_Q~fJFmvCgCWeEegZcEfalX";


export subscriptionId="97dc82f4-458e-4ff1-a935-2b799d2082f6";
export resourceGroup="ArcBox";
export tenantId="4cfe372a-37a4-44f8-91b2-5faf34253c62";
export location="centralus";
export authType="principal";
export correlationId="44d7ae0d-408c-4d46-b4af-daef4cfdf289";
export cloud="AzureCloud";
sudo ufw --force enable
sudo ufw deny out from any to 169.254.169.254
sudo ufw default allow incoming

# Download the installation package
output=$(wget https://gbl.his.arc.azure.com/azcmagent-linux -O /tmp/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash /tmp/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --service-principal-id "$ServicePrincipalId" --service-principal-secret "$ServicePrincipalClientSecret" --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";
