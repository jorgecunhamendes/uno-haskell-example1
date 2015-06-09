# Set these:
# LO_INSTDIR :=

.DELETE_ON_ERROR:

LDPATH=LD_LIBRARY_PATH=$(LO_INSTDIR)/program

HSFILES= Main.hs Text.hs \
				 SAL/Types.hs \
				 UNO/Binary.hs \
				 UNO/Service.hs \
				 LibreOffice/Util/TheMacroExpander.hs \
				 LibreOffice/Util/XMacroExpander.hs

OBJECTS= out/Text.cpp_o \
				 out/UNO/Binary.cpp_o \
				 out/LibreOffice/Util/XMacroExpander.cpp_o \
				 out/LibreOffice/Util/TheMacroExpander.cpp_o

.PHONY : compile run debug repl clean cleanall

# compile the program
compile : Main

# run the program
run :
	$(LDPATH) ./Main

# start gdb
debug :
	$(LDPATH) gdb ./Main

# run an Haskell interpreter
repl :
	$(LDPATH) ghci Main.hs $(OBJECTS)

# remove intermediate files
clean:
	-rm -r out

# remove all generated files
cleanall : clean
	-rm Main

# program target
Main : $(HSFILES) $(OBJECTS) | out
	$(LDPATH) ghc -W -Wall -debug -o $@ $^ \
    -odir out -hidir out \
    -no-user-package-db -package-db `find .cabal-sandbox -name '*.conf.d'` \
    -L"$(LO_INSTDIR)/sdk/lib" \
    -lstdc++ -luno_cppu -luno_cppuhelpergcc3 -luno_sal

# C++ file compilation
out/%.cpp_o : %.cc out/cpputypes.cppumaker.flag | out
	g++ -c -g -o $@ $< \
    -DCPPU_ENV=gcc3 -DHAVE_GCC_VISIBILITY_FEATURE -DLINUX -DUNX \
    -I"$(LO_INSTDIR)/sdk/include" -I out/include/cpputypes

# C++ file dependencies
out/UNO/Binary.cpp_o : UNO/Binary.cc UNO/Binary.hxx
out/Text.cpp_o : Text.cc Text.h
out/LibreOffice/Util/XMacroExpander.cpp_o : LibreOffice/Util/XMacroExpander.cc LibreOffice/Util/XMacroExpander.h UNO/Binary.hxx
out/LibreOffice/Util/TheMacroExpander.cpp_o : LibreOffice/Util/TheMacroExpander.cc LibreOffice/Util/TheMacroExpander.h LibreOffice/Util/XMacroExpander.h

# UNO SDK types
out/cpputypes.cppumaker.flag: | out
	$(LDPATH) $(LO_INSTDIR)/sdk/bin/cppumaker \
            -O./out/include/cpputypes \
            '-Tcom.sun.star.beans.Introspection;com.sun.star.beans.theIntrospection;com.sun.star.bridge.BridgeFactory;com.sun.star.bridge.UnoUrlResolver;com.sun.star.connection.Acceptor;com.sun.star.connection.Connector;com.sun.star.io.Pipe;com.sun.star.io.TextInputStream;com.sun.star.io.TextOutputStream;com.sun.star.java.JavaVirtualMachine;com.sun.star.lang.DisposedException;com.sun.star.lang.EventObject;com.sun.star.lang.XMain;com.sun.star.lang.XMultiComponentFactory;com.sun.star.lang.XMultiServiceFactory;com.sun.star.lang.XSingleComponentFactory;com.sun.star.lang.XSingleServiceFactory;com.sun.star.lang.XTypeProvider;com.sun.star.loader.Java;com.sun.star.loader.SharedLibrary;com.sun.star.reflection.ProxyFactory;com.sun.star.registry.ImplementationRegistration;com.sun.star.registry.SimpleRegistry;com.sun.star.registry.XRegistryKey;com.sun.star.script.Converter;com.sun.star.script.Invocation;com.sun.star.security.AccessController;com.sun.star.security.Policy;com.sun.star.uno.DeploymentException;com.sun.star.uno.Exception;com.sun.star.uno.NamingService;com.sun.star.uno.RuntimeException;com.sun.star.uno.XAggregation;com.sun.star.uno.XComponentContext;com.sun.star.uno.XCurrentContext;com.sun.star.uno.XInterface;com.sun.star.uno.XWeak;com.sun.star.uri.ExternalUriReferenceTranslator;com.sun.star.uri.UriReferenceFactory;com.sun.star.uri.VndSunStarPkgUrlReferenceFactory;com.sun.star.util.theMacroExpander' \
            $(LO_INSTDIR)/program/types.rdb
	touch $@

# intermediary files output directory
out:
	mkdir $@
	mkdir -p out/UNO
	mkdir -p out/SAL
	mkdir -p out/LibreOffice/Util
