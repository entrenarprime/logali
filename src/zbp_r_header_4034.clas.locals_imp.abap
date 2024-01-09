CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Header.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE Header.

*    METHODS earlynumbering_cba_Items FOR NUMBERING
*      IMPORTING entities FOR CREATE Header\_Items.

    METHODS Resume FOR MODIFY
      IMPORTING keys FOR ACTION Header~Resume.
    METHODS validateEmail FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~validateEmail.
    METHODS validateOrderStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR Header~validateOrderStatus.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

**********************************************************************
*** earlynumbering_create
*** Generar Correlativo Automático
**********************************************************************
  METHOD earlynumbering_create.
    DATA: entity           TYPE STRUCTURE FOR CREATE zr_header_4034.
    DATA: Header_id_max    TYPE zed_id_4034.



    " change to abap_false if you get the ABAP Runtime error 'BEHAVIOR_ILLEGAL_STATEMENT'
    " DATA:use_number_range  TYPE abap_bool VALUE abap_false.

    "Ensure ID is not set yet (idempotent)- must be checked when BO is draft-enabled
    LOOP AT entities INTO entity WHERE id IS NOT INITIAL.
      APPEND CORRESPONDING #( entity ) TO mapped-header.
    ENDLOOP.

    DATA(entities_wo_headerID) = entities.

    "Remove the entries with an existing  ID
    DELETE entities_wo_headerID WHERE id IS NOT INITIAL.


    "Set ID for new instances w/o ID
    LOOP AT entities_wo_headerID INTO entity.

      "determine the first free  ID without number range
      "Get max ID from active table
      SELECT SINGLE FROM zheader_4034 FIELDS MAX(  id ) AS id INTO @Header_id_max.

      "Get max ID from draft table
      SELECT SINGLE FROM zheader_4034_d FIELDS MAX( id ) INTO @DATA(max_id_draft).
      IF max_id_draft > Header_id_max.
        Header_id_max = max_id_draft.
      ENDIF.

      Header_id_max += 1.

* Borra Espacios
      SHIFT Header_id_max RIGHT DELETING TRAILING ` `.
      SHIFT Header_id_max LEFT  DELETING LEADING  ` `.

      entity-id = Header_id_max.


      APPEND VALUE #( %cid      = entity-%cid
                      %key      = entity-%key
                      %is_draft = entity-%is_draft
                    ) TO mapped-header.
    ENDLOOP.

  ENDMETHOD.

  METHOD precheck_update.
  ENDMETHOD.

***  METHOD earlynumbering_cba_Items.
***
***    DATA(entities_wo_ItemsID) = entities.
***
***    "Remove the entries with an existing  ID
***    DELETE entities_wo_ItemsID WHERE id IS NOT INITIAL.
***
***    LOOP AT entities_wo_ItemsID INTO Data(entity).
***
***    ENDLOOP.
***
***  ENDMETHOD.

  METHOD Resume.
  ENDMETHOD.

  METHOD validateEmail.

    DATA: go_regex   TYPE REF TO cl_abap_regex,
          go_matcher TYPE REF TO cl_abap_matcher,
          go_match   TYPE c LENGTH 1.

    READ ENTITIES OF zr_header_4034 IN LOCAL MODE
      ENTITY Header
      FIELDS ( email ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_Header).

    READ TABLE lt_Header ASSIGNING FIELD-SYMBOL(<fs_Header>) INDEX 1.
    CHECK sy-subrc EQ 0.

    TRY.


        CREATE OBJECT go_regex
          EXPORTING
            pattern     = '\w+(\.\w+)*@(\w+\.)+(\w{2,4})'
            ignore_case = abap_true.

        go_matcher = go_regex->create_matcher( text = <fs_Header>-email ).


        IF go_matcher->match( ) IS INITIAL.

          APPEND VALUE #( %tky = <fs_header>-%tky ) TO failed-header.
          APPEND VALUE #(  %tky = <fs_header>-%tky
                            %msg      = new_message( id       = 'ZMSG_4034'
                                                      number  = '001'
                                                      v1       = <fs_header>-email
                                                      severity = if_abap_behv_message=>severity-error ) )
                                                      TO reported-header.
        ENDIF.
      CATCH cx_sy_matcher.
        "handle exception
    ENDTRY.

  ENDMETHOD.

  METHOD validateOrderStatus.



    READ ENTITIES OF zr_header_4034 IN LOCAL MODE
        ENTITY Header
        FIELDS ( orderstatus ) WITH CORRESPONDING #( keys )
        RESULT DATA(lt_Header).

    READ TABLE lt_Header ASSIGNING FIELD-SYMBOL(<fs_Header>) INDEX 1.
    CHECK sy-subrc EQ 0.

    SELECT SINGLE value_low
    FROM zdom_orderstatus
    WHERE value_low = @<fs_Header>-orderstatus
    INTO  @DATA(value_low).



    IF NOT ( <fs_Header>-orderstatus >= 0 AND <fs_Header>-orderstatus <= 4 ).

      APPEND VALUE #( %tky = <fs_header>-%tky ) TO failed-header.
      APPEND VALUE #(  %tky = <fs_header>-%tky
                        %msg      = new_message( id       = 'ZMSG_4034'
                                                  number  = '002'
                                                  v1       = <fs_header>-orderstatus
                                                  severity = if_abap_behv_message=>severity-error ) )
                                                  TO reported-header.

    ELSEIF  sy-subrc NE 0.

      APPEND VALUE #( %tky = <fs_header>-%tky ) TO failed-header.
      APPEND VALUE #(  %tky = <fs_header>-%tky
                        %msg      = new_message( id       = 'ZMSG_4034'
                                                  number  = '002'
                                                  v1       = <fs_header>-orderstatus
                                                  severity = if_abap_behv_message=>severity-error ) )
                                                  TO reported-header.



    ENDIF.


  ENDMETHOD.

ENDCLASS.
