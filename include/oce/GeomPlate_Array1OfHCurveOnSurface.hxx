// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _GeomPlate_Array1OfHCurveOnSurface_HeaderFile
#define _GeomPlate_Array1OfHCurveOnSurface_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <Standard_Integer.hxx>
#include <Standard_Address.hxx>
#include <Standard_Boolean.hxx>
#include <Handle_Adaptor3d_HCurveOnSurface.hxx>
class Standard_RangeError;
class Standard_DimensionMismatch;
class Standard_OutOfRange;
class Standard_OutOfMemory;
class Adaptor3d_HCurveOnSurface;



class GeomPlate_Array1OfHCurveOnSurface 
{
public:

  DEFINE_STANDARD_ALLOC

  
    GeomPlate_Array1OfHCurveOnSurface(const Standard_Integer Low, const Standard_Integer Up);
  
    GeomPlate_Array1OfHCurveOnSurface(const Handle(Adaptor3d_HCurveOnSurface)& Item, const Standard_Integer Low, const Standard_Integer Up);
  
  Standard_EXPORT   void Init (const Handle(Adaptor3d_HCurveOnSurface)& V) ;
  
      void Destroy() ;
~GeomPlate_Array1OfHCurveOnSurface()
{
  Destroy();
}
  
      Standard_Boolean IsAllocated()  const;
  
  Standard_EXPORT  const  GeomPlate_Array1OfHCurveOnSurface& Assign (const GeomPlate_Array1OfHCurveOnSurface& Other) ;
 const  GeomPlate_Array1OfHCurveOnSurface& operator = (const GeomPlate_Array1OfHCurveOnSurface& Other) 
{
  return Assign(Other);
}
  
      Standard_Integer Length()  const;
  
      Standard_Integer Lower()  const;
  
      Standard_Integer Upper()  const;
  
      void SetValue (const Standard_Integer Index, const Handle(Adaptor3d_HCurveOnSurface)& Value) ;
  
     const  Handle(Adaptor3d_HCurveOnSurface)& Value (const Standard_Integer Index)  const;
   const  Handle(Adaptor3d_HCurveOnSurface)& operator () (const Standard_Integer Index)  const
{
  return Value(Index);
}
  
      Handle(Adaptor3d_HCurveOnSurface)& ChangeValue (const Standard_Integer Index) ;
    Handle(Adaptor3d_HCurveOnSurface)& operator () (const Standard_Integer Index) 
{
  return ChangeValue(Index);
}




protected:





private:

  
  Standard_EXPORT GeomPlate_Array1OfHCurveOnSurface(const GeomPlate_Array1OfHCurveOnSurface& AnArray);


  Standard_Integer myLowerBound;
  Standard_Integer myUpperBound;
  Standard_Address myStart;
  Standard_Boolean isAllocated;


};

#define Array1Item Handle(Adaptor3d_HCurveOnSurface)
#define Array1Item_hxx <Adaptor3d_HCurveOnSurface.hxx>
#define TCollection_Array1 GeomPlate_Array1OfHCurveOnSurface
#define TCollection_Array1_hxx <GeomPlate_Array1OfHCurveOnSurface.hxx>

#include <TCollection_Array1.lxx>

#undef Array1Item
#undef Array1Item_hxx
#undef TCollection_Array1
#undef TCollection_Array1_hxx




#endif // _GeomPlate_Array1OfHCurveOnSurface_HeaderFile