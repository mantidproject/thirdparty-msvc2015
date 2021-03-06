// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _Prs3d_TypeOfHLR_HeaderFile
#define _Prs3d_TypeOfHLR_HeaderFile

#include <Standard_PrimitiveTypes.hxx>

//! Declares types of hidden line removal algorithm.
//! TOH_Algo enables using of exact HLR algorithm.
//! TOH_PolyAlgo enables using of polygonal HLR algorithm.
//! TOH_NotSet is used by AIS_Drawer class, it means that the drawer should return the global value.
//! For more details see AIS_Drawer class, AIS_Shape::Compute() method and
//! HLRAlgo package from TKHLR toolkit.
enum Prs3d_TypeOfHLR
{
Prs3d_TOH_NotSet,
Prs3d_TOH_PolyAlgo,
Prs3d_TOH_Algo
};

#endif // _Prs3d_TypeOfHLR_HeaderFile
