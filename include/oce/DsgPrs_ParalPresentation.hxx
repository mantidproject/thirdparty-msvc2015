// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _DsgPrs_ParalPresentation_HeaderFile
#define _DsgPrs_ParalPresentation_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <Handle_Prs3d_Presentation.hxx>
#include <Handle_Prs3d_Drawer.hxx>
#include <DsgPrs_ArrowSide.hxx>
class Prs3d_Presentation;
class Prs3d_Drawer;
class TCollection_ExtendedString;
class gp_Pnt;
class gp_Dir;


//! A framework to define display of relations of parallelism between shapes.
class DsgPrs_ParalPresentation 
{
public:

  DEFINE_STANDARD_ALLOC

  
  //! Defines the display of elements showing relations of
  //! parallelism between shapes.
  //! These include the two points of attachment
  //! AttachmentPoint1 and AttachmentPoint1, the
  //! direction aDirection, and the offset point OffsetPoint.
  //! These arguments are added to the presentation
  //! object aPresentation. Their display attributes are
  //! defined by the attribute manager aDrawer.
  Standard_EXPORT static   void Add (const Handle(Prs3d_Presentation)& aPresentation, const Handle(Prs3d_Drawer)& aDrawer, const TCollection_ExtendedString& aText, const gp_Pnt& AttachmentPoint1, const gp_Pnt& AttachmentPoint2, const gp_Dir& aDirection, const gp_Pnt& OffsetPoint) ;
  
  //! Defines the display of elements showing relations of
  //! parallelism between shapes.
  //! These include the two points of attachment
  //! AttachmentPoint1 and AttachmentPoint1, the
  //! direction aDirection, the offset point OffsetPoint and
  //! the text aText.
  //! These arguments are added to the presentation
  //! object aPresentation. Their display attributes are
  //! defined by the attribute manager aDrawer.
  Standard_EXPORT static   void Add (const Handle(Prs3d_Presentation)& aPresentation, const Handle(Prs3d_Drawer)& aDrawer, const TCollection_ExtendedString& aText, const gp_Pnt& AttachmentPoint1, const gp_Pnt& AttachmentPoint2, const gp_Dir& aDirection, const gp_Pnt& OffsetPoint, const DsgPrs_ArrowSide ArrowSide) ;




protected:





private:





};







#endif // _DsgPrs_ParalPresentation_HeaderFile