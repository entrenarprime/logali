@AccessControl.authorizationCheck : #NOT_REQUIRED
@EndUserText.label: 'Root Header 4034'

define root view entity zr_header_4034
  as select from zheader_4034
  composition [0..*] of zr_items_4034 as _Items
  
  association [0..1] to I_Country  as _Country  
  on $projection.COUNTRY = _Country.Country
  
  association [0..1] to ZDOM_ORDERSTATUS  as _ZDOM_ORDERSTATUS  
  on $projection.ORDERSTATUS   = _ZDOM_ORDERSTATUS.ORDERSTATUS
  
{

  key id                    as ID,
      email                 as EMAIL,
      firstname             as FIRSTNAME,
      lastname              as LASTNAME,
      country               as COUNTRY,
      createon              as CREATEON,
      deliverydate          as DELIVERYDATE,
 
      orderstatus           as ORDERSTATUS,
      imageurl              as IMAGEURL,
      
      @Semantics.user.createdBy: true
      local_created_by      ,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      ,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by ,
      //local ETag field
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at ,
      //total ETag
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       ,

      //Associations
      _Items,
      _Country
    ,  _ZDOM_ORDERSTATUS 
}
