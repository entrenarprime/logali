@EndUserText.label: 'Consumption - Header 4034'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions:true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'ID' ]
define root view entity zc_header_4034
  provider contract transactional_query
  as projection on zr_header_4034
{
      @Search.defaultSearchElement: true
  key ID,
      EMAIL,
      FIRSTNAME,
      LASTNAME,
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'CountryName' ]
      COUNTRY,
      _Country._Text.CountryName as CountryName : localized,
      CREATEON,
      DELIVERYDATE,
      ORDERSTATUS ,
      IMAGEURL,
      local_created_by,
      local_created_at,
      local_last_changed_by,
      local_last_changed_at,
      last_changed_at,
      /* Associations */
      _Items : redirected to composition child zc_items_4034
}
