mindbody-integration provides endpoints to programatically access MINDBODY data
through a RESTful API. You first need to have a MINDBODY developer account.
You can get one at [MINDBODY][]. Once you have an account you can start testing mindbody-integration with sandbox data, or go live if your MINDBODY clients have approved your API key.

It will only return JSON. The header contains the result count as the Result-Count parameter. To authenticate with the MINDBODY API you need to set as environment variables your MINDBODY\_SITE\_IDS, MINDBODY\_SOURCE\_KEY, MINDBODY\_SOURCE\_NAME.

## Routes

### Get the list of classes

Get the classes for the studio_ids you've registered with.

```
GET /classes
```

#### Parameters

* `ClassIDs`: List of Int32. The requested ClassIDs. _(optional)_
* `StartDateTime`: DateTime. The requested start date to filter. Today's date will be used if this is not supplied. _(optional)_
* `EndDateTime`: DateTime. The requested end date to filter. Today's date will be used if this is not supplied. _(optional)_
* `LocationIDs`: List of Int32. List of location IDs to base search off of. _(optional)_
* `PageSize`: Int32. The size of each page of results. _(optional)_
* `CurrentPageIndex`: Int32. The page number of results to request, default 1. _(optional)_

#### Response

```headers
Status: 200 OK
```

```json
{
    "classes": {
        "class_schedule_id": 2255,
        "location": {
            "site_id": -99,
            "business_description": "\"The MINDBODY Health Club Demo is awesome.\" - Anonymous (but probably someone cool and smart)",
            "additional_image_ur_ls": [],
            "facility_square_feet": null,
            "treatment_rooms": null,
            "has_classes": false,
            "phone_extension": null,
            "id": 1,
            "name": "Clubville",
            "address": "4051 S Broad St",
            "address2": "San Luis Obispo, CA 93401",
            "tax1": 0.08,
            "tax2": 0.05,
            "tax3": 0.05,
            "tax4": 0,
            "tax5": 0,
            "phone": "8777554279",
            "city": "San Luis Obispo",
            "state_prov_code": "CA",
            "postal_code": "93401",
            "latitude": 35.2470788,
            "longitude": -120.6426145,
            "business_id": null,
            "pro_spa_finder_site": null,
            "distance_in_miles": null,
            "image_url": null,
            "description": null,
            "has_site": null,
            "can_book": null
        },
        "max_capacity": null,
        "web_capacity": null,
        "total_booked": null,
        "web_booked": null,
        "semester_id": null,
        "is_canceled": false,
        "substitute": false,
        "active": true,
        "is_waitlist_available": false,
        "is_enrolled": false,
        "hide_cancel": false,
        "id": 24376,
        "is_available": true,
        "start_date_time": "2015-01-23T16:30:00+00:00",
        "end_date_time": "2015-01-23T17:45:00+00:00",
        "class_description": {
            "level": {
                "id": 7,
                "name": "Beginner"
            },
            "id": 69,
            "name": "Power Yoga",
            "description": "As the name suggests, this class places a strong and fast demand on one’s awareness, agility and strength.  We will walk you into the inner depths of your practice and help you cultivate the strength, alertness and concentration needed to achieve improved vitality.  Not recommended for the faint hearted!",
            "notes": null,
            "last_updated": "2011-02-13T06:17:11+00:00",
            "program": {
                "id": 26,
                "name": "Classes",
                "schedule_type": {
                    "type": "DropIn"
                }
            },
            "session_type": {
                "id": 68,
                "name": "Yoga "
            }
        },
        "staff": {
            "state": "CA",
            "id": 100000279,
            "name": "Ashley Knight",
            "first_name": "Ashley",
            "last_name": "Knight",
            "image_url": "https://clients.mindbodyonline.com/studios/DemoAPISandboxRestore/staff/100000279_large.jpg?imageversion=1421962699",
            "is_male": false,
            "email": null,
            "mobile_phone": null,
            "home_phone": null,
            "work_phone": null,
            "address": null,
            "address2": null,
            "city": null,
            "country": null,
            "postal_code": null,
            "foreign_zip": null,
            "login_locations": [],
            "bio": null,
            "username": null,
            "availabilities": [],
            "unavailabilities": []
        },
        "visits": [],
        "clients": []
    }
}
```

### Book a class for a client

Adds clients to classes (signup).

```
POST /classes/:class_id/add_client/:client_id
```

#### Parameters

* `Test`: Boolean. Whether to use test mode (default false). If test mode is enabled, input information will be validated, but not ultimately committed.
* `RequirePayment`: Boolean. If true a payment must exist on the cliets account.

#### Response

```headers
Status: 200 OK
```

```json
{
    "classes": {
        "class_schedule_id": "2255",
        "clients": {
            "appointment_gender_preference": "None",
            "is_company": false,
            "liability_release": false,
            "promotional_email_opt_in": true,
            "action": "Added",
            "id": "100013239",
            "first_name": "Tweedle",
            "last_name": "Dumb",
            "email_opt_in": true,
            "state": "NY",
            "country": "US",
            "birth_date": null,
            "first_appointment_date": null,
            "home_location": {
                "site_id": "-99",
                "business_description": "\"The MINDBODY Health Club Demo is awesome.\" - Anonymous (but probably someone cool and smart)",
                "additional_image_ur_ls": null,
                "facility_square_feet": null,
                "treatment_rooms": null,
                "has_classes": false,
                "phone_extension": null,
                "id": "1",
                "name": "Clubville",
                "address": "4051 S Broad St",
                "address2": "San Luis Obispo, CA 93401",
                "tax1": "0.08",
                "tax2": "0.05",
                "tax3": "0.05",
                "tax4": "0",
                "tax5": "0",
                "phone": "8777554279",
                "city": "San Luis Obispo",
                "state_prov_code": "CA",
                "postal_code": "93401",
                "latitude": "35.2470788",
                "longitude": "-120.6426145"
            },
            "is_prospect": false
        },
        "location": {
            "site_id": "-99",
            "business_description": "\"The MINDBODY Health Club Demo is awesome.\" - Anonymous (but probably someone cool and smart)",
            "additional_image_ur_ls": null,
            "facility_square_feet": null,
            "treatment_rooms": null,
            "has_classes": false,
            "phone_extension": null,
            "id": "1",
            "name": "Clubville",
            "address": "4051 S Broad St",
            "address2": "San Luis Obispo, CA 93401",
            "tax1": "0.08",
            "tax2": "0.05",
            "tax3": "0.05",
            "tax4": "0",
            "tax5": "0",
            "phone": "8777554279",
            "city": "San Luis Obispo",
            "state_prov_code": "CA",
            "postal_code": "93401",
            "latitude": "35.2470788",
            "longitude": "-120.6426145"
        },
        "max_capacity": null,
        "web_capacity": null,
        "total_booked": null,
        "total_booked_waitlist": null,
        "web_booked": null,
        "semester_id": null,
        "is_canceled": false,
        "substitute": false,
        "active": true,
        "is_waitlist_available": false,
        "is_enrolled": false,
        "hide_cancel": false,
        "id": "24534",
        "is_available": true,
        "start_date_time": "2015-01-27T16:30:00+00:00",
        "end_date_time": "2015-01-27T17:45:00+00:00",
        "class_description": {
            "level": {
                "id": "7",
                "name": "Beginner"
            },
            "id": "69",
            "name": "Power Yoga",
            "description": "As the name suggests, this class places a strong and fast demand on one’s awareness, agility and strength.  We will walk you into the inner depths of your practice and help you cultivate the strength, alertness and concentration needed to achieve improved vitality.  Not recommended for the faint hearted!",
            "prereq": null,
            "notes": null,
            "last_updated": "2011-02-13T06:17:11+00:00",
            "program": {
                "id": "26",
                "name": "Classes",
                "schedule_type": "DropIn",
                "cancel_offset": "0"
            },
            "session_type": {
                "default_time_length": null,
                "program_id": "26",
                "num_deducted": "1",
                "id": "68",
                "name": "Yoga "
            }
        },
        "staff": {
            "state": "CA",
            "id": "100000279",
            "name": "Ashley Knight",
            "first_name": "Ashley",
            "last_name": "Knight",
            "image_url": "https://clients.mindbodyonline.com/studios/DemoAPISandboxRestore/staff/100000279_large.jpg?imageversion=1421963672",
            "is_male": false
        }
    }
}
```

If the client can't be booked for some reason you will get a 201 code. The resoponse will contain an error message explaining why the action failed.


### Get the list of sites

Gets a list of sites available to the Source credentials.

```
GET /sites
```

#### Response

```headers
Status: 200 OK
```

```json
{
    "sites": {
        "id": -99,
        "name": "API Sandbox Site",
        "description": "\"The MINDBODY Health Club Demo is awesome.\"\n - Anonymous (but probably someone cool and smart)",
        "logo_url": "https://clients.mindbodyonline.com/studios/DemoAPISandboxRestore/logo_mobile.png?imageversion=1421963844",
        "page_color1": "#405598",
        "page_color2": "#8293ca",
        "page_color3": "#405598",
        "page_color4": "#405598",
        "accepts_visa": false,
        "accepts_discover": false,
        "accepts_master_card": false,
        "accepts_american_express": false,
        "contact_email": "test@mindbodyonline.com                                                                             "
    }
}
```

### Get the list of locations

Gets a list of locations within the specified sites.

```
GET /locations
```

#### Response

```headers
Status: 200 OK
```

```json
{
    "locations": [
        {
            "site_id": -99,
            "business_description": "\"The MINDBODY Health Club Demo is awesome.\" - Anonymous (but probably someone cool and smart)",
            "additional_image_ur_ls": [],
            "facility_square_feet": null,
            "treatment_rooms": null,
            "has_classes": false,
            "phone_extension": null,
            "id": 1,
            "name": "Clubville",
            "address": "4051 S Broad St",
            "address2": "San Luis Obispo, CA 93401",
            "tax1": 0.08,
            "tax2": 0.05,
            "tax3": 0.05,
            "tax4": 0,
            "tax5": 0,
            "phone": "8777554279",
            "city": "San Luis Obispo",
            "state_prov_code": "CA",
            "postal_code": "93401",
            "latitude": 35.2470788,
            "longitude": -120.6426145,
            "business_id": null,
            "pro_spa_finder_site": null,
            "distance_in_miles": null,
            "image_url": null,
            "description": null,
            "has_site": null,
            "can_book": null
        },
        ...
    ]
}
```

### Get the list of packages

Gets a list of packages available for sale.

```
GET /packages
```

#### Response

```headers
Status: 200 OK
```

```json
{
    "packages": {
        "id": "352",
        "name": "PIF Membership",
        "discount_percentage": "0",
        "sell_online": true,
        "services": {
            "price": "560.0000",
            "online_price": "560.0000",
            "tax_rate": "0",
            "product_id": "1197",
            "id": "1197",
            "name": "Membership PIF - Gym Access",
            "count": "1000"
        },
        "products": null
    }
}
```

### Get the list of products

Get a list of products available for sale.

```
GET /products
```

#### Response

```headers
Status: 200 OK
```

```json
{
    "products": [
        {
            "price": "120.0000",
            "tax_rate": "0.13",
            "id": "000189",
            "group_id": "189",
            "name": "Polar Heart Rate Monitor",
            "online_price": "120.0000",
            "short_desc": "FT 80 Strength Gaining Guidance",
            "long_desc": "The FT 80 Guides your strength training with heart rate based recovery periods between sets. Creates a training program based on your personal goals and sets new weekly training targets.The Polar Fitness test measures your aerobic fitness at rest and tells you your progress.",
            "color": {
                "id": "1",
                "name": "None"
            },
            "size": {
                "id": "1",
                "name": "None"
            }
        },
        {
            "price": "45.0000",
            "tax_rate": "0.13",
            "id": "000210",
            "group_id": "210",
            "name": "CLHC Duffle Bag",
            "online_price": "45.0000",
            "color": {
                "id": "1",
                "name": "None"
            },
            "size": {
                "id": "1",
                "name": "None"
            }
        },
        ...
    ]
}
```

### Get the list of services

Get a list of services available for sale.

```
GET /services
```

#### Response

```headers
Status: 200 OK
```

```json
{
    "services": [
        {
            "price": 200,
            "online_price": 200,
            "tax_rate": 0,
            "product_id": 1192,
            "id": 1192,
            "name": "Six Week Bootcamp",
            "count": 6
        },
        {
            "price": 55,
            "online_price": 55,
            "tax_rate": 0,
            "product_id": 1300,
            "id": 1300,
            "name": "5 Class Card",
            "count": 5
        },
        ...
    ]
}
```

### Get client information

Get information about a cliente given their client_id. To query all clients you need owner credentials, not implemented.

```
GET /clients/:client_id
```

#### Response

```headers
Status: 200 OK
```

```json
{
    "clients": {
        "is_company": false,
        "id": 100013239,
        "first_name": "Tweedle",
        "last_name": "Dumb",
        "email_opt_in": true,
        "state": "NY",
        "country": "US",
        "birth_date": null,
        "first_appointment_date": null,
        "home_location": {
            "site_id": -99,
            "business_description": "\"The MINDBODY Health Club Demo is awesome.\" - Anonymous (but probably someone cool and smart)",
            "additional_image_ur_ls": [],
            "facility_square_feet": null,
            "treatment_rooms": null,
            "has_classes": false,
            "phone_extension": null,
            "id": 1,
            "name": "Clubville",
            "business_id": null,
            "pro_spa_finder_site": null,
            "address": null,
            "address2": null,
            "tax1": null,
            "tax2": null,
            "tax3": null,
            "tax4": null,
            "tax5": null,
            "phone": null,
            "city": null,
            "state_prov_code": null,
            "postal_code": null,
            "latitude": null,
            "longitude": null,
            "distance_in_miles": null,
            "image_url": null,
            "description": null,
            "has_site": null,
            "can_book": null
        },
        "is_prospect": false,
        "gender": null,
        "email": null,
        "address_line1": null,
        "address_line2": null,
        "city": null,
        "postal_code": null,
        "notes": null,
        "mobile_phone": null,
        "home_phone": null,
        "photo_url": null,
        "username": null
    }
}
```

### Get a client's services

Gets a client service for a given client.

```
GET /clients/:client_id/services
```

#### Parameters

* `StartDate`: Date. The requested start date to filter. Today's date will be used if this is not supplied. _(optional)_
* `EndDate`: Date. A filter on the end date. If this value is not supplied, it will use the same value as the StartDate. _(optional)_  

#### Response

```headers
Status: 200 OK
```

```json
{}
```

### Get a client's visits

Get visits for a client.

```
GET /clients/:client_id/visits
```

#### Parameters

* `StartDate`: Date. The requested start date to filter. Today's date will be used if this is not supplied. _(optional)_
* `EndDate`: Date. A filter on the end date. If this value is not supplied, it will use the same value as the StartDate. _(optional)_

#### Response

```headers
Status: 200 OK
```

```json
{
    "visits": {
        "id": 100343779,
        "class_id": 22031,
        "start_date_time": "2015-01-23T06:30:00+00:00",
        "end_date_time": "2015-01-23T07:30:00+00:00",
        "name": "Daily Work Out",
        "staff": {
            "id": 100000259,
            "name": "Jake Hay",
            "first_name": "Jake",
            "last_name": "Hay",
            "is_male": false,
            "email": null,
            "mobile_phone": null,
            "home_phone": null,
            "work_phone": null,
            "address": null,
            "address2": null,
            "city": null,
            "state": null,
            "country": null,
            "postal_code": null,
            "foreign_zip": null,
            "login_locations": [],
            "image_url": null,
            "bio": null,
            "username": null,
            "availabilities": [],
            "unavailabilities": []
        },
        "location": {
            "site_id": -99,
            "business_description": "\"The MINDBODY Health Club Demo is awesome.\" - Anonymous (but probably someone cool and smart)",
            "additional_image_ur_ls": [],
            "facility_square_feet": null,
            "treatment_rooms": null,
            "has_classes": false,
            "id": 1,
            "name": "Clubville",
            "tax1": 0,
            "tax2": 0,
            "tax3": 0,
            "tax4": 0,
            "tax5": 0,
            "latitude": null,
            "longitude": null,
            "business_id": null,
            "pro_spa_finder_site": null,
            "phone_extension": null,
            "address": null,
            "address2": null,
            "phone": null,
            "city": null,
            "state_prov_code": null,
            "postal_code": null,
            "distance_in_miles": null,
            "image_url": null,
            "description": null,
            "has_site": null,
            "can_book": null
        },
        "web_signup": false,
        "signed_in": false,
        "make_up": false,
        "client": null,
        "service": null
    }
}
```

### Get a client's purchases

Get purchases for a client.

```
GET /clients/:client_id/purchases
```

#### Parameters

* `StartDate`: Date. The requested start date to filter. Today's date will be used if this is not supplied. _(optional)_
* `EndDate`: Date. A filter on the end date. If this value is not supplied, it will use the same value as the StartDate. _(optional)_

#### Response

```headers
Status: 200 OK
```

```json
{
    "purchases": {
        "sale": {
            "id": "100159644",
            "sale_time": "0001-01-01T05:54:15+00:00",
            "sale_date": "2015-01-23T00:00:00+00:00",
            "sale_date_time": "2015-01-23T05:54:15+00:00",
            "location": {
                "site_id": "-99",
                "business_description": "\"The MINDBODY Health Club Demo is awesome.\" - Anonymous (but probably someone cool and smart)",
                "additional_image_ur_ls": null,
                "facility_square_feet": null,
                "treatment_rooms": null,
                "has_classes": false,
                "id": "1",
                "name": "Clubville",
                "tax1": "0",
                "tax2": "0",
                "tax3": "0",
                "tax4": "0",
                "tax5": "0",
                "latitude": null,
                "longitude": null
            },
            "payments": {
                "id": "157280",
                "amount": "108.0000",
                "method": "0",
                "type": "Cash",
                "notes": null
            }
        },
        "description": "10 Class Card",
        "price": "100.0000",
        "amount_paid": "108.0000",
        "discount": "0",
        "tax": "8.0000",
        "returned": false,
        "quantity": "1"
    }
}
```

### Get a client's schedule

Get schedule for a client.

```
GET /clients/:client_id/schedule
```

#### Parameters

* `StartDate`: Date. The requested start date to filter. Today's date will be used if this is not supplied. _(optional)_
* `EndDate`: Date. A filter on the end date. If this value is not supplied, it will use the same value as the StartDate. _(optional)_

#### Response

```headers
Status: 200 OK
```

```json
{
    "visits": {
        "id": 100343779,
        "class_id": 22031,
        "start_date_time": "2015-01-23T06:30:00+00:00",
        "end_date_time": "2015-01-23T07:30:00+00:00",
        "name": "Daily Work Out",
        "staff": {
            "id": 100000259,
            "name": "Jake Hay",
            "first_name": "Jake",
            "last_name": "Hay",
            "is_male": false,
            "email": null,
            "mobile_phone": null,
            "home_phone": null,
            "work_phone": null,
            "address": null,
            "address2": null,
            "city": null,
            "state": null,
            "country": null,
            "postal_code": null,
            "foreign_zip": null,
            "login_locations": [],
            "image_url": null,
            "bio": null,
            "username": null,
            "availabilities": [],
            "unavailabilities": []
        },
        "location": {
            "site_id": -99,
            "business_description": "\"The MINDBODY Health Club Demo is awesome.\" - Anonymous (but probably someone cool and smart)",
            "additional_image_ur_ls": [],
            "facility_square_feet": null,
            "treatment_rooms": null,
            "has_classes": false,
            "id": 1,
            "name": "Clubville",
            "tax1": 0,
            "tax2": 0,
            "tax3": 0,
            "tax4": 0,
            "tax5": 0,
            "latitude": null,
            "longitude": null,
            "business_id": null,
            "pro_spa_finder_site": null,
            "phone_extension": null,
            "address": null,
            "address2": null,
            "phone": null,
            "city": null,
            "state_prov_code": null,
            "postal_code": null,
            "distance_in_miles": null,
            "image_url": null,
            "description": null,
            "has_site": null,
            "can_book": null
        },
        "web_signup": false,
        "signed_in": false,
        "make_up": false,
        "client": null,
        "service": null
    }
}
```

## Error Handling

### 404: Not Found

If you miss-call a route, you'll get a 404 error:

```headers
Status: 404 Not Found
```

```json
{
    "message": "Route not found. Check your syntax."
}
```

## Usage/Copyright/License

Copyright (c) 2015 Get Fitter.

[MINDBODY]: https://developers.mindbodyonline.com/