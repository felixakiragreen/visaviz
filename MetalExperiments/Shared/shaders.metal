//
//  shaders.metal
//  MetalExperiments
//
//  Created by Felix Akira Green on 1/19/21.
//

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
  float3 position;
  float4 color;
};


struct VertexOut {
  float4 position [[ position ]];
  float4 color;
};

vertex VertexOut basic_vertex_function(const device VertexIn *vertices [[ buffer(0) ]],
												 uint vertexID [[ vertex_id  ]]) {
  VertexOut vOut;
  vOut.position = float4(vertices[vertexID].position,1);
  vOut.color = vertices[vertexID].color;
  return vOut;
}

fragment float4 basic_fragment_function(VertexOut vIn [[ stage_in ]]) {
  return vIn.color;
}
 
