// This file is generated by WOK (CPPExt).
// Please do not edit this file; modify original file instead.
// The copyright and license terms as defined for the original file apply to 
// this header file considered to be the "object code" form of the original source.

#ifndef _Visual3d_TypeOfModel_HeaderFile
#define _Visual3d_TypeOfModel_HeaderFile

#include <Standard_PrimitiveTypes.hxx>

//! Definition of the rendering (colour shading) model
//! Visual3d_TOM_NONE     No lighting, only white ambient light
//! Visual3d_TOM_FACET    No interpolation, constant shading      (Flat    Shading)
//! Visual3d_TOM_VERTEX   Interpolation of color based on normals (Gouraud Shading)
//! Visual3d_TOM_FRAGMENT Interpolation of color based on normals (Phong   Shading)
enum Visual3d_TypeOfModel
{
Visual3d_TOM_NONE,
Visual3d_TOM_FACET,
Visual3d_TOM_VERTEX,
Visual3d_TOM_FRAGMENT
};

#endif // _Visual3d_TypeOfModel_HeaderFile