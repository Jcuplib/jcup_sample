include ../Mkinclude

COMPO	= chm
OBJS	= $(COMPO).o
MODS	= mod_$(COMPO).mod
LIB	= $(CHMLIB)


all: lib

lib: $(LIBDIR) $(INCDIR) $(LIBDIR)/$(LIB)

$(LIBDIR)/$(LIB): $(OBJS) 
	$(AR) $(ARFLAGS) $@ $^
	$(INSTALL) $(MODS) $(INCDIR)

$(LIBDIR) $(INCDIR):
	mkdir -p $@

clean:
	$(RM) $(TRASH)
realclean: clean

$(COMPO).o: $(LIBDIR)/$(COMMONLIB) $(LIBDIR)/$(JINTPOBJ)

### Is below necessary/suitable ?
$(LIBDIR)/$(COMMONLIB) $(LIBDIR)/$(JINTPOBJ):
	$(MAKE) -C $(COMMONDIR)
