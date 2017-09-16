#*****************************************************************************
#* 
#*  @file          Makefile
#*
#*                 SWARCO Traffic Systems Embedded-Linux
#*
#*  @par Program:  User mode utilities
#*
#*  @version       1.0 (\$Revision$)
#*  @author        Guido Classen
#*                 SWARCO Traffic Systems GmbH
#* 
#*  $LastChangedBy$  
#*  $Date$
#*  $URL$
#*
#*  @par Modification History:
#*   2007-02-05 gc: initial version
#*
#*  @par Makefile calls:
#*
#*  Build: 
#*   make 
#*
#*****************************************************************************

# BASE_DIR = $(CURDIR)/..
# include	$(BASE_DIR)/version.mk
# include	$(BASE_DIR)/directories.mk

MY_CFLAGS         = $(CFLAGS) -I.
MY_LDFLAGS         = $(LDFLAGS) -lpthread -lutil
CH_CONFIG_DIR      = $(TARGET_DIR)
PROGRAMS = ccm2200_gpio_test ccm2200_watchdog ccm2200_serial forward rw \
	   file_write_test wlogin led_blinkd modemstatus-wait \
	   dcf77

.PHONY: all
all: $(PROGRAMS) install


.PHONY: install
install:
	cp -a $(PROGRAMS) $(CH_CONFIG_DIR)/usr/bin
	-test -e $(CH_CONFIG_DIR)/usr/bin/ro && rm $(CH_CONFIG_DIR)/usr/bin/ro
	ln -s rw $(CH_CONFIG_DIR)/usr/bin/ro 


#simple pattern rule to compile executables from just one source file!
%:	%.c
	$(CROSS_CC) -o$@ $(MY_CFLAGS) $(MY_LDFLAGS) $<
	$(CROSS_STRIP) $@

#2016-04-01 gc: huaweiAktBbo is now replaced by usb_modeswitch which works for switch
#               all devices ( huaweiAktBbo only works for Huawei E220, E230, E270, E870)
# huaweiAktBbo:	huaweiAktBbo.c
# 	$(CROSS_CC) -o$@ $(MY_CFLAGS) $(MY_LDFLAGS) $< -lusb
# 	$(CROSS_STRIP) $@


.PHONY: clean
clean:
	-rm *.o
	-rm $(PROGRAMS)

# Local Variables:
# mode: makefile
# compile-command: "make"
# End:
