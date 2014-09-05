include ../Mkinclude


TARGETS		= atm_driver ocn_driver chm_driver


LIBS4ATM 	= $(LIBDIR)/$(ATMLIB) $(LIBDIR)/$(DYNLIB) $(LIBDIR)/$(LANDLIB) $(LIBDIR)/$(COMMONLIB)
LIBS4OCN 	= $(LIBDIR)/$(OCNLIB) $(LIBDIR)/$(ICELIB) $(LIBDIR)/$(COMMONLIB)
LIBS4CHM	= $(LIBDIR)/$(CHMLIB) $(LIBDIR)/$(COMMONLIB)

all: $(TARGETS) $(BINDIR)
	$(INSTALL) $(TARGETS) $(BINDIR)
clean:
	$(RM) $(TRASH)
realclean: clean
	$(RM) $(TARGETS)

atm_driver: atm_driver.o
	$(LINK.f90) -o $@ $^  $(LIBS4ATM)  -L$(JCUPLIBDIR) -ljcup $(LIBDIR)/$(JINTPOBJ)

ocn_driver: ocn_driver.o
	$(LINK.f90) -o $@ $^  $(LIBS4OCN)  -L$(JCUPLIBDIR) -ljcup $(LIBDIR)/$(JINTPOBJ)

chm_driver: chm_driver.o
	$(LINK.f90) -o $@ $^  $(LIBS4CHM)  -L$(JCUPLIBDIR) -ljcup $(LIBDIR)/$(JINTPOBJ)



$(BINDIR):
	mkdir -p $@
