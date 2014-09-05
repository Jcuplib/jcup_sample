include ../Mkinclude

# JINTPOBJ is defined in ../Mkinclude as follows;
# JINTPOBJ=interpolate_data.o


OBJS = field_def.o jcup_interpolation_sample.o
MODS = component_field.mod  field_common.mod  field_def.mod  jcup_interpolation_sample.mod

all: lib

lib: $(LIBDIR) $(INCDIR) $(LIBDIR)/$(COMMONLIB) $(LIBDIR)/$(JINTPOBJ)

$(LIBDIR)/$(COMMONLIB): $(OBJS) 
	$(AR) $(ARFLAGS) $@ $(OBJS)
	$(INSTALL) $(MODS) $(INCDIR)

$(LIBDIR)/$(JINTPOBJ): $(JINTPOBJ)
	$(INSTALL) $(JINTPOBJ) $(LIBDIR)

$(LIBDIR) $(INCDIR):
	mkdir -p $@

clean:
	$(RM) $(TRASH)
realclean: clean

$(JINTPOBJ): jcup_interpolation_sample.o
