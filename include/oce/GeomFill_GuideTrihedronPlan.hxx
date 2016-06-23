// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _GeomFill_GuideTrihedronPlan_HeaderFile
#define _GeomFill_GuideTrihedronPlan_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineHandle.hxx>
#include <Handle_GeomFill_GuideTrihedronPlan.hxx>

#include <Handle_Adaptor3d_HCurve.hxx>
#include <Handle_TColgp_HArray2OfPnt2d.hxx>
#include <math_Vector.hxx>
#include <Handle_GeomFill_Frenet.hxx>
#include <Standard_Integer.hxx>
#include <GeomFill_PipeError.hxx>
#include <GeomFill_TrihedronWithGuide.hxx>
#include <Handle_GeomFill_TrihedronLaw.hxx>
#include <Standard_Boolean.hxx>
#include <Standard_Real.hxx>
#include <GeomAbs_Shape.hxx>
class Adaptor3d_HCurve;
class TColgp_HArray2OfPnt2d;
class GeomFill_Frenet;
class Standard_OutOfRange;
class Standard_ConstructionError;
class GeomFill_TrihedronLaw;
class gp_Vec;
class TColStd_Array1OfReal;


//! Trihedron in  the case of sweeping along a guide curve defined
//! by the orthogonal  plan on  the trajectory
class GeomFill_GuideTrihedronPlan : public GeomFill_TrihedronWithGuide
{

public:

  
  Standard_EXPORT GeomFill_GuideTrihedronPlan(const Handle(Adaptor3d_HCurve)& theGuide);
  
  Standard_EXPORT virtual   void SetCurve (const Handle(Adaptor3d_HCurve)& thePath) ;
  
  Standard_EXPORT virtual   Handle(GeomFill_TrihedronLaw) Copy()  const;
  
  //! Give a status to the Law
  //! Returns PipeOk (default implementation)
  Standard_EXPORT virtual   GeomFill_PipeError ErrorStatus()  const;
  
  Standard_EXPORT virtual   Handle(Adaptor3d_HCurve) Guide()  const;
  
  Standard_EXPORT virtual   Standard_Boolean D0 (const Standard_Real Param, gp_Vec& Tangent, gp_Vec& Normal, gp_Vec& BiNormal) ;
  
  Standard_EXPORT virtual   Standard_Boolean D1 (const Standard_Real Param, gp_Vec& Tangent, gp_Vec& DTangent, gp_Vec& Normal, gp_Vec& DNormal, gp_Vec& BiNormal, gp_Vec& DBiNormal) ;
  
  Standard_EXPORT virtual   Standard_Boolean D2 (const Standard_Real Param, gp_Vec& Tangent, gp_Vec& DTangent, gp_Vec& D2Tangent, gp_Vec& Normal, gp_Vec& DNormal, gp_Vec& D2Normal, gp_Vec& BiNormal, gp_Vec& DBiNormal, gp_Vec& D2BiNormal) ;
  
  //! Sets the bounds of the parametric interval on
  //! the function
  //! This determines the derivatives in these values if the
  //! function is not Cn.
  Standard_EXPORT virtual   void SetInterval (const Standard_Real First, const Standard_Real Last) ;
  
  //! Returns  the number  of  intervals for  continuity
  //! <S>.
  //! May be one if Continuity(me) >= <S>
  Standard_EXPORT virtual   Standard_Integer NbIntervals (const GeomAbs_Shape S)  const;
  
  //! Stores in <T> the  parameters bounding the intervals
  //! of continuity <S>.
  //!
  //! The array must provide  enough room to  accomodate
  //! for the parameters. i.e. T.Length() > NbIntervals()
  Standard_EXPORT virtual   void Intervals (TColStd_Array1OfReal& T, const GeomAbs_Shape S)  const;
  
  //! Get average value of M(t) and V(t) it is usfull to
  //! make fast approximation of rational  surfaces.
  Standard_EXPORT virtual   void GetAverageLaw (gp_Vec& ATangent, gp_Vec& ANormal, gp_Vec& ABiNormal) ;
  
  //! Say if the law is Constant
  Standard_EXPORT virtual   Standard_Boolean IsConstant()  const;
  
  //! Say if the law is defined, only by the 3d Geometry of
  //! the setted Curve
  //! Return False by Default.
  Standard_EXPORT virtual   Standard_Boolean IsOnlyBy3dCurve()  const;
  
  Standard_EXPORT virtual   void Origine (const Standard_Real OrACR1, const Standard_Real OrACR2) ;




  DEFINE_STANDARD_RTTI(GeomFill_GuideTrihedronPlan)

protected:




private: 

  
  Standard_EXPORT   void Init() ;
  
  Standard_EXPORT   void InitX (const Standard_Real Param) ;

  Handle(Adaptor3d_HCurve) myTrimmed;
  Handle(Adaptor3d_HCurve) myCurve;
  Handle(TColgp_HArray2OfPnt2d) Pole;
  math_Vector X;
  math_Vector XTol;
  math_Vector Inf;
  math_Vector Sup;
  Handle(GeomFill_Frenet) frenet;
  Standard_Integer myNbPts;
  GeomFill_PipeError myStatus;


};







#endif // _GeomFill_GuideTrihedronPlan_HeaderFile