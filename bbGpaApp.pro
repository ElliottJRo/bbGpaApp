APP_NAME = bbGpaApp
TARGET= bbGpaApp

CONFIG += qt warn_on cascades10
LIBS   += -lbbdata
LIBS += -lbbplatformbbm
LIBS += -lbbsystem
LIBS += -lbb
LIBS += -lbbcascadesadvertisement


include(config.pri)
