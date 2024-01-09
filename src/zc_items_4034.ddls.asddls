@EndUserText.label: 'Consumption - Item 4034'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions:true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'ID', 'IDITEM' ]
define view entity zc_items_4034
  as projection on zr_items_4034
{
      @Search.defaultSearchElement: true
  key ID,
      @Search.defaultSearchElement: true
  key IDITEM,  
      @Search.defaultSearchElement: true  
      NAME,
      @Search.defaultSearchElement: true
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
      _Header : redirected to parent zc_header_4034
}
