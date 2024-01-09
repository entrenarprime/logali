CLASS zcl_carga_datos_4034 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_carga_datos_4034 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lt_ZHEADER_4034    TYPE TABLE OF zheader_4034.
    DATA lt_zitems_4034      TYPE TABLE OF zitems_4034.


    lt_ZHEADER_4034   = VALUE #(
          (
          id = '1'
          email  = 'mterraza@primegroup.cl'
          firstname = 'marcelo'
          lastname = 'terraza'
          country = 'CL'
          createon = '20231227'
          deliverydate = '20231227'
          orderstatus = '1'
          imageurl = 'https://th.bing.com/th?id=OIP.GKdWmM1gJWY5xBkpPHy2LAAAAA&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2'
          )

          (
          id = '2'
          email  = 'pterraza@primegroup.cl'
          firstname = 'pablo'
          lastname = 'terraza'
          country = 'CL'
          createon = '20231227'
          deliverydate = '20231227'
          orderstatus = '1'
          imageurl = 'https://th.bing.com/th?id=OIP.GKdWmM1gJWY5xBkpPHy2LAAAAA&w=250&h=250&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2'
          )
      ) .


    lt_zitems_4034   = VALUE #(
          (
  id = '1'
  iditem = 'eb5e1622-d0b9-4596-b632-a973621c3f5c'
  name = 'MANZANAS'
  description = 'ROJAS'
  releasedate = '20231227'
  discontinueddate  = '20231227'
  price  = 1000
  moneda = 'CLP'
  height  = 5
  width  = 10
  depth  = 14
  quantity = 6
  unitofmeasure = 'KG'
  )
  (
  id = '1'
  iditem = '2b82fefc-fe33-4be4-aa1f-1262bd61ddb7'
  name = 'DURAZNOS'
  description = 'PLATANOS'
  releasedate = '20231228'
  discontinueddate  = '20231228'
  price  = 1000
  moneda = 'CLP'
  height  = 6
  width  = 7
  depth  = 8
  quantity = 50
  unitofmeasure = 'KG'
  )
  (
  id = '2'
  iditem = 'A3'
  name = 'SANDIAS'
  description = 'ROJAS'
  releasedate = '20231229'
  discontinueddate  = '20231229'
  price  = 6500
  height  = 7
  width  = 14
  depth  = 36
  quantity = 1008
  unitofmeasure = 'KG'
  )
     ).



*   delete existing entries in the database table
    DELETE FROM zheader_4034.

*   insert the new table entries
    INSERT zheader_4034 FROM TABLE @lt_ZHEADER_4034.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zheader_4034 entries inserted successfully!| ).


*   delete existing entries in the database table
    DELETE FROM zitems_4034.

*   insert the new table entries
    INSERT zitems_4034 FROM TABLE @lt_zitems_4034 .

*   output the result as a console message
    out->write( |{ sy-dbcnt } zitems_4034 entries inserted successfully!| ).



*
*****   delete existing entries in the database table
***    DELETE FROM zheader_4034.
************
*************   delete existing entries in the database table
***    DELETE FROM zitems_4034.

    DELETE FROM zheader_4034_d.
    DELETE FROM zitems_4034_d.



  ENDMETHOD.
ENDCLASS.
