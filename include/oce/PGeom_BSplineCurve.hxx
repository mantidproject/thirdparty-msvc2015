// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _PGeom_BSplineCurve_HeaderFile
#define _PGeom_BSplineCurve_HeaderFile

#include <Standard_Macro.hxx>
#include <Standard_DefineHandle.hxx>
#include <Standard.hxx>
#include <Handle_PGeom_BSplineCurve.hxx>

#include <Standard_Boolean.hxx>
#include <Standard_Integer.hxx>
#include <Handle_PColgp_HArray1OfPnt.hxx>
#include <Handle_PColStd_HArray1OfReal.hxx>
#include <Handle_PColStd_HArray1OfInteger.hxx>
#include <PGeom_BoundedCurve.hxx>
class PColgp_HArray1OfPnt;
class PColStd_HArray1OfReal;
class PColStd_HArray1OfInteger;


class PGeom_BSplineCurve : public PGeom_BoundedCurve
{

public:

  
  //! Creates a BSplineCurve with default values.
  Standard_EXPORT PGeom_BSplineCurve();
  
  //! Creates a BSplineCurve with these field values.
  Standard_EXPORT PGeom_BSplineCurve(const Standard_Boolean aRational, const Standard_Boolean aPeriodic, const Standard_Integer aSpineDegree, const Handle(PColgp_HArray1OfPnt)& aPoles, const Handle(PColStd_HArray1OfReal)& aWeights, const Handle(PColStd_HArray1OfReal)& aKnots, const Handle(PColStd_HArray1OfInteger)& aMultiplicities);
  
  //! Set the field periodic with <aPeriodic>.
  Standard_EXPORT   void Periodic (const Standard_Boolean aPeriodic) ;
  
  //! Returns the value of the field periodic.
  Standard_EXPORT   Standard_Boolean Periodic()  const;
  
  //! Set  the   value  of  the    field rational   with
  //! <aRational>.
  Standard_EXPORT   void Rational (const Standard_Boolean aRational) ;
  
  //! Returns the value of the field rational.
  Standard_EXPORT   Standard_Boolean Rational()  const;
  
  //! Set the value of the field spineDegree with <aSpineDegree>.
  Standard_EXPORT   void SpineDegree (const Standard_Integer aSpineDegree) ;
  
  //! Returns the value of the field spineDegree.
  Standard_EXPORT   Standard_Integer SpineDegree()  const;
  
  //! Set the value of the field poles with <aPoles>.
  Standard_EXPORT   void Poles (const Handle(PColgp_HArray1OfPnt)& aPoles) ;
  
  //! Returns the value of the field poles.
  Standard_EXPORT   Handle(PColgp_HArray1OfPnt) Poles()  const;
  
  //! Set the value of the field weights with <aWeights>.
  Standard_EXPORT   void Weights (const Handle(PColStd_HArray1OfReal)& aWeights) ;
  
  //! Returns the the value of the field weights.
  Standard_EXPORT   Handle(PColStd_HArray1OfReal) Weights()  const;
  
  //! Set the field knots with <aKnots>.
  //! The multiplicity of the knots are not modified.
  Standard_EXPORT   void Knots (const Handle(PColStd_HArray1OfReal)& aKnots) ;
  
  //! returns the value of the field knots.
  Standard_EXPORT   Handle(PColStd_HArray1OfReal) Knots()  const;
  
  //! Set the field multiplicities with <aMultiplicities>.
  Standard_EXPORT   void Multiplicities (const Handle(PColStd_HArray1OfInteger)& aMultiplicities) ;
  
  //! returns the value of the field multiplicities.
  Standard_EXPORT   Handle(PColStd_HArray1OfInteger) Multiplicities()  const;

PGeom_BSplineCurve(const Storage_stCONSTclCOM& a) : PGeom_BoundedCurve(a)
{
  
}
    Standard_Boolean _CSFDB_GetPGeom_BSplineCurverational() const { return rational; }
    void _CSFDB_SetPGeom_BSplineCurverational(const Standard_Boolean p) { rational = p; }
    Standard_Boolean _CSFDB_GetPGeom_BSplineCurveperiodic() const { return periodic; }
    void _CSFDB_SetPGeom_BSplineCurveperiodic(const Standard_Boolean p) { periodic = p; }
    Standard_Integer _CSFDB_GetPGeom_BSplineCurvespineDegree() const { return spineDegree; }
    void _CSFDB_SetPGeom_BSplineCurvespineDegree(const Standard_Integer p) { spineDegree = p; }
    Handle(PColgp_HArray1OfPnt) _CSFDB_GetPGeom_BSplineCurvepoles() const { return poles; }
    void _CSFDB_SetPGeom_BSplineCurvepoles(const Handle(PColgp_HArray1OfPnt)& p) { poles = p; }
    Handle(PColStd_HArray1OfReal) _CSFDB_GetPGeom_BSplineCurveweights() const { return weights; }
    void _CSFDB_SetPGeom_BSplineCurveweights(const Handle(PColStd_HArray1OfReal)& p) { weights = p; }
    Handle(PColStd_HArray1OfReal) _CSFDB_GetPGeom_BSplineCurveknots() const { return knots; }
    void _CSFDB_SetPGeom_BSplineCurveknots(const Handle(PColStd_HArray1OfReal)& p) { knots = p; }
    Handle(PColStd_HArray1OfInteger) _CSFDB_GetPGeom_BSplineCurvemultiplicities() const { return multiplicities; }
    void _CSFDB_SetPGeom_BSplineCurvemultiplicities(const Handle(PColStd_HArray1OfInteger)& p) { multiplicities = p; }



  DEFINE_STANDARD_RTTI(PGeom_BSplineCurve)

protected:




private: 


  Standard_Boolean rational;
  Standard_Boolean periodic;
  Standard_Integer spineDegree;
  Handle(PColgp_HArray1OfPnt) poles;
  Handle(PColStd_HArray1OfReal) weights;
  Handle(PColStd_HArray1OfReal) knots;
  Handle(PColStd_HArray1OfInteger) multiplicities;


};







#endif // _PGeom_BSplineCurve_HeaderFile