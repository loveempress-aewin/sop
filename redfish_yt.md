-------------------------------------------------------------------------------
created	:	Fri Feb  7 09:54:37 CST 2025

date	:	.

-------------------------------------------------------------------------------
| [[redfish]] | [[basic]] |

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

note : first redfish it was targeted initially as a more secure, multi-node alternative to the IPMI over LAN protocol

```python	================start================
rawData = urllib.urlopen('http://192.168.1.135/redfish/v1/systems/1')
jsonData = json.loads(rawData)
print ( jsonData['SeriaNumber'] )
####----output----
# 1A87CA442K
```
this breezes though the authentication process
> note : once  have a conncetion setup => taking data out of a redfish

redfish v1.0 feature set
```bash	================start================================================================
┌────────────────────────────────────────────────┐
│ Retrieve "IPMI class" data                     │
│                                                │
│+basic server identification and asset info     │
│+health state                                   │
│+temperature sensors and fans                   │
│+power supply, power consumption and thresholds │
└────────────────────────────────────────────────┘
┌────────────────────────────────────────────────┐
│ Basic I/O infrastructure data                  │
│                                                │
│+host NIC MAC address(es) for LOM devices       │
│+simple hard drive status / fault reporting     │
│                                                │
└────────────────────────────────────────────────┘
┌────────────────────────────────────────────────┐
│ Discovery                                      │
│                                                │
│+service endpoint (network─based discovery)     │
│+system topology (rack/chassis/server/node)     │
└────────────────────────────────────────────────┘
┌────────────────────────────────────────────────┐
│ Security                                       │
│                                                │
│+session─based leverages HTTPS                  │
└────────────────────────────────────────────────┘
 ┌──────────────────────────────────────┐
 │ Perform Common Actions               │
 │                                      │
 │+reboot/ power cycle server           │
 │+change boot order/device             │
 │+set power thresholds                 │
 │                                      │
 └──────────────────────────────────────┘
 ┌──────────────────────────────────────┐
 │ Access and Notification              │
 │                                      │
 │+serial console access via SSH        │
 │+alert /event notification method(s)  │
 │+event log access method(s)           │
 └──────────────────────────────────────┘
 ┌──────────────────────────────────────┐
 │ BMC infrastructure                   │
 │                                      │
 │+view /configure BMC network settings │
 │+manage local BMC user accounts       │
 └──────────────────────────────────────┘
 ┌──────────────────────────────────────┐
 │ working on more                      │
 │                                      │
 └──────────────────────────────────────┘

```

-------------------------------------------------------------------------------

## Redfish™ Model: Common Properties  ##
[Redfish™ Model: Common Properties](https://www.youtube.com/watch?v=9OlK4qSjoYQ&list=PLYnID7pHm2W7otc5-qC2TV7Q3qG7N2T_x&index=37)

#### annotations ####
any property beginning with an `@` is an annotation

-------------------------------------------------------------------------------

## Redfish™ Model: Chassis ##
[Redfish™ Model: Chassis](https://www.youtube.com/watch?v=3aenloEF-TM&list=PLYnID7pHm2W7otc5-qC2TV7Q3qG7N2T_x&index=36)

### resource-map ###
![redfish](./pic/redfish/redfish_overview.png)

-------------------------------------------------------------------------------

## Redfish™ Model: Managers ##
[Redfish™ Model: Managers](https://www.youtube.com/watch?v=mXWjyEuMcmw&list=PLYnID7pHm2W7otc5-qC2TV7Q3qG7N2T_x&index=35)

-------------------------------------------------------------------------------

## Redfish™ Model: Systems ##
[Redfish™ Model: Systems](https://www.youtube.com/watch?v=tOE7lAsmNao&list=PLYnID7pHm2W7otc5-qC2TV7Q3qG7N2T_x&index=34)
需要配上實做

-------------------------------------------------------------------------------

## Redfish® School - Introduction to CSDL ##
[Redfish® School - Introduction to CSDL](https://www.youtube.com/watch?v=sk5dbCQWYVw&list=PLYnID7pHm2W7otc5-qC2TV7Q3qG7N2T_x&index=33)

+ CSLD : common schema definiton language
  - files are written in xml (structures define the json)
+ A schema format defined by Odata to standardize how data elements are represented in a RESTful service
  - allows for clients to dynamically scan and adapt to a service's data model
  - provides documentation for develolpers when writing purpose built clients
+ the XML structures define the JSON properties and objects that a service uses in its payloads, as well as constraints that may apply
+ inline annotations are also used to provide clients and users with more detailed information about a given property or object

CSLD -> `<NavigationProperty Name="Thermal" Type="Thermal.Thermal"/>`

### schema elements: ###
#### schema elements: EnumType ####
Defines a set of strings that show the valid values of a gven property;
each member defined is a valid value for the given enum

```json	====start================================================================
<EnumType Name="IndicatiorLED">
    <Member Name="Lit"/>
    <Member Name="Blinking"/>
    <Member Name="Off"/>
</EnumType>

<Property Name="IndicatiorLED" Type="Resource.v1_1_0.IndiatorLED"/>
```

#### schema elements: complexType ####
Defines an object with a set of preperties; can contain any number of properties or navigation properties
```json	====start================================================================
<ComplexType Name="ProcessorId">
    <Property Name="VendorId" Type="Edm.String"/>
    <Property Name="IdentificationRegisters" Type="Edm.String"/>
    <Property Name="effectiveFamily" Type="Edm.String"/>
    <Property Name="EffectiveModel" Type="Edm.String"/>
    <Property Name="Step" Type="Edm.String"/>
    <Property Name="MicrocodeInfo" Type="Edm.String"/>
</ComplexType>
```

#### schema elements: EntityType ####
Defines an object with a set of properties and uniquely identifiable key;
can contain any number of properties of navigation propertuies

used to define payloads for an entire resource

this is used when dealing with a collection of entities of the same type
A key is like an index into a collection of entities
```json ====sta================================================================
<EntityType Name="Processor">
    <Key>
        <PropertyRef Name="Id"/>
    </Key>
    <Property Name="IUd" Type="Edm.String"/>
    <Property Name="Name" Type="Edm.String"/>
    <Property Name="MaxSpeedMhz" Type="Edm.Int64"/>
    <Property Name="totalCores" Type="Edm.Int64"/>
</EntityType>
```

#### schema elements: action ####
defines an operation that a client can perform by submitting a POST request to the actiin URI

a service advertises the supported actions as part of the response to a GET request

this parameter is ultimately not sent by the ckient itself
```json ====sta================================================================
<Action Name="Reset" IsBound="true">
    <Parameter Name="Manager" Type="Manager.v1_0_0.Actions"/>
    <Parameter Name="ResetType" Type="Resource.ResetType"/>
</Action>
```

-------------------------------------------------------------------------------

## Redfish® CSDL Usage ##
[ref](https://www.youtube.com/watch?v=BXA5qn0P06A&list=PLYnID7pHm2W7otc5-qC2TV7Q3qG7N2T_x&index=32)

`<Term Name="pattern" Type+"Edm.String">`
pattern -> is used to express the different regular expressions that a property must conform to the terms
(必須符合要求的正規表示式)

`<PropertyRef Name="ID"/>`  -> the key property within all resources is the id property

#### defining redfish resources ####
+ resources are singular entities, such as thermal
+ all resources inherit fro, resouce.v1_0_0.resource
+ id is used as the key property
+ name is mandatory , but description is optional
+ many resources define a links property that inherits from the resource's definitiin of links
  - links is a object that only contains navigation properties
  - the links are references to related resources
+ a generic oem object is made available for implementations to extend upon the schema as needed

resource is a singular entity such as the thermal resource as stated

`<EntityType Name="SimpleStorage" BaseType="Resource.v1_0_0.Resource" Abstract="ture">`
BaseType : this definition is an abstract definition that contains no preperties this is done as a matter of
convenience for versioning

