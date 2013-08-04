APP_NAME = bbGpaApp

CONFIG += qt warn_on cascades10
LIBS   += -lbbdata
LIBS += -lbbplatformbbm

include(config.pri)

# Add qml subfolders and relevant cpp files for translation 
lupdate_inclusion {
  SOURCES +=  $$quote($$BASEDIR/../src/coursebbm/*.c) \
             $$quote($$BASEDIR/../src/coursebbm/*.cpp) \
             $$quote($$BASEDIR/../assets/items/*.qml) 

  HEADERS +=  $$quote($$BASEDIR/../src/coursebbm/*.h) \
             $$quote($$BASEDIR/../src/coursebbm/*.hpp)
}