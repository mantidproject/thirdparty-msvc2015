// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember_HeaderFile
#define _StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <Standard_Integer.hxx>
#include <Standard_Address.hxx>
#include <Standard_Boolean.hxx>
#include <Handle_StepElement_HSequenceOfSurfaceElementPurposeMember.hxx>
class Standard_RangeError;
class Standard_DimensionMismatch;
class Standard_OutOfRange;
class Standard_OutOfMemory;
class StepElement_HSequenceOfSurfaceElementPurposeMember;



class StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember 
{
public:

  DEFINE_STANDARD_ALLOC

  
    StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember(const Standard_Integer Low, const Standard_Integer Up);
  
    StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember(const Handle(StepElement_HSequenceOfSurfaceElementPurposeMember)& Item, const Standard_Integer Low, const Standard_Integer Up);
  
  Standard_EXPORT   void Init (const Handle(StepElement_HSequenceOfSurfaceElementPurposeMember)& V) ;
  
      void Destroy() ;
~StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember()
{
  Destroy();
}
  
      Standard_Boolean IsAllocated()  const;
  
  Standard_EXPORT  const  StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember& Assign (const StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember& Other) ;
 const  StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember& operator = (const StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember& Other) 
{
  return Assign(Other);
}
  
      Standard_Integer Length()  const;
  
      Standard_Integer Lower()  const;
  
      Standard_Integer Upper()  const;
  
      void SetValue (const Standard_Integer Index, const Handle(StepElement_HSequenceOfSurfaceElementPurposeMember)& Value) ;
  
     const  Handle(StepElement_HSequenceOfSurfaceElementPurposeMember)& Value (const Standard_Integer Index)  const;
   const  Handle(StepElement_HSequenceOfSurfaceElementPurposeMember)& operator () (const Standard_Integer Index)  const
{
  return Value(Index);
}
  
      Handle(StepElement_HSequenceOfSurfaceElementPurposeMember)& ChangeValue (const Standard_Integer Index) ;
    Handle(StepElement_HSequenceOfSurfaceElementPurposeMember)& operator () (const Standard_Integer Index) 
{
  return ChangeValue(Index);
}




protected:





private:

  
  Standard_EXPORT StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember(const StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember& AnArray);


  Standard_Integer myLowerBound;
  Standard_Integer myUpperBound;
  Standard_Address myStart;
  Standard_Boolean isAllocated;


};

#define Array1Item Handle(StepElement_HSequenceOfSurfaceElementPurposeMember)
#define Array1Item_hxx <StepElement_HSequenceOfSurfaceElementPurposeMember.hxx>
#define TCollection_Array1 StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember
#define TCollection_Array1_hxx <StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember.hxx>

#include <TCollection_Array1.lxx>

#undef Array1Item
#undef Array1Item_hxx
#undef TCollection_Array1
#undef TCollection_Array1_hxx




#endif // _StepElement_Array1OfHSequenceOfSurfaceElementPurposeMember_HeaderFile