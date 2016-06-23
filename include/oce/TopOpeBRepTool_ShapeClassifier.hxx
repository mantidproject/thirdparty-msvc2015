// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _TopOpeBRepTool_ShapeClassifier_HeaderFile
#define _TopOpeBRepTool_ShapeClassifier_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <TopoDS_Shape.hxx>
#include <TopOpeBRepTool_Plos.hxx>
#include <TopTools_IndexedMapOfShape.hxx>
#include <Standard_Integer.hxx>
#include <Standard_Boolean.hxx>
#include <TopAbs_State.hxx>
#include <TopoDS_Edge.hxx>
#include <TopoDS_Face.hxx>
#include <gp_Pnt.hxx>
#include <gp_Pnt2d.hxx>
#include <TopOpeBRepTool_SolidClassifier.hxx>
class TopoDS_Shape;
class TopTools_ListOfShape;
class TopOpeBRepTool_SolidClassifier;
class gp_Pnt2d;
class gp_Pnt;



class TopOpeBRepTool_ShapeClassifier 
{
public:

  DEFINE_STANDARD_ALLOC

  
  Standard_EXPORT TopOpeBRepTool_ShapeClassifier();
  

  //! SRef is the reference shape.
  //! StateShapeShape(S) calls will classify S with SRef.
  Standard_EXPORT TopOpeBRepTool_ShapeClassifier(const TopoDS_Shape& SRef);
  
  //! reset all internal data (SolidClassifier included)
  Standard_EXPORT   void ClearAll() ;
  
  //! reset all internal data (except SolidClassified)
  Standard_EXPORT   void ClearCurrent() ;
  

  //! Set SRef as reference shape
  //! the next StateShapeReference(S,AvoidS) calls will classify S with SRef.
  Standard_EXPORT   void SetReference (const TopoDS_Shape& SRef) ;
  

  //! classify shape S compared with shape SRef.
  //! samedomain = 0 : S1,S2 are not same domain
  //! samedomain = 1 : S1,S2 are same domain
  Standard_EXPORT   TopAbs_State StateShapeShape (const TopoDS_Shape& S, const TopoDS_Shape& SRef, const Standard_Integer samedomain = 0) ;
  
  Standard_EXPORT   Standard_Integer SameDomain()  const;
  

  //! set mode for next StateShapeShape call
  //! samedomain = true --> S,Sref are same domain --> point
  //! on restriction (ON S) is used to classify S.
  //! samedomain = false --> S,Sref are not domain --> point
  //! not on restriction of S (IN S) is used to classify S.
  //! samedomain value is used only in next StateShapeShape call
  Standard_EXPORT   void SameDomain (const Standard_Integer samedomain) ;
  

  //! classify shape S compared with shape SRef.
  //! AvoidS is not used in classification; AvoidS may be IsNull().
  //! (usefull to avoid ON or UNKNOWN state in special cases)
  Standard_EXPORT   TopAbs_State StateShapeShape (const TopoDS_Shape& S, const TopoDS_Shape& AvoidS, const TopoDS_Shape& SRef) ;
  

  //! classify shape S compared with shape SRef.
  //! LAvoidS is list of S subshapes to avoid in classification
  //! AvoidS is not used in classification; AvoidS may be IsNull().
  //! (usefull to avoid ON or UNKNOWN state in special cases)
  Standard_EXPORT   TopAbs_State StateShapeShape (const TopoDS_Shape& S, const TopTools_ListOfShape& LAvoidS, const TopoDS_Shape& SRef) ;
  

  //! classify shape S compared with reference shape.
  //! AvoidS is not used in classification; AvoidS may be IsNull().
  //! (usefull to avoid ON or UNKNOWN state in special cases)
  Standard_EXPORT   TopAbs_State StateShapeReference (const TopoDS_Shape& S, const TopoDS_Shape& AvoidS) ;
  

  //! classify shape S compared with reference shape.
  //! LAvoidS is list of S subshapes to avoid in classification
  //! (usefull to avoid ON or UNKNOWN state in special cases)
  Standard_EXPORT   TopAbs_State StateShapeReference (const TopoDS_Shape& S, const TopTools_ListOfShape& LAvoidS) ;
  
  Standard_EXPORT   TopOpeBRepTool_SolidClassifier& ChangeSolidClassifier() ;
  
  //! classify point P2D with myRef
  Standard_EXPORT   void StateP2DReference (const gp_Pnt2d& P2D) ;
  
  //! classify point P3D with myRef
  Standard_EXPORT   void StateP3DReference (const gp_Pnt& P3D) ;
  
  //! return field myState
  Standard_EXPORT   TopAbs_State State()  const;
  
  Standard_EXPORT  const  gp_Pnt2d& P2D()  const;
  
  Standard_EXPORT  const  gp_Pnt& P3D()  const;




protected:





private:

  
  Standard_EXPORT   void MapRef() ;
  
  Standard_EXPORT   void FindEdge() ;
  
  Standard_EXPORT   void FindEdge (const TopoDS_Shape& S) ;
  
  Standard_EXPORT   void FindFace (const TopoDS_Shape& S) ;
  
  Standard_EXPORT   void Perform() ;
  
  //! classify myEdge with myRef
  Standard_EXPORT   void StateEdgeReference() ;
  
  Standard_EXPORT   Standard_Boolean HasAvLS()  const;


  TopoDS_Shape myS;
  TopoDS_Shape myRef;
  TopoDS_Shape myAvS;
  TopOpeBRepTool_Plos myPAvLS;
  TopTools_IndexedMapOfShape myMapAvS;
  TopTools_IndexedMapOfShape mymre;
  Standard_Integer mymren;
  Standard_Boolean mymredone;
  TopAbs_State myState;
  TopoDS_Edge myEdge;
  TopoDS_Face myFace;
  Standard_Boolean myP3Ddef;
  gp_Pnt myP3D;
  Standard_Boolean myP2Ddef;
  gp_Pnt2d myP2D;
  TopOpeBRepTool_SolidClassifier mySolidClassifier;
  Standard_Integer mySameDomain;


};







#endif // _TopOpeBRepTool_ShapeClassifier_HeaderFile