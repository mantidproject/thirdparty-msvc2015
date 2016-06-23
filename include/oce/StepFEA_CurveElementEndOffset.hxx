// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _StepFEA_CurveElementEndOffset_HeaderFile
#define _StepFEA_CurveElementEndOffset_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_StepFEA_CurveElementEndOffset.hxx>

#include <StepFEA_CurveElementEndCoordinateSystem.hxx>
#include <Handle_TColStd_HArray1OfReal.hxx>
#include <MMgt_TShared.hxx>
class TColStd_HArray1OfReal;
class StepFEA_CurveElementEndCoordinateSystem;


//! Representation of STEP entity CurveElementEndOffset
class StepFEA_CurveElementEndOffset : public MMgt_TShared
{

public:

  
  //! Empty constructor
  Standard_EXPORT StepFEA_CurveElementEndOffset();
  
  //! Initialize all fields (own and inherited)
  Standard_EXPORT   void Init (const StepFEA_CurveElementEndCoordinateSystem& aCoordinateSystem, const Handle(TColStd_HArray1OfReal)& aOffsetVector) ;
  
  //! Returns field CoordinateSystem
  Standard_EXPORT   StepFEA_CurveElementEndCoordinateSystem CoordinateSystem()  const;
  
  //! Set field CoordinateSystem
  Standard_EXPORT   void SetCoordinateSystem (const StepFEA_CurveElementEndCoordinateSystem& CoordinateSystem) ;
  
  //! Returns field OffsetVector
  Standard_EXPORT   Handle(TColStd_HArray1OfReal) OffsetVector()  const;
  
  //! Set field OffsetVector
  Standard_EXPORT   void SetOffsetVector (const Handle(TColStd_HArray1OfReal)& OffsetVector) ;




  DEFINE_STANDARD_RTTI(StepFEA_CurveElementEndOffset)

protected:




private: 


  StepFEA_CurveElementEndCoordinateSystem theCoordinateSystem;
  Handle(TColStd_HArray1OfReal) theOffsetVector;


};







#endif // _StepFEA_CurveElementEndOffset_HeaderFile