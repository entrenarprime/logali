@EndUserText.label: 'Interface Items 4034'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_ITEMS_4034
  as projection on zr_items_4034
{
  key ID,
  key IDITEM,
      NAME,
      DESCRIPTION,
      RELEASEDATE,
      DISCONTINUEDDATE,
      PRICE,
      CURRENCYCODE,
      HEIGHT,
      WIDTH,
      DEPTH,
      QUANTITY,
      UNITOFMEASURE,
      
      local_last_changed_at,
      /* Associations */
      _Header:  redirected  to parent ZI_HEADER_4034
}
