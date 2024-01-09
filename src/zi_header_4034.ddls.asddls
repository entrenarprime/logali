@EndUserText.label: 'Interface Header 4034'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_HEADER_4034 
provider contract transactional_interface
as projection on zr_header_4034
{
    key ID,
    EMAIL,
    FIRSTNAME,
    LASTNAME,
    COUNTRY,
    CREATEON,
    DELIVERYDATE,
    ORDERSTATUS,
    IMAGEURL,
    
      local_created_by,
      local_created_at,
      local_last_changed_by,
      local_last_changed_at,
      last_changed_at,
    /* Associations */
    _Items: redirected to composition child ZI_ITEMS_4034
}
