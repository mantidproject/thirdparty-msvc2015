// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus_HeaderFile
#define _BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus.hxx>

#include <TopoDS_Shape.hxx>
#include <BRepCheck_ListOfStatus.hxx>
#include <TCollection_MapNode.hxx>
#include <TCollection_MapNodePtr.hxx>
class TopoDS_Shape;
class BRepCheck_ListOfStatus;
class TopTools_ShapeMapHasher;
class BRepCheck_DataMapOfShapeListOfStatus;
class BRepCheck_DataMapIteratorOfDataMapOfShapeListOfStatus;



class BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus : public TCollection_MapNode
{

public:

  
    BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus(const TopoDS_Shape& K, const BRepCheck_ListOfStatus& I, const TCollection_MapNodePtr& n);
  
      TopoDS_Shape& Key()  const;
  
      BRepCheck_ListOfStatus& Value()  const;




  DEFINE_STANDARD_RTTI(BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus)

protected:




private: 


  TopoDS_Shape myKey;
  BRepCheck_ListOfStatus myValue;


};

#define TheKey TopoDS_Shape
#define TheKey_hxx <TopoDS_Shape.hxx>
#define TheItem BRepCheck_ListOfStatus
#define TheItem_hxx <BRepCheck_ListOfStatus.hxx>
#define Hasher TopTools_ShapeMapHasher
#define Hasher_hxx <TopTools_ShapeMapHasher.hxx>
#define TCollection_DataMapNode BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus
#define TCollection_DataMapNode_hxx <BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus.hxx>
#define TCollection_DataMapIterator BRepCheck_DataMapIteratorOfDataMapOfShapeListOfStatus
#define TCollection_DataMapIterator_hxx <BRepCheck_DataMapIteratorOfDataMapOfShapeListOfStatus.hxx>
#define Handle_TCollection_DataMapNode Handle_BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus
#define TCollection_DataMapNode_Type_() BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus_Type_()
#define TCollection_DataMap BRepCheck_DataMapOfShapeListOfStatus
#define TCollection_DataMap_hxx <BRepCheck_DataMapOfShapeListOfStatus.hxx>

#include <TCollection_DataMapNode.lxx>

#undef TheKey
#undef TheKey_hxx
#undef TheItem
#undef TheItem_hxx
#undef Hasher
#undef Hasher_hxx
#undef TCollection_DataMapNode
#undef TCollection_DataMapNode_hxx
#undef TCollection_DataMapIterator
#undef TCollection_DataMapIterator_hxx
#undef Handle_TCollection_DataMapNode
#undef TCollection_DataMapNode_Type_
#undef TCollection_DataMap
#undef TCollection_DataMap_hxx




#endif // _BRepCheck_DataMapNodeOfDataMapOfShapeListOfStatus_HeaderFile