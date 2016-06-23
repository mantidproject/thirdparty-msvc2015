// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _TopoDSToStep_MakeBrepWithVoids_HeaderFile
#define _TopoDSToStep_MakeBrepWithVoids_HeaderFile

#include <Standard.hxx>
#include <Standard_DefineAlloc.hxx>
#include <Standard_Macro.hxx>

#include <Handle_StepShape_BrepWithVoids.hxx>
#include <TopoDSToStep_Root.hxx>
#include <Handle_Transfer_FinderProcess.hxx>
class StepShape_BrepWithVoids;
class StdFail_NotDone;
class TopoDS_Solid;
class Transfer_FinderProcess;


//! This class implements the mapping between classes
//! Solid from TopoDS and BrepWithVoids from
//! StepShape. All the topology and geometry comprised
//! into the shell or the solid are taken into account and
//! translated.
class TopoDSToStep_MakeBrepWithVoids  : public TopoDSToStep_Root
{
public:

  DEFINE_STANDARD_ALLOC

  
  Standard_EXPORT TopoDSToStep_MakeBrepWithVoids(const TopoDS_Solid& S, const Handle(Transfer_FinderProcess)& FP);
  
  Standard_EXPORT  const  Handle(StepShape_BrepWithVoids)& Value()  const;




protected:





private:



  Handle(StepShape_BrepWithVoids) theBrepWithVoids;


};







#endif // _TopoDSToStep_MakeBrepWithVoids_HeaderFile