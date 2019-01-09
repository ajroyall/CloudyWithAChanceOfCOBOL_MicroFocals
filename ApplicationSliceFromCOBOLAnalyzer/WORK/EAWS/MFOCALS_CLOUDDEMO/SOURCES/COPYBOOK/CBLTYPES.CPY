      *> ********************************************************************
      *>
      *> Copyright (C) Micro Focus 1984-2012.
      *> All rights reserved.
      *>
      *> The software and information contained herein are
      *> proprietary to, and comprise valuable trade secrets of,
      *> Micro Focus, which intends to preserve as trade secrets
      *> such software and information.  This software is an
      *> unpublished copyright of Micro Focus and may not be
      *> used, copied, transmitted, or stored in any manner.  This
      *> software and information or any other copies thereof may not
      *> be provided or otherwise made available to any other person.
      *> 
      *> COBOL Run Time System
      *> 
      *> @(#)$Id: cbltypes.cpy 471181 2012-01-11 16:48:49Z pim $
      *> 
      *> ********************************************************************

      *> ********************************************************************
      *>
      *> This copy book, which is supplied as $COBDIR/cpylib/cbltypes.cpy, 
      *>  defines corresponding COBOL types for all the C types defined in 
      *>  $COBDIR/include/cbltypes.h.  This copy book, in conjunction with
      *>  the cbltypes.h include file, can be useful in a mixed language 
      *>  (C/COBOL) programming environment.
      *>
      *> In order to support the use of $COBDIR/cpylib/cblproto.cpy for 
      *>  prototyping all available CBL_ prefix routines, the COBOL-style
      *>  definition of the parameter blocks required by many of those 
      *>  routines are included here.
      *>
      *> ********************************************************************
      *>
      *> General types
      *>
        01      cblt-x1         pic     x               typedef.

        01      cblt-pointer    usage pointer           typedef.
        01      cblt-ppointer   usage procedure-pointer typedef.

        01      cblt-x1-comp5   pic     x       comp-5  typedef.
        01      cblt-x2-comp5   pic     x(2)    comp-5  typedef.
        01      cblt-x4-comp5   pic     x(4)    comp-5  typedef.
        01      cblt-x8-comp5   pic     x(8)    comp-5  typedef.

        01      cblt-x1-compx   pic     x       comp-x  typedef.
        01      cblt-x2-compx   pic     x(2)    comp-x  typedef.
        01      cblt-x4-compx   pic     x(4)    comp-x  typedef.
        01      cblt-x8-compx   pic     x(8)    comp-x  typedef.

        01      cblt-sx1-comp5  pic     s9(2)   comp-5  typedef.
        01      cblt-sx2-comp5  pic     s9(4)   comp-5  typedef.
        01      cblt-sx4-comp5  pic     s9(9)   comp-5  typedef.
        01      cblt-sx8-comp5  pic     s9(18)  comp-5  typedef.

      $if P64 set
      $if ILGEN set
        01      cblt-os-offset          cblt-x4-comp5   typedef.
        01      cblt-os-size            cblt-x4-comp5   typedef.
        01      cblt-os-ssize           cblt-sx4-comp5  typedef.
        01      cblt-os-flags           cblt-x4-comp5   typedef.
        01      cblt-rtncode            cblt-sx4-comp5  typedef.
      $else
        01      cblt-os-offset          cblt-x8-comp5   typedef.
        01      cblt-os-size            cblt-x8-comp5   typedef.
        01      cblt-os-ssize           cblt-sx8-comp5  typedef.
        01      cblt-os-flags           cblt-x8-comp5   typedef.
        01      cblt-rtncode            cblt-sx8-comp5  typedef.
      $end
      $else
        01      cblt-os-offset          cblt-x4-comp5   typedef.
        01      cblt-os-size            cblt-x4-comp5   typedef.
        01      cblt-os-ssize           cblt-sx4-comp5  typedef.
        01      cblt-os-flags           cblt-x4-comp5   typedef.
        01      cblt-rtncode            cblt-sx4-comp5  typedef.
      $end

      *>
      *> Types and structures used by file and filename handling routines
      *>
        01      cblt-vfile-handle               cblt-x2-comp5   typedef.        
        01      cblt-vfile-status               cblt-x2-compx   typedef.

        01      cblt-bytestream-handle          cblt-x4-comp5   typedef.

        01      cblt-file-status                cblt-x2-compx   typedef.

        01      cblt-fileexist-buf              typedef.
          03    cblte-fe-filesize               cblt-x8-compx.
          03    cblte-fe-date.
            05  cblte-fe-day                    cblt-x1-compx.
            05  cblte-fe-month                  cblt-x1-compx.
            05  cblte-fe-year                   cblt-x2-compx.
          03    cblte-fe-time.
            05  cblte-fe-hours                  cblt-x1-compx.
            05  cblte-fe-minutes                cblt-x1-compx.
            05  cblte-fe-seconds                cblt-x1-compx.
            05  cblte-fe-hundreths              cblt-x1-compx.

        01      cblt-splitjoin-buf              typedef.
          03    cblte-sj-param-length           cblt-x2-compx.
          03    cblte-sj-split-join-flag1       cblt-x1-compx.
          03    cblte-sj-split-join-flag2       cblt-x1-compx.
          03    cblte-sj-device-offset          cblt-x2-compx.
          03    cblte-sj-device-length          cblt-x2-compx.
          03    cblte-sj-basename-offset        cblt-x2-compx.
          03    cblte-sj-basename-length        cblt-x2-compx.
          03    cblte-sj-extension-offset       cblt-x2-compx.
          03    cblte-sj-extension-length       cblt-x2-compx.
          03    cblte-sj-total-length           cblt-x2-compx.
          03    cblte-sj-split-buf-len          cblt-x2-compx.
          03    cblte-sj-join-buf-len           cblt-x2-compx.
          03    cblte-sj-first-component-length cblt-x2-compx.

      *>
      *> Structure used by the memory management routines
      *>
        01   cblt-node-name                     typedef.
          03 cblte-nname-name-len     cblt-x1-comp5.
          03 cblte-nname-name-text    cblt-x1. *> occurs depending 
                                               *> cblte-nname-name-len.
      *>
      *> Structures used by the mouse handling routines.
      *>
        01      cblt-mouse-pos                  typedef.
          03    cblte-mpos-row                  cblt-x2-compx.
          03    cblte-mpos-col                  cblt-x2-compx.

        01      cblt-mouse-event                typedef.
          03    cblte-mevent-type               cblt-x2-compx.
          03    cblte-mevent-time               cblt-x4-compx.
          03    cblte-mevent-row                cblt-x2-compx.
          03    cblte-mevent-col                cblt-x2-compx.

        01      cblt-mouse-shape                typedef.
          03    cblte-mshape-char-and-mask      cblt-x1.
          03    cblte-mshape-attr-and-mask      cblt-x1.
          03    cblte-mshape-char-xor-mask      cblt-x1.
          03    cblte-mshape-attr-xor-mask      cblt-x1.

        01      cblt-mouse-rect                 typedef.
          03    cblte-mrect-top                 cblt-x2-compx.
          03    cblte-mrect-left                cblt-x2-compx.
          03    cblte-mrect-bottom              cblt-x2-compx.
          03    cblte-mrect-right               cblt-x2-compx.

      *>
      *> Structures used by CBL_NLS_ messaging routines
      *>
        01      cblt-nls-msg-number-pair        typedef.
          03    cblte-nmnp-set-number           cblt-x2-compx.
          03    cblte-nmnp-number               cblt-x2-compx.

        01      cblt-nls-msg-ins-struct         typedef.
          03    cblte-nmis-ins-count            cblt-x2-compx.
          03    cblte-nmis-ins-pointer          cblt-pointer. *> occurs
                                                              *> depending on 
                                                              *> ins-count.

        01      cblt-nls-msg-buffer             typedef.
          03    cblte-nmb-buff-len              cblt-x2-compx.
          03    cblte-nmb-buff-text             cblt-x1. *> occurs depending on
                                                         *> cblte-nmsgb-buff-len

        01      cblt-nls-msg-params             typedef.
          03    cblte-nmpb-set-number           cblt-x2-compx.
          03    cblte-nmpb-number               cblt-x2-compx.
          03    cblte-nmpb-max-buffer-len       cblt-x2-compx.
          03    cblte-nmpb-actual-msg-len       cblt-x2-compx.
          03    cblte-nmpb-flags                cblt-x2-compx.

      *>
      *> Structures used by CBL_CANCEL_PROC
      *>
        01 cblt-cancel-proc-params              typedef.
           03 cblte-cppb-version                cblt-x4-comp5.
           03 cblte-cppb-flags                  cblt-x4-comp5.
           03 cblte-cppb-callback               usage procedure-pointer.
           03 cblte-cppb-handle                 usage pointer.
           03 cblte-cppb-userdata               usage pointer.
           03 cblte-cppb-priority               cblt-x4-comp5.

      *>
      *> Structures used by CBL_EXIT_PROC
      *>
        01      cblt-exit-params                typedef.
          03    cblte-ep-install-addr           cblt-ppointer.
          03    cblte-ep-install-priority       cblt-x1-compx.

      *>
      *> Structure used by CBL_SUBSYSTEM
      *>
        01      cblt-subsys-params              typedef.
          03    cblte-ssp-handle                cblt-x2-compx.
          03    cblte-ssp-name-len              cblt-x2-compx.
          03    cblte-ssp-name                  cblt-x1. *> Occurs depending on
                                                         *> cblte-ssp-name-len

      *>
      *> Structure used by CBL_GET_EXIT_INFO
      *>
        01      cblt-exit-info-params           typedef.
          03    cblte-gei-size                  cblt-x4-comp5.
          03    cblte-gei-return-code           cblt-x4-comp5.
          03    cblte-gei-rts-error             cblt-x4-comp5.
          03    cblte-gei-exit-flags            cblt-x4-comp5.

      *>
      *> Structure used by CBL_GET_OS_INFO
      *>
        01      cblt-os-info-params             typedef.
          03    cblte-osi-length                cblt-x2-compx.
          03    cblte-osi-os-type               cblt-x1-compx.
          03    cblte-osi-os-version            cblt-x4-compx.
          03    cblte-osi-dbcs-support          cblt-x1-compx.
          03    cblte-osi-char-coding           cblt-x1-compx.
          03    cblte-osi-country-id            cblt-x2-compx.
          03    cblte-osi-code-page             cblt-x2-compx.
          03    cblte-osi-process-type          cblt-x1-compx.
          03    cblte-osi-rts-capabilities      cblt-x4-compx.
          03    cblte-osi-product               cblt-x2-compx.
          03    cblte-osi-product-version       cblt-x2-compx.
          03    cblte-osi-product-revision      cblt-x2-compx.
          03    cblte-osi-product-sp            cblt-x2-compx.
          03    cblte-osi-fixpack               cblt-x2-compx.

      *>
      *> Structures used by CBL_GET_PROGRAM_INFO
      *>
        01      cblt-prog-info-params           typedef.
          03    cblte-gpi-size                  cblt-x4-comp5.
          03    cblte-gpi-flags                 cblt-x4-comp5.
          03    cblte-gpi-handle                cblt-pointer.
          03    cblte-gpi-prog-id               cblt-pointer.
          03    cblte-gpi-attrs                 cblt-x4-comp5.

        01      cblt-prog-info-arg-info         typedef.
          03    cblte-gpiai-size                cblt-x4-comp5.
          03    cblte-gpiai-argc                cblt-x4-comp5.
          03    cblte-gpiai-reserved1           cblt-pointer.
          03    cblte-gpiai-reserved2           cblt-pointer.

      *>
      *> Structures used by CBL_nnnn_SCR_ screen handling calls.
      *>
        01 cblt-screen-position                 typedef.
          03    cblte-scrp-row                  cblt-x1-compx.
          03    cblte-scrp-col                  cblt-x1-compx.

        01 cblt-get-scr-graphics-buffer         typedef.
          03    cblte-gsgb-flag                 cblt-x1-compx.
          03    cblte-gsgb-buf-size             cblt-x2-compx.

          03    cblte-gsgb-buf.
           04   cblte-gsgb-up-arrow.
             05 cblte-gsgb-up-arrow-dbflag      cblt-x1-compx.
             05 cblte-gsgb-up-arrow-arrow       cblt-x1-compx.

           04   cblte-gsgb-down-arrow.
             05 cblte-gsgb-down-arrow-dbflag    cblt-x1-compx.
             05 cblte-gsgb-down-arrow-arrow     cblt-x1-compx.

           04   cblte-gsgb-right-arrow.
             05 cblte-gsgb-right-arrow-dbflag   cblt-x1-compx.
             05 cblte-gsgb-right-arrow-arrow    cblt-x1-compx.

           04   cblte-gsgb-left-arrow.
             05 cblte-gsgb-left-arrow-dbflag    cblt-x1-compx.
             05 cblte-gsgb-left-arrow-arrow     cblt-x1-compx.

           04   cblte-gsgb-maximize.
             05 cblte-gsgb-maximize-dbflag      cblt-x1-compx.
             05 cblte-gsgb-maximize-char        cblt-x1-compx.

           04   cblte-gsgb-minimize.
             05 cblte-gsgb-minimize-dbflag      cblt-x1-compx.
             05 cblte-gsgb-minimize-char        cblt-x1-compx.

           04   cblte-gsgb-check.
             05 cblte-gsgb-check-dbflag         cblt-x1-compx.
             05 cblte-gsgb-check-char           cblt-x1-compx.

           04   cblte-gsgb-restore.
             05 cblte-gsgb-restore-dbflag       cblt-x1-compx.
             05 cblte-gsgb-restore-char         cblt-x1-compx.

           04   cblte-gsgb-radio.
             05 cblte-gsgb-radio-dbflag         cblt-x1-compx.
             05 cblte-gsgb-radio-char           cblt-x1-compx.

           04   cblte-gsgb-scroll.
             05 cblte-gsgb-scroll-dbflag        cblt-x1-compx.
             05 cblte-gsgb-scroll-char          cblt-x1-compx.

           04   cblte-gsgb-rubber-band.
             05 cblte-gsgb-rubber-band-dbflag   cblt-x1-compx.
             05 cblte-gsgb-rubber-band-char     cblt-x1-compx.

           04   cblte-gsgb-sysmenu.
             05 cblte-gsgb-sysmenu-char-dbflag  cblt-x1-compx.
             05 cblte-gsgb-sysmenu-char-char    cblt-x1-compx.

           04   cblte-gsgb-editor-char.
             05 cblte-gsgb-editor-char-dbflag   cblt-x1-compx.
             05 cblte-gsgb-editor-char-char     cblt-x1-compx.

           04   cblte-gsgb-hyhelp-tab.
             05 cblte-gsgb-hyhelp-tab-dbflag    cblt-x1-compx.
             05 cblte-gsgb-hyhelp-tab-char      cblt-x1-compx.

           04   cblte-gsgb-hyhelp-btab.
             05 cblte-gsgb-hyhelp-btab-dbflag   cblt-x1-compx.
             05 cblte-gsgb-hyhelp-btab-char     cblt-x1-compx.

        01      cblt-get-scr-line-draw-buffer   typedef.
          03    cblte-gsld-draw-code            cblt-x1-compx.
          03    cblte-gsld-dbcs-draw-char       cblt-x2-compx. *> Occurs n times
          03    cblte-gsld-draw-char  
                    redefines cblte-gsld-dbcs-draw-char
                                                cblt-x1-compx. *> Occurs n times

      *>
      *> Structures used by CBL_SCR_ Generic Attribute calls.
      *>
        01      cblt-generic-attr-rgb-values    typedef.
          03    cblte-garv-red-value            cblt-x2-compx.
          03    cblte-garv-green-value          cblt-x2-compx.
          03    cblte-garv-blue-value           cblt-x2-compx.
          03    cblte-garv-filler               cblt-x1-compx occurs 2.

        01      cblt-generic-attr-value         typedef.
          03    cblte-gav-foreground-color-attr cblt-x4-compx.
          03    cblte-gav-background-color-attr cblt-x4-compx.
          03    cblte-gav-character-attribute   cblt-x1-compx.
          03    cblte-gav-filler                cblt-x1-compx occurs 3.

        01      cblt-generic-attr-information   typedef.
          03    cblte-gai-display-class         cblt-x1-compx.
          03    cblte-gai-colormap-size         cblt-x2-compx.
          03    cblte-gai-colormap-flags        cblt-x1-compx.
          03    cblte-gai-bits-per-gun          cblt-x1-compx.

      *>
      *> Structures used by ASEE request handlers
      *>
      $if CBL-ALPHA-32BIT defined
        01      cblt-request-context            typedef.
          03    cblte-reqcxt-version            cblt-x4-comp5.
             78 78-CBLTE-REQCXT-VERSION         value 0.
          03    cblte-reqcxt-handler-id         cblt-x4-comp5.
          03    cblte-reqcxt-request-len        cblt-x4-comp5.
          03    cblte-reqcxt-argc               cblt-x4-comp5.
          03    cblte-reqcxt-return-code        cblt-rtncode.
          03    cblte-reqcxt-service-type       cblt-x4-comp5.
             78 78-CBLTE-REQCXT-SRV-TYPE-PGM    value 0.
             78 78-CBLTE-REQCXT-SRV-TYPE-CICS   value 1.
             78 78-CBLTE-REQCXT-SRV-TYPE-IMS    value 2.
          03    cblte-reqcxt-accept-buf-len     cblt-x4-comp5.
          03    cblte-reqcxt-display-buf-len    cblt-x4-comp5.
          03    cblte-reqcxt-cmd-line-len       cblt-x4-comp5.
          03    cblte-reqcxt-flags              cblt-x4-comp5.
             78 78-CBLTE-REQCXT-FLGS-NEED-DISP  value h"00000001".
             78 78-CBLTE-REQCXT-FLGS-NOEXEC     value h"00000002".
          03    cblte-reqcxt-service-flags      cblt-x4-comp5.
             78 78-CBLTE-REQCXT-SFLGS-COMMIT    value h"00000001".
             78 78-CBLTE-REQCXT-SFLGS-ROLLBACK  value h"00000002".
             78 78-CBLTE-REQCXT-SFLGS-ABEND     value h"40000000".
             78 78-CBLTE-REQCXT-SFLGS-DIRTY     value h"80000000".
          03    cblte-reqcxt-reserved1          cblt-x4-comp5 occurs 10.
          03    cblte-reqcxt-align              cblt-x4-comp5.

          03    cblte-reqcxt-funcs              cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-request-buf        cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-protocol-attrs     cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-argv               cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-handler-data       cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-reserved1a         cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-service-name       cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-pgm-name           cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-epoint-name        cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-idt                cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-accept-buf         cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-display-buf        cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-cmd-line           cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-rts-err-str        cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-reqcxt-reserved2          occurs 9.
                05                              cblt-pointer.
                05                              cblt-pointer.

        01      cblt-reqhand-response           typedef.
          03    cblte-rhresp-version            cblt-x4-comp5.
             78 78-CBLTE-RHRESP-VERSION         value 0.
          03    cblte-rhresp-response-len       cblt-x4-comp5.
          03    cblte-rhresp-flags              cblt-x4-comp5.
          03    cblte-rhresp-response-type      cblt-x4-comp5.
             78 78-CBLTE-RHRESP-TYPE-NORMAL     value 0.
             78 78-CBLTE-RHRESP-TYPE-RTS-ERR    value 1.
             78 78-CBLTE-RHRESP-TYPE-RH-ERR     value 2.
             78 78-CBLTE-RHRESP-TYPE-APP-ERR    value 3.
             78 78-CBLTE-RHRESP-TYPE-PREAPP-ERR value 4.
             78 78-CBLTE-RHRESP-TYPE-FATAL-ERR  value 5.
             78 78-CBLTE-RHRESP-TYPE-ACK        value 6.
          03    cblte-rhresp-response-buf       cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-rhresp-content-type       cblt-pointer.
          03                                    cblt-pointer.

        01      cblt-reqhand-service-funcs      typedef.
          03    cblte-rhsrv-fn-version          cblt-x4-comp5.
          03    cblte-rhsrv-fn-reserved         cblt-x4-comp5.
          03    cblte-rhsrv-fn-load-service     cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-locate-exit      cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-associate    cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-init         cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-term         cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-add          cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-destroy      cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-service-info     cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-trace-info       cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhsrv-fn-reserved         occurs 8.
                05                              cblt-ppointer.
                05                              cblt-ppointer.

        01      cblt-reqhand-funcs              typedef.
          03    cblte-rhfunc-version            cblt-x4-comp5.
          03    cblte-rhfunc-reserved           cblt-x4-comp5.
          03    cblte-rhfunc-fn-start           cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhfunc-fn-response        cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhfunc-fn-end             cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhfunc-fn-load            cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhfunc-fn-unload          cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-rhfunc-fn-reserved        occurs 10.
                05                              cblt-ppointer.
                05                              cblt-ppointer.

        01      cblt-reqhand-service-info       typedef.
          03    cblte-rhapplinfo-version        cblt-x4-comp5.
          03    cblte-rhapplinfo-reserved       cblt-x4-comp5.
          03    cblte-rhapplinfo-trans-attr     cblt-x4-comp5.
          03    cblte-rhapplinfo-trans-isol     cblt-x4-comp5.
          03    cblte-rhapplinfo-cxtid-len      cblt-x4-comp5.
          03    cblte-rhapplinfo-srv-req-type   cblt-x4-comp5.
          03    cblte-rhapplinfo-reserved1      cblt-x4-comp5 occurs 10.
          03    cblte-rhapplinfo-cxtid          cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-rhapplinfo-reserved2      occurs 10.
                05                              cblt-pointer.
                05                              cblt-pointer.

        01      cblt-idp-exit-service-funcs     typedef.
          03    cblte-idpesfunc-version         cblt-x4-comp5.
          03    cblte-idpesfunc-reserved        cblt-x4-comp5.
          03    cblte-idpesfunc-fn-alloc-mem    cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-idpesfunc-fn-free-mem     cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-idpesfunc-fn-disp2utf16   cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-idpesfunc-fn-utf162disp   cblt-ppointer.
          03                                    cblt-ppointer.
          03    cblte-idpesfunc-reserved2       occurs 10.
                05                              cblt-ppointer.
                05                              cblt-ppointer.

        01      cblt-idp-exit-info              typedef.
          03    cblte-idpeinfo-version          cblt-x4-comp5.
          03    cblte-idpeinfo-flags            cblt-x4-comp5.
          03    cblte-idpeinfo-data-size        cblt-x4-comp5.
          03    cblte-idpeinfo-ext-value-size   cblt-x4-comp5.
          03    cblte-idpeinfo-reserved1        cblt-x4-comp5 occurs 10.
          03    cblte-idpeinfo-funcs            cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-idpeinfo-field-name       cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-idpeinfo-data-ptr         cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-idpeinfo-ext-param-name   cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-idpeinfo-ext-value        cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-idpeinfo-request-cxt      cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-idpeinfo-response         cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-idpeinfo-exit-data        cblt-pointer.
          03                                    cblt-pointer.
          03    cblte-idpeinfo-reserved2        occurs 10.
                05                              cblt-pointer.
                05                              cblt-pointer.
      $else
        01      cblt-request-context            typedef.
          03    cblte-reqcxt-version            cblt-x4-comp5.
             78 78-CBLTE-REQCXT-VERSION         value 0.
          03    cblte-reqcxt-handler-id         cblt-x4-comp5.
          03    cblte-reqcxt-request-len        cblt-x4-comp5.
          03    cblte-reqcxt-argc               cblt-x4-comp5.
          03    cblte-reqcxt-return-code        cblt-rtncode.
          03    cblte-reqcxt-service-type       cblt-x4-comp5.
             78 78-CBLTE-REQCXT-SRV-TYPE-PGM    value 0.
             78 78-CBLTE-REQCXT-SRV-TYPE-CICS   value 1.
             78 78-CBLTE-REQCXT-SRV-TYPE-IMS    value 2.
          03    cblte-reqcxt-accept-buf-len     cblt-x4-comp5.
          03    cblte-reqcxt-display-buf-len    cblt-x4-comp5.
          03    cblte-reqcxt-cmd-line-len       cblt-x4-comp5.
          03    cblte-reqcxt-flags              cblt-x4-comp5.
             78 78-CBLTE-REQCXT-FLGS-NEED-DISP  value h"00000001".
             78 78-CBLTE-REQCXT-FLGS-NOEXEC     value h"00000002".
             78 78-CBLTE-REQCXT-FLGS-NEXT       value h"00000004".
          03    cblte-reqcxt-service-flags      cblt-x4-comp5.
             78 78-CBLTE-REQCXT-SFLGS-COMMIT    value h"00000001".
             78 78-CBLTE-REQCXT-SFLGS-ROLLBACK  value h"00000002".
             78 78-CBLTE-REQCXT-SFLGS-ABEND     value h"40000000".
             78 78-CBLTE-REQCXT-SFLGS-DIRTY     value h"80000000".
          03    cblte-reqcxt-reserved1          cblt-x4-comp5 occurs 10.

          03    cblte-reqcxt-funcs              cblt-pointer.
          03    cblte-reqcxt-request-buf        cblt-pointer.
          03    cblte-reqcxt-protocol-attrs     cblt-pointer.
          03    cblte-reqcxt-argv               cblt-pointer.
          03    cblte-reqcxt-handler-data       cblt-pointer.
          03    cblte-reqcxt-reserved1a         cblt-pointer.
          03    cblte-reqcxt-service-name       cblt-pointer.
          03    cblte-reqcxt-pgm-name           cblt-pointer.
          03    cblte-reqcxt-epoint-name        cblt-pointer.
          03    cblte-reqcxt-idt                cblt-pointer.
          03    cblte-reqcxt-accept-buf         cblt-pointer.
          03    cblte-reqcxt-display-buf        cblt-pointer.
          03    cblte-reqcxt-cmd-line           cblt-pointer.
          03    cblte-reqcxt-rts-err-str        cblt-pointer.
          03    cblte-reqcxt-reserved2          cblt-pointer occurs 9.

        01      cblt-reqhand-response           typedef.
          03    cblte-rhresp-version            cblt-x4-comp5.
             78 78-CBLTE-RHRESP-VERSION         value 0.
          03    cblte-rhresp-response-len       cblt-x4-comp5.
          03    cblte-rhresp-flags              cblt-x4-comp5.
          03    cblte-rhresp-response-type      cblt-x4-comp5.
             78 78-CBLTE-RHRESP-TYPE-NORMAL     value 0.
             78 78-CBLTE-RHRESP-TYPE-RTS-ERR    value 1.
             78 78-CBLTE-RHRESP-TYPE-RH-ERR     value 2.
             78 78-CBLTE-RHRESP-TYPE-APP-ERR    value 3.
             78 78-CBLTE-RHRESP-TYPE-PREAPP-ERR value 4.
             78 78-CBLTE-RHRESP-TYPE-FATAL-ERR  value 5.
             78 78-CBLTE-RHRESP-TYPE-ACK        value 6.
          03    cblte-rhresp-response-buf       cblt-pointer.
          03    cblte-rhresp-content-type       cblt-pointer.

        01      cblt-reqhand-service-funcs      typedef.
          03    cblte-rhsrv-fn-version          cblt-x4-comp5.
          03    cblte-rhsrv-fn-reserved         cblt-x4-comp5.
          03    cblte-rhsrv-fn-load-service     cblt-ppointer.
          03    cblte-rhsrv-fn-locate-exit      cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-associate    cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-init         cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-term         cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-add          cblt-ppointer.
          03    cblte-rhsrv-fn-cfg-destroy      cblt-ppointer.
          03    cblte-rhsrv-fn-service-info     cblt-ppointer.
          03    cblte-rhsrv-fn-trace-info       cblt-ppointer.
          03    cblte-rhsrv-fn-reserved         cblt-ppointer occurs 8.

        01      cblt-reqhand-funcs              typedef.
          03    cblte-rhfunc-version            cblt-x4-comp5.
          03    cblte-rhfunc-reserved           cblt-x4-comp5.
          03    cblte-rhfunc-fn-start           cblt-ppointer.
          03    cblte-rhfunc-fn-response        cblt-ppointer.
          03    cblte-rhfunc-fn-end             cblt-ppointer.
          03    cblte-rhfunc-fn-load            cblt-ppointer.
          03    cblte-rhfunc-fn-unload          cblt-ppointer.
          03    cblte-rhfunc-fn-next            cblt-ppointer.
          03    cblte-rhfunc-fn-reserved        cblt-ppointer occurs 9.

        01      cblt-reqhand-service-info       typedef.
          03    cblte-rhapplinfo-version        cblt-x4-comp5.
          03    cblte-rhapplinfo-reserved       cblt-x4-comp5.
          03    cblte-rhapplinfo-trans-attr     cblt-x4-comp5.
          03    cblte-rhapplinfo-trans-isol     cblt-x4-comp5.
          03    cblte-rhapplinfo-cxtid-len      cblt-x4-comp5.
          03    cblte-rhapplinfo-srv-req-type   cblt-x4-comp5.
          03    cblte-rhapplinfo-reserved1      cblt-x4-comp5 occurs 10.
          03    cblte-rhapplinfo-cxtid          cblt-pointer.
          03    cblte-rhapplinfo-reserved2      cblt-pointer occurs 10.

        01      cblt-idp-exit-service-funcs     typedef.
          03    cblte-idpesfunc-version         cblt-x4-comp5.
          03    cblte-idpesfunc-reserved        cblt-x4-comp5.
          03    cblte-idpesfunc-fn-alloc-mem    cblt-ppointer.
          03    cblte-idpesfunc-fn-free-mem     cblt-ppointer.
          03    cblte-idpesfunc-fn-disp2utf16   cblt-ppointer.
          03    cblte-idpesfunc-fn-utf162disp   cblt-ppointer.
          03    cblte-idpesfunc-reserved2       cblt-ppointer occurs 10.

        01      cblt-idp-exit-info              typedef.
          03    cblte-idpeinfo-version          cblt-x4-comp5.
          03    cblte-idpeinfo-flags            cblt-x4-comp5.
          03    cblte-idpeinfo-data-size        cblt-x4-comp5.
          03    cblte-idpeinfo-ext-value-size   cblt-x4-comp5.
          03    cblte-idpeinfo-reserved1        cblt-x4-comp5 occurs 10.
          03    cblte-idpeinfo-funcs            cblt-pointer.
          03    cblte-idpeinfo-field-name       cblt-pointer.
          03    cblte-idpeinfo-data-ptr         cblt-pointer.
          03    cblte-idpeinfo-ext-param-name   cblt-pointer.
          03    cblte-idpeinfo-ext-value        cblt-pointer.
          03    cblte-idpeinfo-request-cxt      cblt-pointer.
          03    cblte-idpeinfo-response         cblt-pointer.
          03    cblte-idpeinfo-exit-data        cblt-pointer.
          03    cblte-idpeinfo-reserved2        cblt-pointer occurs 10.
      $end
      *>
      *> Definitions used by the PC_WIN_ routines.
      *>
       01       cblt-HWND       cblt-os-size    typedef.
       01       cblt-HINSTANCE  cblt-os-size    typedef.
      *>
      *> Structures used by PC_PRINT routines
      *>
       01       cblt-printer-name               typedef.
          03    cblte-pn-name-length            cblt-x2-comp5.
          03    cblte-pn-name                   cblt-x1. *> Occurs depending on
                                                         *> cblte-pn-name-length

       01       cblt-printer-properties         typedef.
          03    cblte-pp-length                 cblt-x2-comp5.
          03    cblte-pp-papersize              cblt-sx2-comp5.
          03    cblte-pp-paperlength            cblt-sx2-comp5.
          03    cblte-pp-paperwidth             cblt-sx2-comp5.
          03    cblte-pp-scale                  cblt-sx2-comp5.
          03    cblte-pp-copies                 cblt-sx2-comp5.
          03    cblte-pp-papertray              cblt-sx2-comp5.
          03    cblte-pp-printquality           cblt-sx2-comp5.
          03    cblte-pp-color                  cblt-sx2-comp5.
          03    cblte-pp-duplex                 cblt-sx2-comp5.
          03    cblte-pp-orientation            cblt-sx2-comp5.
          03    cblte-pp-yresolution            cblt-sx2-comp5.

       01       cblt-printer-info               typedef.
          03    cblte-pi-struct-size            cblt-os-size.
          03    cblte-pi-printer-hdc            cblt-pointer.
          03    cblte-pi-printer-hps            cblt-os-size.
          03    cblte-pi-printer-orientation    cblt-x4-comp5.
          03    cblte-pi-printer-rows           cblt-x4-comp5.
          03    cblte-pi-printer-cols           cblt-x4-comp5.
          03    cblte-pi-printer-rowsleft       cblt-x4-comp5.
          03    cblte-pi-printer-max-horiz      cblt-x4-comp5.
          03    cblte-pi-printer-max-vert       cblt-x4-comp5.
          03    cblte-pi-printer-min-horiz      cblt-x4-comp5.
          03    cblte-pi-printer-min-vert       cblt-x4-comp5.
          03    cblte-pi-printer-curr-horiz     cblt-x4-comp5.
          03    cblte-pi-printer-curr-vert      cblt-x4-comp5.

          03    cblte-pi-printer-copies         cblt-x2-comp5.
          03    cblte-pi-printer-quality        cblt-x2-comp5.

          03    cblte-pi-printer-color          cblt-x1-comp5.
          03    cblte-pi-reserved-item1         cblt-x1-comp5.

          03    cblte-pi-printer-device-ver     cblt-x2-comp5.
          03    cblte-pi-printer-name.
            05  cblte-pi-printer-pname-size     cblt-os-size.
            05  cblte-pi-printer-pname          cblt-pointer.
          03    cblte-pi-printer-type.
            05  cblte-pi-printer-ptype-size     cblt-os-size.
            05  cblte-pi-printer-ptype          cblt-pointer.
          03    cblte-pi-printer-device.
            05  cblte-pi-printer-pdevice-size   cblt-os-size.
            05  cblte-pi-printer-pdevice        cblt-pointer.
          03    cblte-pi-printer-location.
            05  cblte-pi-printer-plocation-size cblt-os-size.
            05  cblte-pi-printer-plocation      cblt-pointer.
          03    cblte-pi-printer-comment.
            05  cblte-pi-printer-pcomment-size  cblt-os-size.
            05  cblte-pi-printer-pcomment       cblt-pointer.
          03    cblte-pi-printer-papersize.
            05  cblte-pi-printer-ppapersiz-size cblt-os-size.
            05  cblte-pi-printer-ppapersiz      cblt-pointer.

       01       cblt-printer-default            typedef.
         03     cblte-pd-printer-name.
           05   cblte-pd-printer-name-length    cblt-x2-comp5.
           05   cblte-pd-printer-name           cblt-x1. *> Occurs depending on
                                                         *> cblte-pd-printer-name-length.
         03     cblte-pd-printer-browse REDEFINES 
                                        cblte-pd-printer-name.
           05   cblte-pd-printer-browse-hwnd    cblt-HWND.
           05   cblte-pd-printer-browse-namelen    cblt-x2-comp5.
           05   cblte-pd-reserved               cblt-x2-comp5.
           05   cblte-pd-printer-browse-name    cblt-x1. *> Occurs depending on
                                                         *> cblte-pd-printer-browse-namelen.

      *>
      *> Structure used by CBL_MEM_VALIDATE
      *>
       01       cblt-mem-validate-param         typedef.
          03    cblte-mv-version                cblt-x4-comp5.
          03    cblte-mv-flags                  cblt-x4-comp5.
          03    cblte-mv-type                   cblt-x4-comp5.
          03    cblte-mv-size                   cblt-os-size.
          03    cblte-mv-address                cblt-pointer.

      *>
      *> Structure used by CBL_GET_FILE_SYSTEM_INFO
      *>
       01       cblt-fs-info-param              typedef.
          03    cblte-fsi-version               cblt-x4-comp5.
          03    cblte-fsi-block-len             cblt-x4-comp5.
          03    cblte-fsi-free-space            cblt-x8-comp5.
          03    cblte-fsi-total-space           cblt-x8-comp5.
          03    cblte-fsi-available-free-space  cblt-x8-comp5.
          03    cblte-fsi-capabilities          cblt-x4-comp5.
