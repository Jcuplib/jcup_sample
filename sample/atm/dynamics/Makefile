include ../../Mkinclude

COMPO	= dynamics
OBJS	= $(COMPO).o
MODS	= $(COMPO).mod
LIB	= $(DYNLIB)

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

# $(COMPO).o: $(LIBDIR)/$(COMMONLIB) $(LIBDIR)/$(JINTPOBJ)

### Is below necessary/suitable ?
$(LIBDIR)/$(COMMONLIB) $(LIBDIR)/$(JINTPOBJ):
	$(MAKE) -C $(COMMONDIR)
