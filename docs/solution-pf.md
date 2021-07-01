# PingFederate - Config

To access the Admin UI for PF go to:  
`https://{{PF_HOSTNAME[:admin_port]}}/pingfederate`

**Credentials (OIDC - My Ping):**  
Use the Identity configured for this Environment in My Ping (See [SSO with My Ping](sso-myping.md))

**Credentials (LDAP):**  
`Administrator` / `2FederateM0re`

The PingFederate configuration includes:

| Component | Name | Type | Description |
| --- | --- | --- | --- |
| **Adapters**
| | Employee HTML Form | HTML Form | Used for Internal Logons |
| | Sample CIAM Form | HTML Form with LIP | CIAM Logon Form with Social |
| | CIAM MFA Adapter | PingOne MFA | MFA with PingOne MFA |
| | Identifier First | ID-First | Identifier-First (no Lookup) |
| | Facebook | Facebook CIC | Can be configured in environment |
| | Google | Google CIC | Can be configured in environment |
| | | Apple CIC | Installed Only |
| | | LinkedIn CIC | Installed Only |
| | | iOvation IK | Installed Only |
| | | ID Data Web IK | Installed Only |
| | | Agentless IK | Installed  Only |
| **Connectors** | | |
| | CIAM MFA Connector | PingOne Connector | Auto-enrollment of Users to PingOne MFA `(mail=*)` |

### PingOne - User Enrollment

The PingOne Connector is also configured to automatically enroll any User with a valid email address in the `mail` field. If that User also has an SMS number, it will be enrolled as a secondary method - **if** you have SMS enabled on your tenant.

## Authentication Policies - Sample Authentication Experiences

A set of policies are pre-configured to enable authentication once the Solution is started:

| Policy Name | Policy Start | Components | Description |
| --- | --- | --- | --- |
| **Sample AuthN Experience** | Extended Properties Selector | | |
| | `Admin` | Employee HTML Form | Used for non-CIAM facing logons - i.e. Delegator \ PingCentral |
| | `MFA` | Standard (Registration) --> CIAM MFA | Used when MFA is requested |
| | `Passwordless` | ID-First --> CIAM MFA | Simple example of replacing Passwords with MFA |
| | `Standard` | Sample CIAM Form | HTML Form with LIP (Registration & Account Linking & Profile Management) with buttons for Google \ Facebook \ QR-Code |
| **Sample AuthN API** |  Extended Properties Selector | | |
| | `API` | ID-First --> Sample CIAM Form | Demonstrates the AuthN API orchestration |
| **Fallback Policy** | Sample CIAM Form | | Used for anything without an Extended Property (i.e. Profile Management or non-configured application)
| **Forgot Password** | CIAM MFA | | Used by Sample CIAM Form for Self-Service Password Reset |

## Applications

Sample applications are created to demonstrate the Policies:

| Protocol | Application Name | URL |
| --- | --- | --- |
| SAML | Dummy-SAML | `${PF_BASE_URL}/idp/startSSO.ping?PartnerSpId=Dummy-SAML` |
| OAuth | PingServices | `${PF_BASE_URL}/as/token.oauth2?grant_type=client_credentials` (`client_id` and `client_secret` passed as Form POST) |
| OIDC | PingLogon | `${PF_BASE_URL}/as/authorization.oauth2?response_type=code&client_id=PingLogon&redirect_uri=https://httpbin.org/anything&scope=openid profile` |
---

## CIBA Authenticators

* Email
* Push CIBA Authenticator
  * **Note:** Configuration is done with  [Use Case: Add CIBA to CIAM](https://www.getpostman.com/collections/246ba03433c2ffe26de0)

---

## Users

`user.[0-4]` / `2FederateM0re`

---

## OAuth Playground

The PingFed OAuth Playground is also deployed in the Solution - it can be started with this URL:  

`https://${PF_BASE_URL}/OAuthPlayground`

To configure PingFed with the necessary components, use the `Setup` button:

* Admin Host: `{{PF_HOSTNAME}}:9999`
* Cert Errors: `Ignore`
* Admin User: `api-admin`
* Admin Pwd: `2FederateM0re`
