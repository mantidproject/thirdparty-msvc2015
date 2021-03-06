// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs_HeaderFile
#define _StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs.hxx>

#include <Handle_SelectBasics_EntityOwner.hxx>
#include <Standard_Integer.hxx>
#include <Handle_StdSelect_Prs.hxx>
#include <TCollection_MapNodePtr.hxx>
#include <TCollection_MapNode.hxx>
class SelectBasics_EntityOwner;
class StdSelect_Prs;
class TColStd_MapTransientHasher;
class StdSelect_IndexedDataMapOfOwnerPrs;



class StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs : public TCollection_MapNode
{

public:

  
    StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs(const Handle(SelectBasics_EntityOwner)& K1, const Standard_Integer K2, const Handle(StdSelect_Prs)& I, const TCollection_MapNodePtr& n1, const TCollection_MapNodePtr& n2);
  
      Handle(SelectBasics_EntityOwner)& Key1()  const;
  
      Standard_Integer& Key2()  const;
  
      TCollection_MapNodePtr& Next2()  const;
  
      Handle(StdSelect_Prs)& Value()  const;




  DEFINE_STANDARD_RTTI(StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs)

protected:




private: 


  Handle(SelectBasics_EntityOwner) myKey1;
  Standard_Integer myKey2;
  Handle(StdSelect_Prs) myValue;
  TCollection_MapNodePtr myNext2;


};

#define TheKey Handle(SelectBasics_EntityOwner)
#define TheKey_hxx <SelectBasics_EntityOwner.hxx>
#define TheItem Handle(StdSelect_Prs)
#define TheItem_hxx <StdSelect_Prs.hxx>
#define Hasher TColStd_MapTransientHasher
#define Hasher_hxx <TColStd_MapTransientHasher.hxx>
#define TCollection_IndexedDataMapNode StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs
#define TCollection_IndexedDataMapNode_hxx <StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs.hxx>
#define Handle_TCollection_IndexedDataMapNode Handle_StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs
#define TCollection_IndexedDataMapNode_Type_() StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs_Type_()
#define TCollection_IndexedDataMap StdSelect_IndexedDataMapOfOwnerPrs
#define TCollection_IndexedDataMap_hxx <StdSelect_IndexedDataMapOfOwnerPrs.hxx>

#include <TCollection_IndexedDataMapNode.lxx>

#undef TheKey
#undef TheKey_hxx
#undef TheItem
#undef TheItem_hxx
#undef Hasher
#undef Hasher_hxx
#undef TCollection_IndexedDataMapNode
#undef TCollection_IndexedDataMapNode_hxx
#undef Handle_TCollection_IndexedDataMapNode
#undef TCollection_IndexedDataMapNode_Type_
#undef TCollection_IndexedDataMap
#undef TCollection_IndexedDataMap_hxx




#endif // _StdSelect_IndexedDataMapNodeOfIndexedDataMapOfOwnerPrs_HeaderFile
