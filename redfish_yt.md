-------------------------------------------------------------------------------
created	:	Fri Feb  7 09:54:37 CST 2025

date	:	.

-------------------------------------------------------------------------------
redfish data model specification (DSP0268)
document was previous titled redfish schema supplememt
now includes normative statements ("longdescription") and informative description
detials from schem in a single document

intended for both redfish service and client-side developers
+ redfish resource and schema guide (DSP2046)
presents schema (data model) contents in a more friendly formt for end users
includes example payloads for each resource type
+ redfish message registry guide (SDP2065)

-------------------------------------------------------------------------------

## Redfish School - Why Redfish™?  ##
[Redfish School - Why Redfish™?](https://www.youtube.com/watch?v=LvG9XQ3AqNM&list=PLYnID7pHm2W7otc5-qC2TV7Q3qG7N2T_x&index=39)

#### redfish ####
+ industry standard RESTful API for IT infrastructure
  - HTTPS in JSON format based on Odata v4
  - equally usable by Apps,GUIs and Scripts
  - schema-backed but human-readable

> restful interaces are very common i shouldn't have to explain that to anyone anymore

we have formatted redfish using the json data format and transport the payloads over https
so it look and act just like practically everything else on the network these
> json + https

-> json -> makes it easy for that data to be consumed by applications

> data structures are all backed by schema

📝 if u want to know what [schema](./redfish_schema.md) 🔗

+ first release focused on servers
  - a secure, multi-node capable replacement for IPMI-over-LAN
  - intended to meet OCP remote machine management requirements
  - add devices over time to cover customer use cases & technology
    + PCIe switching, local storage, NVDIMMs, multifunction adapters, composability
+ expand scope over time to rest of IT infrastructure
  - working with SNIA to cover more advanced storage
  - plan on working with partners like the Green Grid to cover power/cooling(?)
  - goal is to accommodate or map existing switch standards over time
