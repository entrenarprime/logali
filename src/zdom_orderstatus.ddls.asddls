@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDOM ORDER STATUS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    
}
define view entity ZDOM_ORDERSTATUS 
as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZDO_ORDERSTATUS2_4034')
{
    key domain_name,
    key value_position,
    @Semantics.language: true
    key language,     
    value_low  as ORDERSTATUS, 
    value_low,
    @Semantics.text: true
    text
} where language = 'E';
