// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _PNaming_VArrayTNodeOfFieldOfHArray1OfNamedShape_HeaderFile
#define _PNaming_VArrayTNodeOfFieldOfHArray1OfNamedShape_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <Handle_PNaming_NamedShape.hxx>
#include <Handle_PNaming_VArrayNodeOfFieldOfHArray1OfNamedShape.hxx>
#include <Standard_Address.hxx>
class PNaming_NamedShape;
class PNaming_FieldOfHArray1OfNamedShape;
class PNaming_VArrayNodeOfFieldOfHArray1OfNamedShape;



class PNaming_VArrayTNodeOfFieldOfHArray1OfNamedShape 
{
public:

  DEFINE_STANDARD_ALLOC

  
    PNaming_VArrayTNodeOfFieldOfHArray1OfNamedShape();
  
    PNaming_VArrayTNodeOfFieldOfHArray1OfNamedShape(const Handle(PNaming_NamedShape)& aValue);
  
      void SetValue (const Handle(PNaming_NamedShape)& aValue) ;
  
      Standard_Address Value()  const;




protected:





private:



  Handle(PNaming_NamedShape) myValue;


};

#define Item Handle(PNaming_NamedShape)
#define Item_hxx <PNaming_NamedShape.hxx>
#define DBC_VArrayNode PNaming_VArrayNodeOfFieldOfHArray1OfNamedShape
#define DBC_VArrayNode_hxx <PNaming_VArrayNodeOfFieldOfHArray1OfNamedShape.hxx>
#define DBC_VArrayTNode PNaming_VArrayTNodeOfFieldOfHArray1OfNamedShape
#define DBC_VArrayTNode_hxx <PNaming_VArrayTNodeOfFieldOfHArray1OfNamedShape.hxx>
#define Handle_DBC_VArrayNode Handle_PNaming_VArrayNodeOfFieldOfHArray1OfNamedShape
#define DBC_VArrayNode_Type_() PNaming_VArrayNodeOfFieldOfHArray1OfNamedShape_Type_()
#define DBC_VArray PNaming_FieldOfHArray1OfNamedShape
#define DBC_VArray_hxx <PNaming_FieldOfHArray1OfNamedShape.hxx>

#include <DBC_VArrayTNode.lxx>

#undef Item
#undef Item_hxx
#undef DBC_VArrayNode
#undef DBC_VArrayNode_hxx
#undef DBC_VArrayTNode
#undef DBC_VArrayTNode_hxx
#undef Handle_DBC_VArrayNode
#undef DBC_VArrayNode_Type_
#undef DBC_VArray
#undef DBC_VArray_hxx




#endif // _PNaming_VArrayTNodeOfFieldOfHArray1OfNamedShape_HeaderFile