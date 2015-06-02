# Set these:
# LO_INSTDIR :=

.DELETE_ON_ERROR:

.PHONY: test
test: out/expand
	LD_LIBRARY_PATH=$(LO_INSTDIR)/program out/expand

.PHONY: clean
clean:
	rm -r out

out/expand: expand.cc out/cpputypes.cppumaker.flag | out
	LD_LIBRARY_PATH=$(LO_INSTDIR)/program g++ -g -o $@ expand.cc \
         -DCPPU_ENV=gcc3 -DHAVE_GCC_VISIBILITY_FEATURE -DLINUX -DUNX \
         -I $(LO_INSTDIR)/sdk/include -I out/include/cpputypes \
         -L$(LO_INSTDIR)/sdk/lib -luno_cppu -luno_cppuhelpergcc3 -luno_sal

out/cpputypes.cppumaker.flag: | out
	LD_LIBRARY_PATH=$(LO_INSTDIR)/program $(LO_INSTDIR)/sdk/bin/cppumaker \
            -O./out/include/cpputypes \
            '-Tcom.sun.star.beans.Introspection;com.sun.star.beans.theIntrospection;com.sun.star.bridge.BridgeFactory;com.sun.star.bridge.UnoUrlResolver;com.sun.star.connection.Acceptor;com.sun.star.connection.Connector;com.sun.star.io.Pipe;com.sun.star.io.TextInputStream;com.sun.star.io.TextOutputStream;com.sun.star.java.JavaVirtualMachine;com.sun.star.lang.DisposedException;com.sun.star.lang.EventObject;com.sun.star.lang.XMain;com.sun.star.lang.XMultiComponentFactory;com.sun.star.lang.XMultiServiceFactory;com.sun.star.lang.XSingleComponentFactory;com.sun.star.lang.XSingleServiceFactory;com.sun.star.lang.XTypeProvider;com.sun.star.loader.Java;com.sun.star.loader.SharedLibrary;com.sun.star.reflection.ProxyFactory;com.sun.star.registry.ImplementationRegistration;com.sun.star.registry.SimpleRegistry;com.sun.star.registry.XRegistryKey;com.sun.star.script.Converter;com.sun.star.script.Invocation;com.sun.star.security.AccessController;com.sun.star.security.Policy;com.sun.star.uno.DeploymentException;com.sun.star.uno.Exception;com.sun.star.uno.NamingService;com.sun.star.uno.RuntimeException;com.sun.star.uno.XAggregation;com.sun.star.uno.XComponentContext;com.sun.star.uno.XCurrentContext;com.sun.star.uno.XInterface;com.sun.star.uno.XWeak;com.sun.star.uri.ExternalUriReferenceTranslator;com.sun.star.uri.UriReferenceFactory;com.sun.star.uri.VndSunStarPkgUrlReferenceFactory;com.sun.star.util.theMacroExpander' \
            $(LO_INSTDIR)/program/types.rdb
	touch $@

out:
	mkdir $@
