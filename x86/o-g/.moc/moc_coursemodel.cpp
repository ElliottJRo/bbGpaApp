/****************************************************************************
** Meta object code from reading C++ file 'coursemodel.h'
**
** Created by: The Qt Meta Object Compiler version 63 (Qt 4.8.5)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../../src/coursedata/coursemodel.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'coursemodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.5. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_CourseModel[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       3,   64, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: signature, parameters, type, tag, flags
      20,   13,   12,   12, 0x05,
      57,   43,   12,   12, 0x05,
     100,   87,   12,   12, 0x05,

 // slots: signature, parameters, type, tag, flags
     150,  126,   12,   12, 0x0a,
     196,  182,   12,   12, 0x0a,
     238,  228,   12,   12, 0x0a,
     279,  261,   12,   12, 0x0a,
     312,  228,   12,   12, 0x0a,
     337,   12,   12,   12, 0x0a,
     347,   12,   12,   12, 0x0a,

 // properties: name, type, flags
      13,  361, 0x0a495103,
      43,  361, 0x0a495103,
      87,  369, 0x01495001,

 // properties: notify_signal_id
       0,
       1,
       2,

       0        // eod
};

static const char qt_meta_stringdata_CourseModel[] = {
    "CourseModel\0\0filter\0filterChanged(QString)\0"
    "jsonAssetPath\0jsonAssetPathChanged(QString)\0"
    "courseIsFull\0courseIsFullChanged(bool)\0"
    "selectionList,newStatus\0"
    "setStatus(QVariantList,QString)\0"
    "selectionList\0deleteCourseItems(QVariantList)\0"
    "itemTitle\0addCourseItem(QString)\0"
    "item,newItemTitle\0editCourseItem(QVariant,QString)\0"
    "shareCourseItem(QString)\0onArmed()\0"
    "deleteLater()\0QString\0bool\0"
};

void CourseModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        CourseModel *_t = static_cast<CourseModel *>(_o);
        switch (_id) {
        case 0: _t->filterChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 1: _t->jsonAssetPathChanged((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->courseIsFullChanged((*reinterpret_cast< bool(*)>(_a[1]))); break;
        case 3: _t->setStatus((*reinterpret_cast< const QVariantList(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 4: _t->deleteCourseItems((*reinterpret_cast< const QVariantList(*)>(_a[1]))); break;
        case 5: _t->addCourseItem((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 6: _t->editCourseItem((*reinterpret_cast< const QVariant(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 7: _t->shareCourseItem((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 8: _t->onArmed(); break;
        case 9: _t->deleteLater(); break;
        default: ;
        }
    }
}

const QMetaObjectExtraData CourseModel::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject CourseModel::staticMetaObject = {
    { &CourseListModel::staticMetaObject, qt_meta_stringdata_CourseModel,
      qt_meta_data_CourseModel, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &CourseModel::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *CourseModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *CourseModel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_CourseModel))
        return static_cast<void*>(const_cast< CourseModel*>(this));
    return CourseListModel::qt_metacast(_clname);
}

int CourseModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = CourseListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = filter(); break;
        case 1: *reinterpret_cast< QString*>(_v) = jsonAssetPath(); break;
        case 2: *reinterpret_cast< bool*>(_v) = courseIsFull(); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setFilter(*reinterpret_cast< QString*>(_v)); break;
        case 1: setJsonAssetPath(*reinterpret_cast< QString*>(_v)); break;
        }
        _id -= 3;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 3;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 3;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void CourseModel::filterChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void CourseModel::jsonAssetPathChanged(QString _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void CourseModel::courseIsFullChanged(bool _t1)
{
    void *_a[] = { 0, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_END_MOC_NAMESPACE
