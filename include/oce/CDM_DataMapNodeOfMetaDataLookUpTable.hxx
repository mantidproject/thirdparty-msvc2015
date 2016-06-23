// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _CDM_DataMapNodeOfMetaDataLookUpTable_HeaderFile
#define _CDM_DataMapNodeOfMetaDataLookUpTable_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_CDM_DataMapNodeOfMetaDataLookUpTable.hxx>

#include <TCollection_ExtendedString.hxx>
#include <Handle_CDM_MetaData.hxx>
#include <TCollection_MapNode.hxx>
#include <TCollection_MapNodePtr.hxx>
class CDM_MetaData;
class TCollection_ExtendedString;
class CDM_MetaDataLookUpTable;
class CDM_DataMapIteratorOfMetaDataLookUpTable;



class CDM_DataMapNodeOfMetaDataLookUpTable : public TCollection_MapNode
{

public:

  
    CDM_DataMapNodeOfMetaDataLookUpTable(const TCollection_ExtendedString& K, const Handle(CDM_MetaData)& I, const TCollection_MapNodePtr& n);
  
      TCollection_ExtendedString& Key()  const;
  
      Handle(CDM_MetaData)& Value()  const;




  DEFINE_STANDARD_RTTI(CDM_DataMapNodeOfMetaDataLookUpTable)

protected:




private: 


  TCollection_ExtendedString myKey;
  Handle(CDM_MetaData) myValue;


};

#define TheKey TCollection_ExtendedString
#define TheKey_hxx <TCollection_ExtendedString.hxx>
#define TheItem Handle(CDM_MetaData)
#define TheItem_hxx <CDM_MetaData.hxx>
#define Hasher TCollection_ExtendedString
#define Hasher_hxx <TCollection_ExtendedString.hxx>
#define TCollection_DataMapNode CDM_DataMapNodeOfMetaDataLookUpTable
#define TCollection_DataMapNode_hxx <CDM_DataMapNodeOfMetaDataLookUpTable.hxx>
#define TCollection_DataMapIterator CDM_DataMapIteratorOfMetaDataLookUpTable
#define TCollection_DataMapIterator_hxx <CDM_DataMapIteratorOfMetaDataLookUpTable.hxx>
#define Handle_TCollection_DataMapNode Handle_CDM_DataMapNodeOfMetaDataLookUpTable
#define TCollection_DataMapNode_Type_() CDM_DataMapNodeOfMetaDataLookUpTable_Type_()
#define TCollection_DataMap CDM_MetaDataLookUpTable
#define TCollection_DataMap_hxx <CDM_MetaDataLookUpTable.hxx>

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




#endif // _CDM_DataMapNodeOfMetaDataLookUpTable_HeaderFile