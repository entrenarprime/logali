@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
 
define view entity zr_items_4034 as 
select from zitems_4034  

 association to parent zr_header_4034 as _Header
 on $projection.ID = _Header.ID
   
   association [1..1] to I_UnitOfMeasureStdVH 
   as _UnitOfMeasureStdVH 
   on $projection.UNITOFMEASURE = _UnitOfMeasureStdVH.UnitOfMeasure

  association [0..1] to I_Currency as _Currency      
  on $projection.CURRENCYCODE = _Currency.Currency

{ 
  key id                 as ID,
  key iditem             as IDITEM,
      name               as NAME,
      description        as DESCRIPTION,
      releasedate        as RELEASEDATE,
      discontinueddate   as DISCONTINUEDDATE,
      price              as PRICE,      
      moneda             as CURRENCYCODE,
      @Semantics.quantity.unitOfMeasure : 'unitofmeasure'
      height             as HEIGHT,
      @Semantics.quantity.unitOfMeasure : 'unitofmeasure'
      width              as WIDTH,
      depth              as DEPTH,
      quantity           as QUANTITY,
      unitofmeasure      as UNITOFMEASURE,
      //local ETag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at,
      
//Association
      _Header,
      _UnitOfMeasureStdVH,
      _Currency
}

