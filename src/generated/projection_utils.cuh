#pragma once

#include "generated/slang.cuh"

inline __device__ Matrix<float, 3, 3>  transpose_0(Matrix<float, 3, 3>  x_0)
{
    Matrix<float, 3, 3>  result_0;
    int r_0 = int(0);
    for(;;)
    {
        if(r_0 < int(3))
        {
        }
        else
        {
            break;
        }
        int c_0 = int(0);
        for(;;)
        {
            if(c_0 < int(3))
            {
            }
            else
            {
                break;
            }
            *_slang_vector_get_element_ptr(((&result_0)->rows + (r_0)), c_0) = _slang_vector_get_element(x_0.rows[c_0], r_0);
            c_0 = c_0 + int(1);
        }
        r_0 = r_0 + int(1);
    }
    return result_0;
}

inline __device__ Matrix<float, 2, 2>  transpose_1(Matrix<float, 2, 2>  x_1)
{
    Matrix<float, 2, 2>  result_1;
    int r_1 = int(0);
    for(;;)
    {
        if(r_1 < int(2))
        {
        }
        else
        {
            break;
        }
        int c_1 = int(0);
        for(;;)
        {
            if(c_1 < int(2))
            {
            }
            else
            {
                break;
            }
            *_slang_vector_get_element_ptr(((&result_1)->rows + (r_1)), c_1) = _slang_vector_get_element(x_1.rows[c_1], r_1);
            c_1 = c_1 + int(1);
        }
        r_1 = r_1 + int(1);
    }
    return result_1;
}

inline __device__ Matrix<float, 3, 3>  normalized_quat_to_rotmat(float4  quat_0)
{
    float x_2 = quat_0.y;
    float x2_0 = x_2 * x_2;
    float y2_0 = quat_0.z * quat_0.z;
    float z2_0 = quat_0.w * quat_0.w;
    float xy_0 = quat_0.y * quat_0.z;
    float xz_0 = quat_0.y * quat_0.w;
    float yz_0 = quat_0.z * quat_0.w;
    float wx_0 = quat_0.x * quat_0.y;
    float wy_0 = quat_0.x * quat_0.z;
    float wz_0 = quat_0.x * quat_0.w;
    return transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_0 + z2_0), 2.0f * (xy_0 + wz_0), 2.0f * (xz_0 - wy_0), 2.0f * (xy_0 - wz_0), 1.0f - 2.0f * (x2_0 + z2_0), 2.0f * (yz_0 + wx_0), 2.0f * (xz_0 + wy_0), 2.0f * (yz_0 - wx_0), 1.0f - 2.0f * (x2_0 + y2_0)));
}

struct DiffPair_matrixx3Cfloatx2C3x2C3x3E_0
{
    Matrix<float, 3, 3>  primal_0;
    Matrix<float, 3, 3>  differential_0;
};

inline __device__ void mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * left_0, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * right_0, Matrix<float, 3, 3>  dOut_0)
{
    Matrix<float, 3, 3>  left_d_result_0;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = 0.0f;
    Matrix<float, 3, 3>  right_d_result_0;
    *&(((&right_d_result_0)->rows + (int(0)))->x) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(0)))->y) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(0)))->z) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(1)))->x) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(1)))->y) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(1)))->z) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(2)))->x) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(2)))->y) = 0.0f;
    *&(((&right_d_result_0)->rows + (int(2)))->z) = 0.0f;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = *&(((&left_d_result_0)->rows + (int(0)))->x) + (*right_0).primal_0.rows[int(0)].x * dOut_0.rows[int(0)].x;
    *&(((&right_d_result_0)->rows + (int(0)))->x) = *&(((&right_d_result_0)->rows + (int(0)))->x) + (*left_0).primal_0.rows[int(0)].x * dOut_0.rows[int(0)].x;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = *&(((&left_d_result_0)->rows + (int(0)))->y) + (*right_0).primal_0.rows[int(1)].x * dOut_0.rows[int(0)].x;
    *&(((&right_d_result_0)->rows + (int(1)))->x) = *&(((&right_d_result_0)->rows + (int(1)))->x) + (*left_0).primal_0.rows[int(0)].y * dOut_0.rows[int(0)].x;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = *&(((&left_d_result_0)->rows + (int(0)))->z) + (*right_0).primal_0.rows[int(2)].x * dOut_0.rows[int(0)].x;
    *&(((&right_d_result_0)->rows + (int(2)))->x) = *&(((&right_d_result_0)->rows + (int(2)))->x) + (*left_0).primal_0.rows[int(0)].z * dOut_0.rows[int(0)].x;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = *&(((&left_d_result_0)->rows + (int(0)))->x) + (*right_0).primal_0.rows[int(0)].y * dOut_0.rows[int(0)].y;
    *&(((&right_d_result_0)->rows + (int(0)))->y) = *&(((&right_d_result_0)->rows + (int(0)))->y) + (*left_0).primal_0.rows[int(0)].x * dOut_0.rows[int(0)].y;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = *&(((&left_d_result_0)->rows + (int(0)))->y) + (*right_0).primal_0.rows[int(1)].y * dOut_0.rows[int(0)].y;
    *&(((&right_d_result_0)->rows + (int(1)))->y) = *&(((&right_d_result_0)->rows + (int(1)))->y) + (*left_0).primal_0.rows[int(0)].y * dOut_0.rows[int(0)].y;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = *&(((&left_d_result_0)->rows + (int(0)))->z) + (*right_0).primal_0.rows[int(2)].y * dOut_0.rows[int(0)].y;
    *&(((&right_d_result_0)->rows + (int(2)))->y) = *&(((&right_d_result_0)->rows + (int(2)))->y) + (*left_0).primal_0.rows[int(0)].z * dOut_0.rows[int(0)].y;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = *&(((&left_d_result_0)->rows + (int(0)))->x) + (*right_0).primal_0.rows[int(0)].z * dOut_0.rows[int(0)].z;
    *&(((&right_d_result_0)->rows + (int(0)))->z) = *&(((&right_d_result_0)->rows + (int(0)))->z) + (*left_0).primal_0.rows[int(0)].x * dOut_0.rows[int(0)].z;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = *&(((&left_d_result_0)->rows + (int(0)))->y) + (*right_0).primal_0.rows[int(1)].z * dOut_0.rows[int(0)].z;
    *&(((&right_d_result_0)->rows + (int(1)))->z) = *&(((&right_d_result_0)->rows + (int(1)))->z) + (*left_0).primal_0.rows[int(0)].y * dOut_0.rows[int(0)].z;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = *&(((&left_d_result_0)->rows + (int(0)))->z) + (*right_0).primal_0.rows[int(2)].z * dOut_0.rows[int(0)].z;
    *&(((&right_d_result_0)->rows + (int(2)))->z) = *&(((&right_d_result_0)->rows + (int(2)))->z) + (*left_0).primal_0.rows[int(0)].z * dOut_0.rows[int(0)].z;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = *&(((&left_d_result_0)->rows + (int(1)))->x) + (*right_0).primal_0.rows[int(0)].x * dOut_0.rows[int(1)].x;
    *&(((&right_d_result_0)->rows + (int(0)))->x) = *&(((&right_d_result_0)->rows + (int(0)))->x) + (*left_0).primal_0.rows[int(1)].x * dOut_0.rows[int(1)].x;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = *&(((&left_d_result_0)->rows + (int(1)))->y) + (*right_0).primal_0.rows[int(1)].x * dOut_0.rows[int(1)].x;
    *&(((&right_d_result_0)->rows + (int(1)))->x) = *&(((&right_d_result_0)->rows + (int(1)))->x) + (*left_0).primal_0.rows[int(1)].y * dOut_0.rows[int(1)].x;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = *&(((&left_d_result_0)->rows + (int(1)))->z) + (*right_0).primal_0.rows[int(2)].x * dOut_0.rows[int(1)].x;
    *&(((&right_d_result_0)->rows + (int(2)))->x) = *&(((&right_d_result_0)->rows + (int(2)))->x) + (*left_0).primal_0.rows[int(1)].z * dOut_0.rows[int(1)].x;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = *&(((&left_d_result_0)->rows + (int(1)))->x) + (*right_0).primal_0.rows[int(0)].y * dOut_0.rows[int(1)].y;
    *&(((&right_d_result_0)->rows + (int(0)))->y) = *&(((&right_d_result_0)->rows + (int(0)))->y) + (*left_0).primal_0.rows[int(1)].x * dOut_0.rows[int(1)].y;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = *&(((&left_d_result_0)->rows + (int(1)))->y) + (*right_0).primal_0.rows[int(1)].y * dOut_0.rows[int(1)].y;
    *&(((&right_d_result_0)->rows + (int(1)))->y) = *&(((&right_d_result_0)->rows + (int(1)))->y) + (*left_0).primal_0.rows[int(1)].y * dOut_0.rows[int(1)].y;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = *&(((&left_d_result_0)->rows + (int(1)))->z) + (*right_0).primal_0.rows[int(2)].y * dOut_0.rows[int(1)].y;
    *&(((&right_d_result_0)->rows + (int(2)))->y) = *&(((&right_d_result_0)->rows + (int(2)))->y) + (*left_0).primal_0.rows[int(1)].z * dOut_0.rows[int(1)].y;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = *&(((&left_d_result_0)->rows + (int(1)))->x) + (*right_0).primal_0.rows[int(0)].z * dOut_0.rows[int(1)].z;
    *&(((&right_d_result_0)->rows + (int(0)))->z) = *&(((&right_d_result_0)->rows + (int(0)))->z) + (*left_0).primal_0.rows[int(1)].x * dOut_0.rows[int(1)].z;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = *&(((&left_d_result_0)->rows + (int(1)))->y) + (*right_0).primal_0.rows[int(1)].z * dOut_0.rows[int(1)].z;
    *&(((&right_d_result_0)->rows + (int(1)))->z) = *&(((&right_d_result_0)->rows + (int(1)))->z) + (*left_0).primal_0.rows[int(1)].y * dOut_0.rows[int(1)].z;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = *&(((&left_d_result_0)->rows + (int(1)))->z) + (*right_0).primal_0.rows[int(2)].z * dOut_0.rows[int(1)].z;
    *&(((&right_d_result_0)->rows + (int(2)))->z) = *&(((&right_d_result_0)->rows + (int(2)))->z) + (*left_0).primal_0.rows[int(1)].z * dOut_0.rows[int(1)].z;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = *&(((&left_d_result_0)->rows + (int(2)))->x) + (*right_0).primal_0.rows[int(0)].x * dOut_0.rows[int(2)].x;
    *&(((&right_d_result_0)->rows + (int(0)))->x) = *&(((&right_d_result_0)->rows + (int(0)))->x) + (*left_0).primal_0.rows[int(2)].x * dOut_0.rows[int(2)].x;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = *&(((&left_d_result_0)->rows + (int(2)))->y) + (*right_0).primal_0.rows[int(1)].x * dOut_0.rows[int(2)].x;
    *&(((&right_d_result_0)->rows + (int(1)))->x) = *&(((&right_d_result_0)->rows + (int(1)))->x) + (*left_0).primal_0.rows[int(2)].y * dOut_0.rows[int(2)].x;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = *&(((&left_d_result_0)->rows + (int(2)))->z) + (*right_0).primal_0.rows[int(2)].x * dOut_0.rows[int(2)].x;
    *&(((&right_d_result_0)->rows + (int(2)))->x) = *&(((&right_d_result_0)->rows + (int(2)))->x) + (*left_0).primal_0.rows[int(2)].z * dOut_0.rows[int(2)].x;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = *&(((&left_d_result_0)->rows + (int(2)))->x) + (*right_0).primal_0.rows[int(0)].y * dOut_0.rows[int(2)].y;
    *&(((&right_d_result_0)->rows + (int(0)))->y) = *&(((&right_d_result_0)->rows + (int(0)))->y) + (*left_0).primal_0.rows[int(2)].x * dOut_0.rows[int(2)].y;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = *&(((&left_d_result_0)->rows + (int(2)))->y) + (*right_0).primal_0.rows[int(1)].y * dOut_0.rows[int(2)].y;
    *&(((&right_d_result_0)->rows + (int(1)))->y) = *&(((&right_d_result_0)->rows + (int(1)))->y) + (*left_0).primal_0.rows[int(2)].y * dOut_0.rows[int(2)].y;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = *&(((&left_d_result_0)->rows + (int(2)))->z) + (*right_0).primal_0.rows[int(2)].y * dOut_0.rows[int(2)].y;
    *&(((&right_d_result_0)->rows + (int(2)))->y) = *&(((&right_d_result_0)->rows + (int(2)))->y) + (*left_0).primal_0.rows[int(2)].z * dOut_0.rows[int(2)].y;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = *&(((&left_d_result_0)->rows + (int(2)))->x) + (*right_0).primal_0.rows[int(0)].z * dOut_0.rows[int(2)].z;
    *&(((&right_d_result_0)->rows + (int(0)))->z) = *&(((&right_d_result_0)->rows + (int(0)))->z) + (*left_0).primal_0.rows[int(2)].x * dOut_0.rows[int(2)].z;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = *&(((&left_d_result_0)->rows + (int(2)))->y) + (*right_0).primal_0.rows[int(1)].z * dOut_0.rows[int(2)].z;
    *&(((&right_d_result_0)->rows + (int(1)))->z) = *&(((&right_d_result_0)->rows + (int(1)))->z) + (*left_0).primal_0.rows[int(2)].y * dOut_0.rows[int(2)].z;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = *&(((&left_d_result_0)->rows + (int(2)))->z) + (*right_0).primal_0.rows[int(2)].z * dOut_0.rows[int(2)].z;
    *&(((&right_d_result_0)->rows + (int(2)))->z) = *&(((&right_d_result_0)->rows + (int(2)))->z) + (*left_0).primal_0.rows[int(2)].z * dOut_0.rows[int(2)].z;
    left_0->primal_0 = (*left_0).primal_0;
    left_0->differential_0 = left_d_result_0;
    right_0->primal_0 = (*right_0).primal_0;
    right_0->differential_0 = right_d_result_0;
    return;
}

inline __device__ Matrix<float, 3, 3>  mul_1(Matrix<float, 3, 3>  left_1, Matrix<float, 3, 3>  right_1)
{
    Matrix<float, 3, 3>  result_2;
    int r_2 = int(0);
    for(;;)
    {
        if(r_2 < int(3))
        {
        }
        else
        {
            break;
        }
        int c_2 = int(0);
        for(;;)
        {
            if(c_2 < int(3))
            {
            }
            else
            {
                break;
            }
            int i_0 = int(0);
            float sum_0 = 0.0f;
            for(;;)
            {
                if(i_0 < int(3))
                {
                }
                else
                {
                    break;
                }
                float sum_1 = sum_0 + _slang_vector_get_element(left_1.rows[r_2], i_0) * _slang_vector_get_element(right_1.rows[i_0], c_2);
                i_0 = i_0 + int(1);
                sum_0 = sum_1;
            }
            *_slang_vector_get_element_ptr(((&result_2)->rows + (r_2)), c_2) = sum_0;
            c_2 = c_2 + int(1);
        }
        r_2 = r_2 + int(1);
    }
    return result_2;
}

inline __device__ void quat_scale_to_covar(float4  quat_1, float3  scale_0, Matrix<float, 3, 3>  * covar_0)
{
    float x_3 = quat_1.y;
    float x2_1 = x_3 * x_3;
    float y2_1 = quat_1.z * quat_1.z;
    float z2_1 = quat_1.w * quat_1.w;
    float xy_1 = quat_1.y * quat_1.z;
    float xz_1 = quat_1.y * quat_1.w;
    float yz_1 = quat_1.z * quat_1.w;
    float wx_1 = quat_1.x * quat_1.y;
    float wy_1 = quat_1.x * quat_1.z;
    float wz_1 = quat_1.x * quat_1.w;
    Matrix<float, 3, 3>  M_0 = mul_1(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_1 + z2_1), 2.0f * (xy_1 + wz_1), 2.0f * (xz_1 - wy_1), 2.0f * (xy_1 - wz_1), 1.0f - 2.0f * (x2_1 + z2_1), 2.0f * (yz_1 + wx_1), 2.0f * (xz_1 + wy_1), 2.0f * (yz_1 - wx_1), 1.0f - 2.0f * (x2_1 + y2_1))), makeMatrix<float, 3, 3> (scale_0.x, 0.0f, 0.0f, 0.0f, scale_0.y, 0.0f, 0.0f, 0.0f, scale_0.z));
    *covar_0 = mul_1(M_0, transpose_0(M_0));
    return;
}

inline __device__ void quat_scale_to_sqrt_covar(float4  quat_2, float3  scale_1, Matrix<float, 3, 3>  * M_1)
{
    float x_4 = quat_2.y;
    float x2_2 = x_4 * x_4;
    float y2_2 = quat_2.z * quat_2.z;
    float z2_2 = quat_2.w * quat_2.w;
    float xy_2 = quat_2.y * quat_2.z;
    float xz_2 = quat_2.y * quat_2.w;
    float yz_2 = quat_2.z * quat_2.w;
    float wx_2 = quat_2.x * quat_2.y;
    float wy_2 = quat_2.x * quat_2.z;
    float wz_2 = quat_2.x * quat_2.w;
    *M_1 = mul_1(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_2 + z2_2), 2.0f * (xy_2 + wz_2), 2.0f * (xz_2 - wy_2), 2.0f * (xy_2 - wz_2), 1.0f - 2.0f * (x2_2 + z2_2), 2.0f * (yz_2 + wx_2), 2.0f * (xz_2 + wy_2), 2.0f * (yz_2 - wx_2), 1.0f - 2.0f * (x2_2 + y2_2))), makeMatrix<float, 3, 3> (scale_1.x, 0.0f, 0.0f, 0.0f, scale_1.y, 0.0f, 0.0f, 0.0f, scale_1.z));
    return;
}

struct DiffPair_vectorx3Cfloatx2C3x3E_0
{
    float3  primal_0;
    float3  differential_0;
};

inline __device__ void _d_mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * left_2, DiffPair_vectorx3Cfloatx2C3x3E_0 * right_2, float3  dOut_1)
{
    float _S1 = (*left_2).primal_0.rows[int(0)].x * dOut_1.x;
    Matrix<float, 3, 3>  left_d_result_1;
    *&(((&left_d_result_1)->rows + (int(0)))->x) = (*right_2).primal_0.x * dOut_1.x;
    float sum_2 = _S1 + (*left_2).primal_0.rows[int(1)].x * dOut_1.y;
    *&(((&left_d_result_1)->rows + (int(1)))->x) = (*right_2).primal_0.x * dOut_1.y;
    float sum_3 = sum_2 + (*left_2).primal_0.rows[int(2)].x * dOut_1.z;
    *&(((&left_d_result_1)->rows + (int(2)))->x) = (*right_2).primal_0.x * dOut_1.z;
    float3  right_d_result_1;
    *&((&right_d_result_1)->x) = sum_3;
    float _S2 = (*left_2).primal_0.rows[int(0)].y * dOut_1.x;
    *&(((&left_d_result_1)->rows + (int(0)))->y) = (*right_2).primal_0.y * dOut_1.x;
    float sum_4 = _S2 + (*left_2).primal_0.rows[int(1)].y * dOut_1.y;
    *&(((&left_d_result_1)->rows + (int(1)))->y) = (*right_2).primal_0.y * dOut_1.y;
    float sum_5 = sum_4 + (*left_2).primal_0.rows[int(2)].y * dOut_1.z;
    *&(((&left_d_result_1)->rows + (int(2)))->y) = (*right_2).primal_0.y * dOut_1.z;
    *&((&right_d_result_1)->y) = sum_5;
    float _S3 = (*left_2).primal_0.rows[int(0)].z * dOut_1.x;
    *&(((&left_d_result_1)->rows + (int(0)))->z) = (*right_2).primal_0.z * dOut_1.x;
    float sum_6 = _S3 + (*left_2).primal_0.rows[int(1)].z * dOut_1.y;
    *&(((&left_d_result_1)->rows + (int(1)))->z) = (*right_2).primal_0.z * dOut_1.y;
    float sum_7 = sum_6 + (*left_2).primal_0.rows[int(2)].z * dOut_1.z;
    *&(((&left_d_result_1)->rows + (int(2)))->z) = (*right_2).primal_0.z * dOut_1.z;
    *&((&right_d_result_1)->z) = sum_7;
    left_2->primal_0 = (*left_2).primal_0;
    left_2->differential_0 = left_d_result_1;
    right_2->primal_0 = (*right_2).primal_0;
    right_2->differential_0 = right_d_result_1;
    return;
}

inline __device__ float3  mul_2(Matrix<float, 3, 3>  left_3, float3  right_3)
{
    float3  result_3;
    int i_1 = int(0);
    for(;;)
    {
        if(i_1 < int(3))
        {
        }
        else
        {
            break;
        }
        int j_0 = int(0);
        float sum_8 = 0.0f;
        for(;;)
        {
            if(j_0 < int(3))
            {
            }
            else
            {
                break;
            }
            float sum_9 = sum_8 + _slang_vector_get_element(left_3.rows[i_1], j_0) * _slang_vector_get_element(right_3, j_0);
            j_0 = j_0 + int(1);
            sum_8 = sum_9;
        }
        *_slang_vector_get_element_ptr(&result_3, i_1) = sum_8;
        i_1 = i_1 + int(1);
    }
    return result_3;
}

inline __device__ float3  apply_sqrt_covar_to_vec(float4  quat_3, float3  scale_2, float3  vec_0)
{
    float x_5 = quat_3.y;
    float x2_3 = x_5 * x_5;
    float y2_3 = quat_3.z * quat_3.z;
    float z2_3 = quat_3.w * quat_3.w;
    float xy_3 = quat_3.y * quat_3.z;
    float xz_3 = quat_3.y * quat_3.w;
    float yz_3 = quat_3.z * quat_3.w;
    float wx_3 = quat_3.x * quat_3.y;
    float wy_3 = quat_3.x * quat_3.z;
    float wz_3 = quat_3.x * quat_3.w;
    return mul_2(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_3 + z2_3), 2.0f * (xy_3 + wz_3), 2.0f * (xz_3 - wy_3), 2.0f * (xy_3 - wz_3), 1.0f - 2.0f * (x2_3 + z2_3), 2.0f * (yz_3 + wx_3), 2.0f * (xz_3 + wy_3), 2.0f * (yz_3 - wx_3), 1.0f - 2.0f * (x2_3 + y2_3))), scale_2 * vec_0);
}

inline __device__ float3  apply_covar_to_vec(float4  quat_4, float3  scale_3, float3  vec_1)
{
    float x_6 = quat_4.y;
    float x2_4 = x_6 * x_6;
    float y2_4 = quat_4.z * quat_4.z;
    float z2_4 = quat_4.w * quat_4.w;
    float xy_4 = quat_4.y * quat_4.z;
    float xz_4 = quat_4.y * quat_4.w;
    float yz_4 = quat_4.z * quat_4.w;
    float wx_4 = quat_4.x * quat_4.y;
    float wy_4 = quat_4.x * quat_4.z;
    float wz_4 = quat_4.x * quat_4.w;
    Matrix<float, 3, 3>  M_2 = mul_1(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_4 + z2_4), 2.0f * (xy_4 + wz_4), 2.0f * (xz_4 - wy_4), 2.0f * (xy_4 - wz_4), 1.0f - 2.0f * (x2_4 + z2_4), 2.0f * (yz_4 + wx_4), 2.0f * (xz_4 + wy_4), 2.0f * (yz_4 - wx_4), 1.0f - 2.0f * (x2_4 + y2_4))), makeMatrix<float, 3, 3> (scale_3.x, 0.0f, 0.0f, 0.0f, scale_3.y, 0.0f, 0.0f, 0.0f, scale_3.z));
    return mul_2(mul_1(M_2, transpose_0(M_2)), vec_1);
}

struct DiffPair_float_0
{
    float primal_0;
    float differential_0;
};

inline __device__ DiffPair_float_0 _d_atan2_0(DiffPair_float_0 * dpy_0, DiffPair_float_0 * dpx_0)
{
    float _S4 = dpx_0->primal_0 * dpx_0->primal_0 + dpy_0->primal_0 * dpy_0->primal_0;
    DiffPair_float_0 _S5 = { (F32_atan2((dpy_0->primal_0), (dpx_0->primal_0))), - dpy_0->primal_0 / _S4 * dpx_0->differential_0 + dpx_0->primal_0 / _S4 * dpy_0->differential_0 };
    return _S5;
}

inline __device__ DiffPair_float_0 _d_sqrt_0(DiffPair_float_0 * dpx_1)
{
    DiffPair_float_0 _S6 = { (F32_sqrt((dpx_1->primal_0))), 0.5f / (F32_sqrt(((F32_max((1.00000001168609742e-07f), (dpx_1->primal_0)))))) * dpx_1->differential_0 };
    return _S6;
}

inline __device__ void _d_dot_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_2, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpy_1, float dOut_2)
{
    float3  x_d_result_0;
    *&((&x_d_result_0)->x) = (*dpy_1).primal_0.x * dOut_2;
    float3  y_d_result_0;
    *&((&y_d_result_0)->x) = (*dpx_2).primal_0.x * dOut_2;
    *&((&x_d_result_0)->y) = (*dpy_1).primal_0.y * dOut_2;
    *&((&y_d_result_0)->y) = (*dpx_2).primal_0.y * dOut_2;
    *&((&x_d_result_0)->z) = (*dpy_1).primal_0.z * dOut_2;
    *&((&y_d_result_0)->z) = (*dpx_2).primal_0.z * dOut_2;
    dpx_2->primal_0 = (*dpx_2).primal_0;
    dpx_2->differential_0 = x_d_result_0;
    dpy_1->primal_0 = (*dpy_1).primal_0;
    dpy_1->differential_0 = y_d_result_0;
    return;
}

struct DiffPair_vectorx3Cfloatx2C2x3E_0
{
    float2  primal_0;
    float2  differential_0;
};

inline __device__ DiffPair_float_0 _d_dot_1(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_3, DiffPair_vectorx3Cfloatx2C2x3E_0 * dpy_2)
{
    DiffPair_float_0 _S7 = { *&((&dpx_3->primal_0)->x) * *&((&dpy_2->primal_0)->x) + *&((&dpx_3->primal_0)->y) * *&((&dpy_2->primal_0)->y), *&((&dpx_3->primal_0)->x) * *&((&dpy_2->differential_0)->x) + *&((&dpy_2->primal_0)->x) * *&((&dpx_3->differential_0)->x) + *&((&dpx_3->primal_0)->y) * *&((&dpy_2->differential_0)->y) + *&((&dpy_2->primal_0)->y) * *&((&dpx_3->differential_0)->y) };
    return _S7;
}

inline __device__ float dot_0(float2  x_7, float2  y_0)
{
    int i_2 = int(0);
    float result_4 = 0.0f;
    for(;;)
    {
        if(i_2 < int(2))
        {
        }
        else
        {
            break;
        }
        float result_5 = result_4 + _slang_vector_get_element(x_7, i_2) * _slang_vector_get_element(y_0, i_2);
        i_2 = i_2 + int(1);
        result_4 = result_5;
    }
    return result_4;
}

inline __device__ float dot_1(float3  x_8, float3  y_1)
{
    int i_3 = int(0);
    float result_6 = 0.0f;
    for(;;)
    {
        if(i_3 < int(3))
        {
        }
        else
        {
            break;
        }
        float result_7 = result_6 + _slang_vector_get_element(x_8, i_3) * _slang_vector_get_element(y_1, i_3);
        i_3 = i_3 + int(1);
        result_6 = result_7;
    }
    return result_6;
}

inline __device__ float length_0(float2  x_9)
{
    return (F32_sqrt((dot_0(x_9, x_9))));
}

inline __device__ float length_1(float3  x_10)
{
    return (F32_sqrt((dot_1(x_10, x_10))));
}

inline __device__ bool equirect_proj_nav(float3  p_view_0, float4  intrins_0, float2  * uv_0)
{
    *uv_0 = make_float2 (intrins_0.x * (F32_atan2((p_view_0.x), (p_view_0.z))) + intrins_0.z, intrins_0.y * (F32_atan2((p_view_0.y), (length_0(float2 {p_view_0.x, p_view_0.z})))) + intrins_0.w);
    return true;
}

inline __device__ DiffPair_float_0 s_fwd_length_impl_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_4)
{
    float _S8 = *&((&dpx_4->differential_0)->x) * *&((&dpx_4->primal_0)->x);
    float _S9 = *&((&dpx_4->differential_0)->y) * *&((&dpx_4->primal_0)->y);
    float s_diff_len_0 = _S8 + _S8 + (_S9 + _S9);
    DiffPair_float_0 _S10;
    (&_S10)->primal_0 = *&((&dpx_4->primal_0)->x) * *&((&dpx_4->primal_0)->x) + *&((&dpx_4->primal_0)->y) * *&((&dpx_4->primal_0)->y);
    (&_S10)->differential_0 = s_diff_len_0;
    DiffPair_float_0 _S11 = _d_sqrt_0(&_S10);
    DiffPair_float_0 _S12 = { _S11.primal_0, _S11.differential_0 };
    return _S12;
}

inline __device__ Matrix<float, 2, 3>  equirect_proj_jac(float3  p_view_1, float4  intrins_1)
{
    float _S13 = p_view_1.x;
    float _S14 = p_view_1.z;
    DiffPair_float_0 _S15;
    (&_S15)->primal_0 = _S13;
    (&_S15)->differential_0 = 1.0f;
    DiffPair_float_0 _S16;
    (&_S16)->primal_0 = _S14;
    (&_S16)->differential_0 = 0.0f;
    DiffPair_float_0 _S17 = _d_atan2_0(&_S15, &_S16);
    float _S18 = p_view_1.y;
    float2  _S19 = float2 {p_view_1.x, p_view_1.z};
    float2  _S20 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S21;
    (&_S21)->primal_0 = _S19;
    (&_S21)->differential_0 = _S20;
    DiffPair_float_0 _S22 = s_fwd_length_impl_0(&_S21);
    DiffPair_float_0 _S23;
    (&_S23)->primal_0 = _S18;
    (&_S23)->differential_0 = 0.0f;
    DiffPair_float_0 _S24;
    (&_S24)->primal_0 = _S22.primal_0;
    (&_S24)->differential_0 = _S22.differential_0;
    DiffPair_float_0 _S25 = _d_atan2_0(&_S23, &_S24);
    float fx_0 = intrins_1.x;
    float fy_0 = intrins_1.y;
    float _S26 = _S25.differential_0 * fy_0;
    Matrix<float, 2, 3>  J_0;
    *&(((&J_0)->rows + (int(0)))->x) = _S17.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->x) = _S26;
    DiffPair_float_0 _S27;
    (&_S27)->primal_0 = _S13;
    (&_S27)->differential_0 = 0.0f;
    DiffPair_float_0 _S28;
    (&_S28)->primal_0 = _S14;
    (&_S28)->differential_0 = 0.0f;
    DiffPair_float_0 _S29 = _d_atan2_0(&_S27, &_S28);
    float2  _S30 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S31;
    (&_S31)->primal_0 = _S19;
    (&_S31)->differential_0 = _S30;
    DiffPair_float_0 _S32 = s_fwd_length_impl_0(&_S31);
    DiffPair_float_0 _S33;
    (&_S33)->primal_0 = _S18;
    (&_S33)->differential_0 = 1.0f;
    DiffPair_float_0 _S34;
    (&_S34)->primal_0 = _S32.primal_0;
    (&_S34)->differential_0 = _S32.differential_0;
    DiffPair_float_0 _S35 = _d_atan2_0(&_S33, &_S34);
    float _S36 = _S35.differential_0 * fy_0;
    *&(((&J_0)->rows + (int(0)))->y) = _S29.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->y) = _S36;
    DiffPair_float_0 _S37;
    (&_S37)->primal_0 = _S13;
    (&_S37)->differential_0 = 0.0f;
    DiffPair_float_0 _S38;
    (&_S38)->primal_0 = _S14;
    (&_S38)->differential_0 = 1.0f;
    DiffPair_float_0 _S39 = _d_atan2_0(&_S37, &_S38);
    float2  _S40 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S41;
    (&_S41)->primal_0 = _S19;
    (&_S41)->differential_0 = _S40;
    DiffPair_float_0 _S42 = s_fwd_length_impl_0(&_S41);
    DiffPair_float_0 _S43;
    (&_S43)->primal_0 = _S18;
    (&_S43)->differential_0 = 0.0f;
    DiffPair_float_0 _S44;
    (&_S44)->primal_0 = _S42.primal_0;
    (&_S44)->differential_0 = _S42.differential_0;
    DiffPair_float_0 _S45 = _d_atan2_0(&_S43, &_S44);
    float _S46 = _S45.differential_0 * fy_0;
    *&(((&J_0)->rows + (int(0)))->z) = _S39.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->z) = _S46;
    return J_0;
}

inline __device__ float determinant_0(Matrix<float, 2, 2>  m_0)
{
    return m_0.rows[int(0)].x * m_0.rows[int(1)].y - m_0.rows[int(0)].y * m_0.rows[int(1)].x;
}

inline __device__ bool is_valid_distortion_none(float2  uv_1, FixedArray<float, 1>  dist_coeffs_0)
{
    return true;
}

inline __device__ float2  DistNone_distort_0(float2  uv_2, FixedArray<float, 1>  * coeffs_0)
{
    return uv_2;
}

inline __device__ bool persp_proj_nav_none(float3  p_view_2, float4  intrins_2, FixedArray<float, 1>  dist_coeffs_1, float2  * uv_3)
{
    bool _S47;
    for(;;)
    {
        float2  _S48 = float2 {p_view_2.x, p_view_2.y};
        float _S49 = p_view_2.z;
        float2  uv0_0 = _S48 / make_float2 (_S49);
        bool _S50 = _S49 < 0.0f;
        if(_S50)
        {
            *uv_3 = uv0_0;
            _S47 = false;
            break;
        }
        float2  uv_4 = _S48 / make_float2 (_S49);
        FixedArray<float, 1>  _S51 = dist_coeffs_1;
        float2  _S52 = DistNone_distort_0(uv_4, &_S51);
        *uv_3 = make_float2 (intrins_2.x * _S52.x + intrins_2.z, intrins_2.y * _S52.y + intrins_2.w);
        _S47 = true;
        break;
    }
    return _S47;
}

inline __device__ bool fisheye_proj_nav_none(float3  p_view_3, float4  intrins_3, FixedArray<float, 1>  dist_coeffs_2, float2  * uv_5)
{
    float2  _S53 = float2 {p_view_3.x, p_view_3.y};
    float r_3 = length_0(_S53);
    float _S54 = p_view_3.z;
    float theta_0 = (F32_atan2((r_3), (_S54)));
    float k_0;
    if(theta_0 < 0.00100000004749745f)
    {
        k_0 = (1.0f - theta_0 * theta_0 / 3.0f) / _S54;
    }
    else
    {
        k_0 = theta_0 / r_3;
    }
    float2  _S55 = _S53 * make_float2 (k_0);
    FixedArray<float, 1>  _S56 = dist_coeffs_2;
    float2  _S57 = DistNone_distort_0(_S55, &_S56);
    *uv_5 = make_float2 (intrins_3.x * _S57.x + intrins_3.z, intrins_3.y * _S57.y + intrins_3.w);
    return true;
}

inline __device__ DiffPair_float_0 _d_sin_0(DiffPair_float_0 * dpx_5)
{
    DiffPair_float_0 _S58 = { (F32_sin((dpx_5->primal_0))), (F32_cos((dpx_5->primal_0))) * dpx_5->differential_0 };
    return _S58;
}

inline __device__ bool equisolid_proj_nav_none(float3  p_view_4, float4  intrins_4, FixedArray<float, 1>  dist_coeffs_3, float2  * uv_6)
{
    float2  _S59 = float2 {p_view_4.x, p_view_4.y};
    float r_4 = length_0(_S59);
    float _S60 = p_view_4.z;
    float theta_1 = (F32_atan2((r_4), (_S60)));
    float k_1;
    if(r_4 < 9.99999997475242708e-07f)
    {
        k_1 = (1.0f - theta_1 * theta_1 / 24.0f) / _S60;
    }
    else
    {
        k_1 = 2.0f * (F32_sin((0.5f * theta_1))) / r_4;
    }
    float2  _S61 = _S59 * make_float2 (k_1);
    FixedArray<float, 1>  _S62 = dist_coeffs_3;
    float2  _S63 = DistNone_distort_0(_S61, &_S62);
    *uv_6 = make_float2 (intrins_4.x * _S63.x + intrins_4.z, intrins_4.y * _S63.y + intrins_4.w);
    return true;
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistNone_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_0, FixedArray<float, 1>  * coeffs_1)
{
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S64 = { dpuv_0->primal_0, dpuv_0->differential_0 };
    return _S64;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_none(float3  p_view_5, float4  intrins_5, FixedArray<float, 1>  dist_coeffs_4)
{
    float2  _S65 = float2 {p_view_5.x, p_view_5.y};
    float _S66 = p_view_5.z;
    float2  _S67 = _S65 * make_float2 (0.0f);
    float _S68 = _S66 * _S66;
    float2  s_diff_uv_0 = (make_float2 (1.0f, 0.0f) * make_float2 (_S66) - _S67) / make_float2 (_S68);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S69;
    (&_S69)->primal_0 = _S65 / make_float2 (_S66);
    (&_S69)->differential_0 = s_diff_uv_0;
    FixedArray<float, 1>  _S70 = dist_coeffs_4;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S71 = s_fwd_DistNone_distort_0(&_S69, &_S70);
    float fx_1 = intrins_5.x;
    float fy_1 = intrins_5.y;
    float _S72 = _S71.differential_0.y * fy_1;
    Matrix<float, 2, 3>  J_1;
    *&(((&J_1)->rows + (int(0)))->x) = _S71.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->x) = _S72;
    float2  s_diff_uv_1 = (make_float2 (0.0f, 1.0f) * make_float2 (_S66) - _S67) / make_float2 (_S68);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S73;
    (&_S73)->primal_0 = _S65 / make_float2 (_S66);
    (&_S73)->differential_0 = s_diff_uv_1;
    FixedArray<float, 1>  _S74 = dist_coeffs_4;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S75 = s_fwd_DistNone_distort_0(&_S73, &_S74);
    float _S76 = _S75.differential_0.y * fy_1;
    *&(((&J_1)->rows + (int(0)))->y) = _S75.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->y) = _S76;
    float2  s_diff_uv_2 = (make_float2 (0.0f, 0.0f) * make_float2 (_S66) - _S65) / make_float2 (_S68);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S77;
    (&_S77)->primal_0 = _S65 / make_float2 (_S66);
    (&_S77)->differential_0 = s_diff_uv_2;
    FixedArray<float, 1>  _S78 = dist_coeffs_4;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S79 = s_fwd_DistNone_distort_0(&_S77, &_S78);
    float _S80 = _S79.differential_0.y * fy_1;
    *&(((&J_1)->rows + (int(0)))->z) = _S79.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->z) = _S80;
    return J_1;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_none(float3  p_view_6, float4  intrins_6, FixedArray<float, 1>  dist_coeffs_5)
{
    Matrix<float, 2, 3>  J_2;
    float2  _S81 = float2 {p_view_6.x, p_view_6.y};
    float2  _S82 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S83;
    (&_S83)->primal_0 = _S81;
    (&_S83)->differential_0 = _S82;
    DiffPair_float_0 _S84 = s_fwd_length_impl_0(&_S83);
    float _S85 = p_view_6.z;
    DiffPair_float_0 _S86;
    (&_S86)->primal_0 = _S84.primal_0;
    (&_S86)->differential_0 = _S84.differential_0;
    DiffPair_float_0 _S87;
    (&_S87)->primal_0 = _S85;
    (&_S87)->differential_0 = 0.0f;
    DiffPair_float_0 _S88 = _d_atan2_0(&_S86, &_S87);
    float k_2;
    float s_diff_k_0;
    if((_S88.primal_0) < 0.00100000004749745f)
    {
        float _S89 = _S88.differential_0 * _S88.primal_0;
        float _S90 = 1.0f - _S88.primal_0 * _S88.primal_0 / 3.0f;
        float _S91 = ((0.0f - (_S89 + _S89) * 0.3333333432674408f) * _S85 - _S90 * 0.0f) / (_S85 * _S85);
        k_2 = _S90 / _S85;
        s_diff_k_0 = _S91;
    }
    else
    {
        float _S92 = (_S88.differential_0 * _S84.primal_0 - _S88.primal_0 * _S84.differential_0) / (_S84.primal_0 * _S84.primal_0);
        k_2 = _S88.primal_0 / _S84.primal_0;
        s_diff_k_0 = _S92;
    }
    float2  _S93 = _S81 * make_float2 (k_2);
    float2  _S94 = _S82 * make_float2 (k_2) + make_float2 (s_diff_k_0) * _S81;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S95;
    (&_S95)->primal_0 = _S93;
    (&_S95)->differential_0 = _S94;
    FixedArray<float, 1>  _S96 = dist_coeffs_5;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S97 = s_fwd_DistNone_distort_0(&_S95, &_S96);
    float fx_2 = intrins_6.x;
    float fy_2 = intrins_6.y;
    float _S98 = _S97.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->x) = _S97.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->x) = _S98;
    float2  _S99 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S100;
    (&_S100)->primal_0 = _S81;
    (&_S100)->differential_0 = _S99;
    DiffPair_float_0 _S101 = s_fwd_length_impl_0(&_S100);
    DiffPair_float_0 _S102;
    (&_S102)->primal_0 = _S101.primal_0;
    (&_S102)->differential_0 = _S101.differential_0;
    DiffPair_float_0 _S103;
    (&_S103)->primal_0 = _S85;
    (&_S103)->differential_0 = 0.0f;
    DiffPair_float_0 _S104 = _d_atan2_0(&_S102, &_S103);
    if((_S104.primal_0) < 0.00100000004749745f)
    {
        float _S105 = _S104.differential_0 * _S104.primal_0;
        float _S106 = 1.0f - _S104.primal_0 * _S104.primal_0 / 3.0f;
        float _S107 = ((0.0f - (_S105 + _S105) * 0.3333333432674408f) * _S85 - _S106 * 0.0f) / (_S85 * _S85);
        k_2 = _S106 / _S85;
        s_diff_k_0 = _S107;
    }
    else
    {
        float _S108 = (_S104.differential_0 * _S101.primal_0 - _S104.primal_0 * _S101.differential_0) / (_S101.primal_0 * _S101.primal_0);
        k_2 = _S104.primal_0 / _S101.primal_0;
        s_diff_k_0 = _S108;
    }
    float2  _S109 = _S81 * make_float2 (k_2);
    float2  _S110 = _S99 * make_float2 (k_2) + make_float2 (s_diff_k_0) * _S81;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S111;
    (&_S111)->primal_0 = _S109;
    (&_S111)->differential_0 = _S110;
    FixedArray<float, 1>  _S112 = dist_coeffs_5;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S113 = s_fwd_DistNone_distort_0(&_S111, &_S112);
    float _S114 = _S113.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->y) = _S113.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->y) = _S114;
    float2  _S115 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S116;
    (&_S116)->primal_0 = _S81;
    (&_S116)->differential_0 = _S115;
    DiffPair_float_0 _S117 = s_fwd_length_impl_0(&_S116);
    DiffPair_float_0 _S118;
    (&_S118)->primal_0 = _S117.primal_0;
    (&_S118)->differential_0 = _S117.differential_0;
    DiffPair_float_0 _S119;
    (&_S119)->primal_0 = _S85;
    (&_S119)->differential_0 = 1.0f;
    DiffPair_float_0 _S120 = _d_atan2_0(&_S118, &_S119);
    if((_S120.primal_0) < 0.00100000004749745f)
    {
        float _S121 = _S120.differential_0 * _S120.primal_0;
        float _S122 = 1.0f - _S120.primal_0 * _S120.primal_0 / 3.0f;
        float _S123 = ((0.0f - (_S121 + _S121) * 0.3333333432674408f) * _S85 - _S122) / (_S85 * _S85);
        k_2 = _S122 / _S85;
        s_diff_k_0 = _S123;
    }
    else
    {
        float _S124 = (_S120.differential_0 * _S117.primal_0 - _S120.primal_0 * _S117.differential_0) / (_S117.primal_0 * _S117.primal_0);
        k_2 = _S120.primal_0 / _S117.primal_0;
        s_diff_k_0 = _S124;
    }
    float2  _S125 = _S81 * make_float2 (k_2);
    float2  _S126 = _S115 * make_float2 (k_2) + make_float2 (s_diff_k_0) * _S81;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S127;
    (&_S127)->primal_0 = _S125;
    (&_S127)->differential_0 = _S126;
    FixedArray<float, 1>  _S128 = dist_coeffs_5;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S129 = s_fwd_DistNone_distort_0(&_S127, &_S128);
    float _S130 = _S129.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->z) = _S129.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->z) = _S130;
    return J_2;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_none(float3  p_view_7, float4  intrins_7, FixedArray<float, 1>  dist_coeffs_6)
{
    Matrix<float, 2, 3>  J_3;
    float2  _S131 = float2 {p_view_7.x, p_view_7.y};
    float2  _S132 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S133;
    (&_S133)->primal_0 = _S131;
    (&_S133)->differential_0 = _S132;
    DiffPair_float_0 _S134 = s_fwd_length_impl_0(&_S133);
    float _S135 = p_view_7.z;
    DiffPair_float_0 _S136;
    (&_S136)->primal_0 = _S134.primal_0;
    (&_S136)->differential_0 = _S134.differential_0;
    DiffPair_float_0 _S137;
    (&_S137)->primal_0 = _S135;
    (&_S137)->differential_0 = 0.0f;
    DiffPair_float_0 _S138 = _d_atan2_0(&_S136, &_S137);
    float k_3;
    float s_diff_k_1;
    if((_S134.primal_0) < 9.99999997475242708e-07f)
    {
        float _S139 = _S138.differential_0 * _S138.primal_0;
        float _S140 = 1.0f - _S138.primal_0 * _S138.primal_0 / 24.0f;
        float _S141 = ((0.0f - (_S139 + _S139) * 0.0416666679084301f) * _S135 - _S140 * 0.0f) / (_S135 * _S135);
        k_3 = _S140 / _S135;
        s_diff_k_1 = _S141;
    }
    else
    {
        float _S142 = _S138.differential_0 * 0.5f;
        DiffPair_float_0 _S143;
        (&_S143)->primal_0 = 0.5f * _S138.primal_0;
        (&_S143)->differential_0 = _S142;
        DiffPair_float_0 _S144 = _d_sin_0(&_S143);
        float _S145 = 2.0f * _S144.primal_0;
        float _S146 = (_S144.differential_0 * 2.0f * _S134.primal_0 - _S145 * _S134.differential_0) / (_S134.primal_0 * _S134.primal_0);
        k_3 = _S145 / _S134.primal_0;
        s_diff_k_1 = _S146;
    }
    float2  _S147 = _S131 * make_float2 (k_3);
    float2  _S148 = _S132 * make_float2 (k_3) + make_float2 (s_diff_k_1) * _S131;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S149;
    (&_S149)->primal_0 = _S147;
    (&_S149)->differential_0 = _S148;
    FixedArray<float, 1>  _S150 = dist_coeffs_6;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S151 = s_fwd_DistNone_distort_0(&_S149, &_S150);
    float fx_3 = intrins_7.x;
    float fy_3 = intrins_7.y;
    float _S152 = _S151.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->x) = _S151.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->x) = _S152;
    float2  _S153 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S154;
    (&_S154)->primal_0 = _S131;
    (&_S154)->differential_0 = _S153;
    DiffPair_float_0 _S155 = s_fwd_length_impl_0(&_S154);
    DiffPair_float_0 _S156;
    (&_S156)->primal_0 = _S155.primal_0;
    (&_S156)->differential_0 = _S155.differential_0;
    DiffPair_float_0 _S157;
    (&_S157)->primal_0 = _S135;
    (&_S157)->differential_0 = 0.0f;
    DiffPair_float_0 _S158 = _d_atan2_0(&_S156, &_S157);
    if((_S155.primal_0) < 9.99999997475242708e-07f)
    {
        float _S159 = _S158.differential_0 * _S158.primal_0;
        float _S160 = 1.0f - _S158.primal_0 * _S158.primal_0 / 24.0f;
        float _S161 = ((0.0f - (_S159 + _S159) * 0.0416666679084301f) * _S135 - _S160 * 0.0f) / (_S135 * _S135);
        k_3 = _S160 / _S135;
        s_diff_k_1 = _S161;
    }
    else
    {
        float _S162 = _S158.differential_0 * 0.5f;
        DiffPair_float_0 _S163;
        (&_S163)->primal_0 = 0.5f * _S158.primal_0;
        (&_S163)->differential_0 = _S162;
        DiffPair_float_0 _S164 = _d_sin_0(&_S163);
        float _S165 = 2.0f * _S164.primal_0;
        float _S166 = (_S164.differential_0 * 2.0f * _S155.primal_0 - _S165 * _S155.differential_0) / (_S155.primal_0 * _S155.primal_0);
        k_3 = _S165 / _S155.primal_0;
        s_diff_k_1 = _S166;
    }
    float2  _S167 = _S131 * make_float2 (k_3);
    float2  _S168 = _S153 * make_float2 (k_3) + make_float2 (s_diff_k_1) * _S131;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S169;
    (&_S169)->primal_0 = _S167;
    (&_S169)->differential_0 = _S168;
    FixedArray<float, 1>  _S170 = dist_coeffs_6;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S171 = s_fwd_DistNone_distort_0(&_S169, &_S170);
    float _S172 = _S171.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->y) = _S171.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->y) = _S172;
    float2  _S173 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S174;
    (&_S174)->primal_0 = _S131;
    (&_S174)->differential_0 = _S173;
    DiffPair_float_0 _S175 = s_fwd_length_impl_0(&_S174);
    DiffPair_float_0 _S176;
    (&_S176)->primal_0 = _S175.primal_0;
    (&_S176)->differential_0 = _S175.differential_0;
    DiffPair_float_0 _S177;
    (&_S177)->primal_0 = _S135;
    (&_S177)->differential_0 = 1.0f;
    DiffPair_float_0 _S178 = _d_atan2_0(&_S176, &_S177);
    if((_S175.primal_0) < 9.99999997475242708e-07f)
    {
        float _S179 = _S178.differential_0 * _S178.primal_0;
        float _S180 = 1.0f - _S178.primal_0 * _S178.primal_0 / 24.0f;
        float _S181 = ((0.0f - (_S179 + _S179) * 0.0416666679084301f) * _S135 - _S180) / (_S135 * _S135);
        k_3 = _S180 / _S135;
        s_diff_k_1 = _S181;
    }
    else
    {
        float _S182 = _S178.differential_0 * 0.5f;
        DiffPair_float_0 _S183;
        (&_S183)->primal_0 = 0.5f * _S178.primal_0;
        (&_S183)->differential_0 = _S182;
        DiffPair_float_0 _S184 = _d_sin_0(&_S183);
        float _S185 = 2.0f * _S184.primal_0;
        float _S186 = (_S184.differential_0 * 2.0f * _S175.primal_0 - _S185 * _S175.differential_0) / (_S175.primal_0 * _S175.primal_0);
        k_3 = _S185 / _S175.primal_0;
        s_diff_k_1 = _S186;
    }
    float2  _S187 = _S131 * make_float2 (k_3);
    float2  _S188 = _S173 * make_float2 (k_3) + make_float2 (s_diff_k_1) * _S131;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S189;
    (&_S189)->primal_0 = _S187;
    (&_S189)->differential_0 = _S188;
    FixedArray<float, 1>  _S190 = dist_coeffs_6;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S191 = s_fwd_DistNone_distort_0(&_S189, &_S190);
    float _S192 = _S191.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->z) = _S191.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->z) = _S192;
    return J_3;
}

inline __device__ float2  distort_point_none(float2  uv_7, int camera_model_0, FixedArray<float, 1>  dist_coeffs_7)
{
    float2  _S193;
    for(;;)
    {
        if(camera_model_0 == int(3))
        {
            _S193 = uv_7;
            break;
        }
        float k_4;
        if(camera_model_0 == int(1))
        {
            float r_5 = length_0(uv_7);
            float theta_2 = (F32_atan((r_5)));
            if(r_5 < 0.00100000004749745f)
            {
                k_4 = 1.0f - theta_2 * theta_2 / 6.0f;
            }
            else
            {
                k_4 = theta_2 / r_5;
            }
            _S193 = uv_7 * make_float2 (k_4);
        }
        else
        {
            if(camera_model_0 == int(2))
            {
                float r_6 = length_0(uv_7);
                float theta_3 = (F32_atan((r_6)));
                if(r_6 < 0.00100000004749745f)
                {
                    k_4 = 1.0f - theta_3 * theta_3 / 24.0f;
                }
                else
                {
                    k_4 = 2.0f * (F32_sin((0.5f * theta_3))) / r_6;
                }
                _S193 = uv_7 * make_float2 (k_4);
            }
            else
            {
                _S193 = uv_7;
            }
        }
        FixedArray<float, 1>  _S194 = dist_coeffs_7;
        float2  _S195 = DistNone_distort_0(_S193, &_S194);
        _S193 = _S195;
        break;
    }
    return _S193;
}

inline __device__ bool undistort_point_0(float2  uv_8, FixedArray<float, 1>  * dist_coeffs_8, int maxiter_0, float2  * uv_undist_0)
{
    *uv_undist_0 = uv_8;
    return true;
}

inline __device__ float2  DistOpenCV_distort_0(float2  uv_9, FixedArray<float, 4>  * coeffs_2)
{
    float u_0 = uv_9.x;
    float v_0 = uv_9.y;
    float r2_0 = u_0 * u_0 + v_0 * v_0;
    return uv_9 * make_float2 (1.0f + r2_0 * ((*coeffs_2)[int(0)] + r2_0 * (*coeffs_2)[int(1)])) + make_float2 (2.0f * (*coeffs_2)[int(2)] * u_0 * v_0 + (*coeffs_2)[int(3)] * (r2_0 + 2.0f * u_0 * u_0), 2.0f * (*coeffs_2)[int(3)] * u_0 * v_0 + (*coeffs_2)[int(2)] * (r2_0 + 2.0f * v_0 * v_0));
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistOpenCV_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_1, FixedArray<float, 4>  * coeffs_3)
{
    float u_1 = dpuv_1->primal_0.x;
    float s_diff_u_0 = dpuv_1->differential_0.x;
    float v_1 = dpuv_1->primal_0.y;
    float s_diff_v_0 = dpuv_1->differential_0.y;
    float _S196 = s_diff_u_0 * u_1;
    float _S197 = s_diff_v_0 * v_1;
    float r2_1 = u_1 * u_1 + v_1 * v_1;
    float s_diff_r2_0 = _S196 + _S196 + (_S197 + _S197);
    float _S198 = (*coeffs_3)[int(0)] + r2_1 * (*coeffs_3)[int(1)];
    float radial_0 = 1.0f + r2_1 * _S198;
    float _S199 = 2.0f * (*coeffs_3)[int(2)];
    float _S200 = _S199 * u_1;
    float _S201 = 2.0f * u_1;
    float _S202 = 2.0f * (*coeffs_3)[int(3)];
    float _S203 = _S202 * u_1;
    float _S204 = 2.0f * v_1;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S205 = { dpuv_1->primal_0 * make_float2 (radial_0) + make_float2 (_S200 * v_1 + (*coeffs_3)[int(3)] * (r2_1 + _S201 * u_1), _S203 * v_1 + (*coeffs_3)[int(2)] * (r2_1 + _S204 * v_1)), dpuv_1->differential_0 * make_float2 (radial_0) + make_float2 (s_diff_r2_0 * _S198 + s_diff_r2_0 * (*coeffs_3)[int(1)] * r2_1) * dpuv_1->primal_0 + make_float2 (s_diff_u_0 * _S199 * v_1 + s_diff_v_0 * _S200 + (s_diff_r2_0 + (s_diff_u_0 * 2.0f * u_1 + s_diff_u_0 * _S201)) * (*coeffs_3)[int(3)], s_diff_u_0 * _S202 * v_1 + s_diff_v_0 * _S203 + (s_diff_r2_0 + (s_diff_v_0 * 2.0f * v_1 + s_diff_v_0 * _S204)) * (*coeffs_3)[int(2)]) };
    return _S205;
}

inline __device__ bool undistort_point_1(float2  uv_10, FixedArray<float, 4>  * dist_coeffs_9, int maxiter_1, float2  * uv_undist_1)
{
    int i_4 = int(0);
    float2  q_0 = uv_10;
    for(;;)
    {
        if(i_4 < maxiter_1)
        {
        }
        else
        {
            break;
        }
        float2  _S206 = DistOpenCV_distort_0(q_0, dist_coeffs_9);
        float2  r_7 = _S206 - uv_10;
        float2  _S207 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S208;
        (&_S208)->primal_0 = q_0;
        (&_S208)->differential_0 = _S207;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S209 = s_fwd_DistOpenCV_distort_0(&_S208, dist_coeffs_9);
        float2  _S210 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S211;
        (&_S211)->primal_0 = q_0;
        (&_S211)->differential_0 = _S210;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S212 = s_fwd_DistOpenCV_distort_0(&_S211, dist_coeffs_9);
        Matrix<float, 2, 2>  _S213 = transpose_1(makeMatrix<float, 2, 2> (_S209.differential_0, _S212.differential_0));
        float inv_det_0 = 1.0f / (_S213.rows[int(0)].x * _S213.rows[int(1)].y - _S213.rows[int(0)].y * _S213.rows[int(1)].x);
        float _S214 = r_7.x;
        float _S215 = r_7.y;
        float2  q_1 = q_0 - make_float2 ((_S214 * _S213.rows[int(1)].y - _S215 * _S213.rows[int(0)].y) * inv_det_0, (- _S214 * _S213.rows[int(1)].x + _S215 * _S213.rows[int(0)].x) * inv_det_0);
        i_4 = i_4 + int(1);
        q_0 = q_1;
    }
    *uv_undist_1 = q_0;
    float2  _S216 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S217;
    (&_S217)->primal_0 = q_0;
    (&_S217)->differential_0 = _S216;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S218 = s_fwd_DistOpenCV_distort_0(&_S217, dist_coeffs_9);
    float2  _S219 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S220;
    (&_S220)->primal_0 = q_0;
    (&_S220)->differential_0 = _S219;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S221 = s_fwd_DistOpenCV_distort_0(&_S220, dist_coeffs_9);
    Matrix<float, 2, 2>  _S222 = transpose_1(makeMatrix<float, 2, 2> (_S218.differential_0, _S221.differential_0));
    float _S223 = (F32_min((determinant_0(_S222)), ((F32_min((_S222.rows[int(0)].x), (_S222.rows[int(1)].y))))));
    bool _S224;
    if(_S223 > 0.25f)
    {
        _S224 = _S223 < 4.0f;
    }
    else
    {
        _S224 = false;
    }
    if(_S224)
    {
        float2  _S225 = DistOpenCV_distort_0(q_0, dist_coeffs_9);
        _S224 = (dot_0(q_0, _S225)) >= 0.0f;
    }
    else
    {
        _S224 = false;
    }
    if(_S224)
    {
        float2  _S226 = DistOpenCV_distort_0(*uv_undist_1, dist_coeffs_9);
        _S224 = (length_0(_S226 - uv_10)) < 0.00999999977648258f;
    }
    else
    {
        _S224 = false;
    }
    return _S224;
}

inline __device__ float2  DistThinPrism_distort_0(float2  uv_11, FixedArray<float, 8>  * coeffs_4)
{
    float u_2 = uv_11.x;
    float v_2 = uv_11.y;
    float r2_2 = u_2 * u_2 + v_2 * v_2;
    return uv_11 * make_float2 (1.0f + r2_2 * ((*coeffs_4)[int(0)] + r2_2 * ((*coeffs_4)[int(1)] + r2_2 * ((*coeffs_4)[int(2)] + r2_2 * (*coeffs_4)[int(3)])))) + make_float2 (2.0f * (*coeffs_4)[int(4)] * u_2 * v_2 + (*coeffs_4)[int(5)] * (r2_2 + 2.0f * u_2 * u_2) + (*coeffs_4)[int(6)] * r2_2, 2.0f * (*coeffs_4)[int(5)] * u_2 * v_2 + (*coeffs_4)[int(4)] * (r2_2 + 2.0f * v_2 * v_2) + (*coeffs_4)[int(7)] * r2_2);
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistThinPrism_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_2, FixedArray<float, 8>  * coeffs_5)
{
    float u_3 = dpuv_2->primal_0.x;
    float s_diff_u_1 = dpuv_2->differential_0.x;
    float v_3 = dpuv_2->primal_0.y;
    float s_diff_v_1 = dpuv_2->differential_0.y;
    float _S227 = s_diff_u_1 * u_3;
    float _S228 = s_diff_v_1 * v_3;
    float r2_3 = u_3 * u_3 + v_3 * v_3;
    float s_diff_r2_1 = _S227 + _S227 + (_S228 + _S228);
    float _S229 = (*coeffs_5)[int(2)] + r2_3 * (*coeffs_5)[int(3)];
    float _S230 = (*coeffs_5)[int(1)] + r2_3 * _S229;
    float _S231 = (*coeffs_5)[int(0)] + r2_3 * _S230;
    float radial_1 = 1.0f + r2_3 * _S231;
    float _S232 = 2.0f * (*coeffs_5)[int(4)];
    float _S233 = _S232 * u_3;
    float _S234 = 2.0f * u_3;
    float _S235 = 2.0f * (*coeffs_5)[int(5)];
    float _S236 = _S235 * u_3;
    float _S237 = 2.0f * v_3;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S238 = { dpuv_2->primal_0 * make_float2 (radial_1) + make_float2 (_S233 * v_3 + (*coeffs_5)[int(5)] * (r2_3 + _S234 * u_3) + (*coeffs_5)[int(6)] * r2_3, _S236 * v_3 + (*coeffs_5)[int(4)] * (r2_3 + _S237 * v_3) + (*coeffs_5)[int(7)] * r2_3), dpuv_2->differential_0 * make_float2 (radial_1) + make_float2 (s_diff_r2_1 * _S231 + (s_diff_r2_1 * _S230 + (s_diff_r2_1 * _S229 + s_diff_r2_1 * (*coeffs_5)[int(3)] * r2_3) * r2_3) * r2_3) * dpuv_2->primal_0 + make_float2 (s_diff_u_1 * _S232 * v_3 + s_diff_v_1 * _S233 + (s_diff_r2_1 + (s_diff_u_1 * 2.0f * u_3 + s_diff_u_1 * _S234)) * (*coeffs_5)[int(5)] + s_diff_r2_1 * (*coeffs_5)[int(6)], s_diff_u_1 * _S235 * v_3 + s_diff_v_1 * _S236 + (s_diff_r2_1 + (s_diff_v_1 * 2.0f * v_3 + s_diff_v_1 * _S237)) * (*coeffs_5)[int(4)] + s_diff_r2_1 * (*coeffs_5)[int(7)]) };
    return _S238;
}

inline __device__ bool undistort_point_2(float2  uv_12, FixedArray<float, 8>  * dist_coeffs_10, int maxiter_2, float2  * uv_undist_2)
{
    int i_5 = int(0);
    float2  q_2 = uv_12;
    for(;;)
    {
        if(i_5 < maxiter_2)
        {
        }
        else
        {
            break;
        }
        float2  _S239 = DistThinPrism_distort_0(q_2, dist_coeffs_10);
        float2  r_8 = _S239 - uv_12;
        float2  _S240 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S241;
        (&_S241)->primal_0 = q_2;
        (&_S241)->differential_0 = _S240;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S242 = s_fwd_DistThinPrism_distort_0(&_S241, dist_coeffs_10);
        float2  _S243 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S244;
        (&_S244)->primal_0 = q_2;
        (&_S244)->differential_0 = _S243;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S245 = s_fwd_DistThinPrism_distort_0(&_S244, dist_coeffs_10);
        Matrix<float, 2, 2>  _S246 = transpose_1(makeMatrix<float, 2, 2> (_S242.differential_0, _S245.differential_0));
        float inv_det_1 = 1.0f / (_S246.rows[int(0)].x * _S246.rows[int(1)].y - _S246.rows[int(0)].y * _S246.rows[int(1)].x);
        float _S247 = r_8.x;
        float _S248 = r_8.y;
        float2  q_3 = q_2 - make_float2 ((_S247 * _S246.rows[int(1)].y - _S248 * _S246.rows[int(0)].y) * inv_det_1, (- _S247 * _S246.rows[int(1)].x + _S248 * _S246.rows[int(0)].x) * inv_det_1);
        i_5 = i_5 + int(1);
        q_2 = q_3;
    }
    *uv_undist_2 = q_2;
    float2  _S249 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S250;
    (&_S250)->primal_0 = q_2;
    (&_S250)->differential_0 = _S249;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S251 = s_fwd_DistThinPrism_distort_0(&_S250, dist_coeffs_10);
    float2  _S252 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S253;
    (&_S253)->primal_0 = q_2;
    (&_S253)->differential_0 = _S252;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S254 = s_fwd_DistThinPrism_distort_0(&_S253, dist_coeffs_10);
    Matrix<float, 2, 2>  _S255 = transpose_1(makeMatrix<float, 2, 2> (_S251.differential_0, _S254.differential_0));
    float _S256 = (F32_min((determinant_0(_S255)), ((F32_min((_S255.rows[int(0)].x), (_S255.rows[int(1)].y))))));
    bool _S257;
    if(_S256 > 0.25f)
    {
        _S257 = _S256 < 4.0f;
    }
    else
    {
        _S257 = false;
    }
    if(_S257)
    {
        float2  _S258 = DistThinPrism_distort_0(q_2, dist_coeffs_10);
        _S257 = (dot_0(q_2, _S258)) >= 0.0f;
    }
    else
    {
        _S257 = false;
    }
    if(_S257)
    {
        float2  _S259 = DistThinPrism_distort_0(*uv_undist_2, dist_coeffs_10);
        _S257 = (length_0(_S259 - uv_12)) < 0.00999999977648258f;
    }
    else
    {
        _S257 = false;
    }
    return _S257;
}

inline __device__ int clamp_0(int x_11, int minBound_0, int maxBound_0)
{
    return (I32_min(((I32_max((x_11), (minBound_0)))), (maxBound_0)));
}

inline __device__ float DistKBPolarSpline_cubic_0(float a_0, float b_0, float c_3, float d_0, float t_0)
{
    return b_0 + 0.5f * t_0 * (c_3 - a_0 + t_0 * (2.0f * a_0 - 5.0f * b_0 + 4.0f * c_3 - d_0 + t_0 * (3.0f * (b_0 - c_3) + d_0 - a_0)));
}

inline __device__ float2  DistKBPolarSpline_distort_0(float2  uv_13, FixedArray<float, 58>  * coeffs_6)
{
    float r2_4 = dot_0(uv_13, uv_13);
    float2  kb_0 = uv_13 * make_float2 (1.0f + r2_4 * ((*coeffs_6)[int(0)] + r2_4 * ((*coeffs_6)[int(1)] + r2_4 * ((*coeffs_6)[int(2)] + r2_4 * (*coeffs_6)[int(3)]))));
    float2  grid_0 = kb_0 * make_float2 ((*coeffs_6)[int(4)], (*coeffs_6)[int(5)]);
    if((dot_0(grid_0, grid_0)) < 9.99999968265522539e-21f)
    {
        return kb_0;
    }
    float radius_0 = length_0(grid_0);
    float _S260 = grid_0.y;
    float _S261 = grid_0.x;
    float theta_4 = (F32_atan2((_S260), (_S261))) * 0.79577469825744629f;
    float theta_5;
    if(theta_4 < 0.0f)
    {
        theta_5 = theta_4 + 5.0f;
    }
    else
    {
        theta_5 = theta_4;
    }
    int _S262 = int((F32_floor((radius_0))));
    int _S263 = int((F32_floor((theta_5))));
    int2  _S264 = make_int2 (int(0));
    float2  _S265 = make_float2 ((float)_S264.x, (float)_S264.y);
    float2  rt_0 = _S265;
    FixedArray<float, 4>  rows_0;
    int _S266 = clamp_0(_S262 - int(1), int(0), int(6));
    int col_0 = ((_S263 - int(1)) % int(5) + int(5)) % int(5);
    FixedArray<float, 4>  nodes_0;
    bool _S267 = _S266 < int(2);
    float _S268;
    if(_S267)
    {
        _S268 = 0.0f;
    }
    else
    {
        _S268 = (*coeffs_6)[int(8) + (_S266 - int(2)) * int(5) + col_0];
    }
    nodes_0[int(0)] = _S268;
    int col_1 = ((_S263 + int(1) - int(1)) % int(5) + int(5)) % int(5);
    if(_S267)
    {
        _S268 = 0.0f;
    }
    else
    {
        _S268 = (*coeffs_6)[int(8) + (_S266 - int(2)) * int(5) + col_1];
    }
    nodes_0[int(1)] = _S268;
    int col_2 = ((_S263 + int(2) - int(1)) % int(5) + int(5)) % int(5);
    if(_S267)
    {
        _S268 = 0.0f;
    }
    else
    {
        _S268 = (*coeffs_6)[int(8) + (_S266 - int(2)) * int(5) + col_2];
    }
    nodes_0[int(2)] = _S268;
    int col_3 = ((_S263 + int(3) - int(1)) % int(5) + int(5)) % int(5);
    if(_S267)
    {
        _S268 = 0.0f;
    }
    else
    {
        _S268 = (*coeffs_6)[int(8) + (_S266 - int(2)) * int(5) + col_3];
    }
    nodes_0[int(3)] = _S268;
    float _S269 = theta_5 - float(_S263);
    rows_0[int(0)] = DistKBPolarSpline_cubic_0(nodes_0[int(0)], nodes_0[int(1)], nodes_0[int(2)], nodes_0[int(3)], _S269);
    int _S270 = clamp_0(_S262 + int(1) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_1;
    bool _S271 = _S270 < int(2);
    if(_S271)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S270 - int(2)) * int(5) + col_0];
    }
    nodes_1[int(0)] = theta_5;
    if(_S271)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S270 - int(2)) * int(5) + col_1];
    }
    nodes_1[int(1)] = theta_5;
    if(_S271)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S270 - int(2)) * int(5) + col_2];
    }
    nodes_1[int(2)] = theta_5;
    if(_S271)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S270 - int(2)) * int(5) + col_3];
    }
    nodes_1[int(3)] = theta_5;
    rows_0[int(1)] = DistKBPolarSpline_cubic_0(nodes_1[int(0)], nodes_1[int(1)], nodes_1[int(2)], nodes_1[int(3)], _S269);
    int _S272 = clamp_0(_S262 + int(2) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_2;
    bool _S273 = _S272 < int(2);
    if(_S273)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S272 - int(2)) * int(5) + col_0];
    }
    nodes_2[int(0)] = theta_5;
    if(_S273)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S272 - int(2)) * int(5) + col_1];
    }
    nodes_2[int(1)] = theta_5;
    if(_S273)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S272 - int(2)) * int(5) + col_2];
    }
    nodes_2[int(2)] = theta_5;
    if(_S273)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S272 - int(2)) * int(5) + col_3];
    }
    nodes_2[int(3)] = theta_5;
    rows_0[int(2)] = DistKBPolarSpline_cubic_0(nodes_2[int(0)], nodes_2[int(1)], nodes_2[int(2)], nodes_2[int(3)], _S269);
    int _S274 = clamp_0(_S262 + int(3) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_3;
    bool _S275 = _S274 < int(2);
    if(_S275)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S274 - int(2)) * int(5) + col_0];
    }
    nodes_3[int(0)] = theta_5;
    if(_S275)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S274 - int(2)) * int(5) + col_1];
    }
    nodes_3[int(1)] = theta_5;
    if(_S275)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S274 - int(2)) * int(5) + col_2];
    }
    nodes_3[int(2)] = theta_5;
    if(_S275)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(8) + (_S274 - int(2)) * int(5) + col_3];
    }
    nodes_3[int(3)] = theta_5;
    float _S276 = DistKBPolarSpline_cubic_0(nodes_3[int(0)], nodes_3[int(1)], nodes_3[int(2)], nodes_3[int(3)], _S269);
    rows_0[int(3)] = _S276;
    float _S277 = radius_0 - float(_S262);
    *&((&rt_0)->x) = DistKBPolarSpline_cubic_0(rows_0[int(0)], rows_0[int(1)], rows_0[int(2)], _S276, _S277);
    FixedArray<float, 4>  rows_1;
    FixedArray<float, 4>  nodes_4;
    if(_S267)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S266 - int(2)) * int(5) + col_0];
    }
    nodes_4[int(0)] = theta_5;
    if(_S267)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S266 - int(2)) * int(5) + col_1];
    }
    nodes_4[int(1)] = theta_5;
    if(_S267)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S266 - int(2)) * int(5) + col_2];
    }
    nodes_4[int(2)] = theta_5;
    if(_S267)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S266 - int(2)) * int(5) + col_3];
    }
    nodes_4[int(3)] = theta_5;
    rows_1[int(0)] = DistKBPolarSpline_cubic_0(nodes_4[int(0)], nodes_4[int(1)], nodes_4[int(2)], nodes_4[int(3)], _S269);
    FixedArray<float, 4>  nodes_5;
    if(_S271)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S270 - int(2)) * int(5) + col_0];
    }
    nodes_5[int(0)] = theta_5;
    if(_S271)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S270 - int(2)) * int(5) + col_1];
    }
    nodes_5[int(1)] = theta_5;
    if(_S271)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S270 - int(2)) * int(5) + col_2];
    }
    nodes_5[int(2)] = theta_5;
    if(_S271)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S270 - int(2)) * int(5) + col_3];
    }
    nodes_5[int(3)] = theta_5;
    rows_1[int(1)] = DistKBPolarSpline_cubic_0(nodes_5[int(0)], nodes_5[int(1)], nodes_5[int(2)], nodes_5[int(3)], _S269);
    FixedArray<float, 4>  nodes_6;
    if(_S273)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S272 - int(2)) * int(5) + col_0];
    }
    nodes_6[int(0)] = theta_5;
    if(_S273)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S272 - int(2)) * int(5) + col_1];
    }
    nodes_6[int(1)] = theta_5;
    if(_S273)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S272 - int(2)) * int(5) + col_2];
    }
    nodes_6[int(2)] = theta_5;
    if(_S273)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S272 - int(2)) * int(5) + col_3];
    }
    nodes_6[int(3)] = theta_5;
    rows_1[int(2)] = DistKBPolarSpline_cubic_0(nodes_6[int(0)], nodes_6[int(1)], nodes_6[int(2)], nodes_6[int(3)], _S269);
    FixedArray<float, 4>  nodes_7;
    if(_S275)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S274 - int(2)) * int(5) + col_0];
    }
    nodes_7[int(0)] = theta_5;
    if(_S275)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S274 - int(2)) * int(5) + col_1];
    }
    nodes_7[int(1)] = theta_5;
    if(_S275)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S274 - int(2)) * int(5) + col_2];
    }
    nodes_7[int(2)] = theta_5;
    if(_S275)
    {
        theta_5 = 0.0f;
    }
    else
    {
        theta_5 = (*coeffs_6)[int(33) + (_S274 - int(2)) * int(5) + col_3];
    }
    nodes_7[int(3)] = theta_5;
    float _S278 = DistKBPolarSpline_cubic_0(nodes_7[int(0)], nodes_7[int(1)], nodes_7[int(2)], nodes_7[int(3)], _S269);
    rows_1[int(3)] = _S278;
    *&((&rt_0)->y) = DistKBPolarSpline_cubic_0(rows_1[int(0)], rows_1[int(1)], rows_1[int(2)], _S278, _S277);
    return kb_0 + make_float2 (rt_0.x * _S261 - rt_0.y * _S260, rt_0.x * _S260 + rt_0.y * _S261) / make_float2 (radius_0) * make_float2 ((*coeffs_6)[int(6)], (*coeffs_6)[int(7)]);
}

inline __device__ DiffPair_float_0 s_fwd_DistKBPolarSpline_cubic_0(DiffPair_float_0 * dpa_0, DiffPair_float_0 * dpb_0, DiffPair_float_0 * dpc_0, DiffPair_float_0 * dpd_0, DiffPair_float_0 * dpt_0)
{
    float _S279 = 0.5f * dpt_0->primal_0;
    float _S280 = 3.0f * (dpb_0->primal_0 - dpc_0->primal_0) + dpd_0->primal_0 - dpa_0->primal_0;
    float _S281 = 2.0f * dpa_0->primal_0 - 5.0f * dpb_0->primal_0 + 4.0f * dpc_0->primal_0 - dpd_0->primal_0 + dpt_0->primal_0 * _S280;
    float _S282 = dpc_0->primal_0 - dpa_0->primal_0 + dpt_0->primal_0 * _S281;
    DiffPair_float_0 _S283 = { dpb_0->primal_0 + _S279 * _S282, dpb_0->differential_0 + (dpt_0->differential_0 * 0.5f * _S282 + (dpc_0->differential_0 - dpa_0->differential_0 + (dpt_0->differential_0 * _S281 + (dpa_0->differential_0 * 2.0f - dpb_0->differential_0 * 5.0f + dpc_0->differential_0 * 4.0f - dpd_0->differential_0 + (dpt_0->differential_0 * _S280 + ((dpb_0->differential_0 - dpc_0->differential_0) * 3.0f + dpd_0->differential_0 - dpa_0->differential_0) * dpt_0->primal_0)) * dpt_0->primal_0)) * _S279) };
    return _S283;
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistKBPolarSpline_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_3, FixedArray<float, 58>  * coeffs_7)
{
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S284;
    (&_S284)->primal_0 = dpuv_3->primal_0;
    (&_S284)->differential_0 = dpuv_3->differential_0;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S285;
    (&_S285)->primal_0 = dpuv_3->primal_0;
    (&_S285)->differential_0 = dpuv_3->differential_0;
    DiffPair_float_0 _S286 = _d_dot_1(&_S284, &_S285);
    float _S287 = (*coeffs_7)[int(2)] + _S286.primal_0 * (*coeffs_7)[int(3)];
    float _S288 = (*coeffs_7)[int(1)] + _S286.primal_0 * _S287;
    float _S289 = (*coeffs_7)[int(0)] + _S286.primal_0 * _S288;
    float radial_2 = 1.0f + _S286.primal_0 * _S289;
    float2  kb_1 = dpuv_3->primal_0 * make_float2 (radial_2);
    float2  s_diff_kb_0 = dpuv_3->differential_0 * make_float2 (radial_2) + make_float2 (_S286.differential_0 * _S289 + (_S286.differential_0 * _S288 + (_S286.differential_0 * _S287 + _S286.differential_0 * (*coeffs_7)[int(3)] * _S286.primal_0) * _S286.primal_0) * _S286.primal_0) * dpuv_3->primal_0;
    float2  _S290 = make_float2 ((*coeffs_7)[int(4)], (*coeffs_7)[int(5)]);
    float2  grid_1 = kb_1 * _S290;
    float2  _S291 = s_diff_kb_0 * _S290;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S292;
    (&_S292)->primal_0 = grid_1;
    (&_S292)->differential_0 = _S291;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S293;
    (&_S293)->primal_0 = grid_1;
    (&_S293)->differential_0 = _S291;
    DiffPair_float_0 _S294 = _d_dot_1(&_S292, &_S293);
    if((_S294.primal_0) < 9.99999968265522539e-21f)
    {
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S295 = { kb_1, s_diff_kb_0 };
        return _S295;
    }
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S296;
    (&_S296)->primal_0 = grid_1;
    (&_S296)->differential_0 = _S291;
    DiffPair_float_0 _S297 = s_fwd_length_impl_0(&_S296);
    float _S298 = grid_1.y;
    float _S299 = _S291.y;
    float _S300 = grid_1.x;
    float _S301 = _S291.x;
    DiffPair_float_0 _S302;
    (&_S302)->primal_0 = _S298;
    (&_S302)->differential_0 = _S299;
    DiffPair_float_0 _S303;
    (&_S303)->primal_0 = _S300;
    (&_S303)->differential_0 = _S301;
    DiffPair_float_0 _S304 = _d_atan2_0(&_S302, &_S303);
    float theta_6 = _S304.primal_0 * 0.79577469825744629f;
    float _S305 = _S304.differential_0 * 0.79577469825744629f;
    float theta_7;
    if(theta_6 < 0.0f)
    {
        theta_7 = theta_6 + 5.0f;
    }
    else
    {
        theta_7 = theta_6;
    }
    int _S306 = int((F32_floor((_S297.primal_0))));
    int _S307 = int((F32_floor((theta_7))));
    int2  _S308 = make_int2 (int(0));
    float2  rt_1 = make_float2 ((float)_S308.x, (float)_S308.y);
    int _S309 = clamp_0(_S306 - int(1), int(0), int(6));
    int col_4 = ((_S307 - int(1)) % int(5) + int(5)) % int(5);
    bool _S310 = _S309 < int(2);
    int _S311 = (_S309 - int(2)) * int(5);
    int _S312 = int(8) + _S311;
    float _S313 = (*coeffs_7)[_S312 + col_4];
    int col_5 = ((_S307 + int(1) - int(1)) % int(5) + int(5)) % int(5);
    float _S314 = (*coeffs_7)[_S312 + col_5];
    int col_6 = ((_S307 + int(2) - int(1)) % int(5) + int(5)) % int(5);
    float _S315 = (*coeffs_7)[_S312 + col_6];
    int col_7 = ((_S307 + int(3) - int(1)) % int(5) + int(5)) % int(5);
    float _S316 = (*coeffs_7)[_S312 + col_7];
    float _S317 = theta_7 - float(_S307);
    int _S318 = clamp_0(_S306 + int(1) - int(1), int(0), int(6));
    bool _S319 = _S318 < int(2);
    int _S320 = (_S318 - int(2)) * int(5);
    int _S321 = int(8) + _S320;
    float _S322 = (*coeffs_7)[_S321 + col_4];
    float _S323 = (*coeffs_7)[_S321 + col_5];
    float _S324 = (*coeffs_7)[_S321 + col_6];
    float _S325 = (*coeffs_7)[_S321 + col_7];
    int _S326 = clamp_0(_S306 + int(2) - int(1), int(0), int(6));
    bool _S327 = _S326 < int(2);
    int _S328 = (_S326 - int(2)) * int(5);
    int _S329 = int(8) + _S328;
    float _S330 = (*coeffs_7)[_S329 + col_4];
    float _S331 = (*coeffs_7)[_S329 + col_5];
    float _S332 = (*coeffs_7)[_S329 + col_6];
    float _S333 = (*coeffs_7)[_S329 + col_7];
    int _S334 = clamp_0(_S306 + int(3) - int(1), int(0), int(6));
    bool _S335 = _S334 < int(2);
    int _S336 = (_S334 - int(2)) * int(5);
    int _S337 = int(8) + _S336;
    float _S338 = (*coeffs_7)[_S337 + col_4];
    float _S339 = (*coeffs_7)[_S337 + col_5];
    float _S340 = (*coeffs_7)[_S337 + col_6];
    float _S341 = (*coeffs_7)[_S337 + col_7];
    float _S342 = _S297.primal_0 - float(_S306);
    int _S343 = int(33) + _S311;
    float _S344 = (*coeffs_7)[_S343 + col_4];
    float _S345 = (*coeffs_7)[_S343 + col_5];
    float _S346 = (*coeffs_7)[_S343 + col_6];
    float _S347 = (*coeffs_7)[_S343 + col_7];
    int _S348 = int(33) + _S320;
    float _S349 = (*coeffs_7)[_S348 + col_4];
    float _S350 = (*coeffs_7)[_S348 + col_5];
    float _S351 = (*coeffs_7)[_S348 + col_6];
    float _S352 = (*coeffs_7)[_S348 + col_7];
    int _S353 = int(33) + _S328;
    float _S354 = (*coeffs_7)[_S353 + col_4];
    float _S355 = (*coeffs_7)[_S353 + col_5];
    float _S356 = (*coeffs_7)[_S353 + col_6];
    float _S357 = (*coeffs_7)[_S353 + col_7];
    int _S358 = int(33) + _S336;
    float _S359 = (*coeffs_7)[_S358 + col_4];
    float _S360 = (*coeffs_7)[_S358 + col_5];
    float _S361 = (*coeffs_7)[_S358 + col_6];
    float _S362 = (*coeffs_7)[_S358 + col_7];
    float2  _S363 = make_float2 ((*coeffs_7)[int(6)], (*coeffs_7)[int(7)]);
    if(_S310)
    {
        theta_7 = 0.0f;
    }
    else
    {
        theta_7 = _S313;
    }
    float _S364;
    if(_S310)
    {
        _S364 = 0.0f;
    }
    else
    {
        _S364 = _S314;
    }
    float _S365;
    if(_S310)
    {
        _S365 = 0.0f;
    }
    else
    {
        _S365 = _S315;
    }
    float _S366;
    if(_S310)
    {
        _S366 = 0.0f;
    }
    else
    {
        _S366 = _S316;
    }
    DiffPair_float_0 _S367;
    (&_S367)->primal_0 = theta_7;
    (&_S367)->differential_0 = 0.0f;
    DiffPair_float_0 _S368;
    (&_S368)->primal_0 = _S364;
    (&_S368)->differential_0 = 0.0f;
    DiffPair_float_0 _S369;
    (&_S369)->primal_0 = _S365;
    (&_S369)->differential_0 = 0.0f;
    DiffPair_float_0 _S370;
    (&_S370)->primal_0 = _S366;
    (&_S370)->differential_0 = 0.0f;
    DiffPair_float_0 _S371;
    (&_S371)->primal_0 = _S317;
    (&_S371)->differential_0 = _S305;
    DiffPair_float_0 _S372 = s_fwd_DistKBPolarSpline_cubic_0(&_S367, &_S368, &_S369, &_S370, &_S371);
    if(_S319)
    {
        theta_7 = 0.0f;
    }
    else
    {
        theta_7 = _S322;
    }
    if(_S319)
    {
        _S364 = 0.0f;
    }
    else
    {
        _S364 = _S323;
    }
    if(_S319)
    {
        _S365 = 0.0f;
    }
    else
    {
        _S365 = _S324;
    }
    if(_S319)
    {
        _S366 = 0.0f;
    }
    else
    {
        _S366 = _S325;
    }
    DiffPair_float_0 _S373;
    (&_S373)->primal_0 = theta_7;
    (&_S373)->differential_0 = 0.0f;
    DiffPair_float_0 _S374;
    (&_S374)->primal_0 = _S364;
    (&_S374)->differential_0 = 0.0f;
    DiffPair_float_0 _S375;
    (&_S375)->primal_0 = _S365;
    (&_S375)->differential_0 = 0.0f;
    DiffPair_float_0 _S376;
    (&_S376)->primal_0 = _S366;
    (&_S376)->differential_0 = 0.0f;
    DiffPair_float_0 _S377;
    (&_S377)->primal_0 = _S317;
    (&_S377)->differential_0 = _S305;
    DiffPair_float_0 _S378 = s_fwd_DistKBPolarSpline_cubic_0(&_S373, &_S374, &_S375, &_S376, &_S377);
    if(_S327)
    {
        theta_7 = 0.0f;
    }
    else
    {
        theta_7 = _S330;
    }
    if(_S327)
    {
        _S364 = 0.0f;
    }
    else
    {
        _S364 = _S331;
    }
    if(_S327)
    {
        _S365 = 0.0f;
    }
    else
    {
        _S365 = _S332;
    }
    if(_S327)
    {
        _S366 = 0.0f;
    }
    else
    {
        _S366 = _S333;
    }
    DiffPair_float_0 _S379;
    (&_S379)->primal_0 = theta_7;
    (&_S379)->differential_0 = 0.0f;
    DiffPair_float_0 _S380;
    (&_S380)->primal_0 = _S364;
    (&_S380)->differential_0 = 0.0f;
    DiffPair_float_0 _S381;
    (&_S381)->primal_0 = _S365;
    (&_S381)->differential_0 = 0.0f;
    DiffPair_float_0 _S382;
    (&_S382)->primal_0 = _S366;
    (&_S382)->differential_0 = 0.0f;
    DiffPair_float_0 _S383;
    (&_S383)->primal_0 = _S317;
    (&_S383)->differential_0 = _S305;
    DiffPair_float_0 _S384 = s_fwd_DistKBPolarSpline_cubic_0(&_S379, &_S380, &_S381, &_S382, &_S383);
    if(_S335)
    {
        theta_7 = 0.0f;
    }
    else
    {
        theta_7 = _S338;
    }
    if(_S335)
    {
        _S364 = 0.0f;
    }
    else
    {
        _S364 = _S339;
    }
    if(_S335)
    {
        _S365 = 0.0f;
    }
    else
    {
        _S365 = _S340;
    }
    if(_S335)
    {
        _S366 = 0.0f;
    }
    else
    {
        _S366 = _S341;
    }
    DiffPair_float_0 _S385;
    (&_S385)->primal_0 = theta_7;
    (&_S385)->differential_0 = 0.0f;
    DiffPair_float_0 _S386;
    (&_S386)->primal_0 = _S364;
    (&_S386)->differential_0 = 0.0f;
    DiffPair_float_0 _S387;
    (&_S387)->primal_0 = _S365;
    (&_S387)->differential_0 = 0.0f;
    DiffPair_float_0 _S388;
    (&_S388)->primal_0 = _S366;
    (&_S388)->differential_0 = 0.0f;
    DiffPair_float_0 _S389;
    (&_S389)->primal_0 = _S317;
    (&_S389)->differential_0 = _S305;
    DiffPair_float_0 _S390 = s_fwd_DistKBPolarSpline_cubic_0(&_S385, &_S386, &_S387, &_S388, &_S389);
    DiffPair_float_0 _S391;
    (&_S391)->primal_0 = _S372.primal_0;
    (&_S391)->differential_0 = _S372.differential_0;
    DiffPair_float_0 _S392;
    (&_S392)->primal_0 = _S378.primal_0;
    (&_S392)->differential_0 = _S378.differential_0;
    DiffPair_float_0 _S393;
    (&_S393)->primal_0 = _S384.primal_0;
    (&_S393)->differential_0 = _S384.differential_0;
    DiffPair_float_0 _S394;
    (&_S394)->primal_0 = _S390.primal_0;
    (&_S394)->differential_0 = _S390.differential_0;
    DiffPair_float_0 _S395;
    (&_S395)->primal_0 = _S342;
    (&_S395)->differential_0 = _S297.differential_0;
    DiffPair_float_0 _S396 = s_fwd_DistKBPolarSpline_cubic_0(&_S391, &_S392, &_S393, &_S394, &_S395);
    float2  _S397 = rt_1;
    *&((&_S397)->x) = _S396.primal_0;
    float2  _S398 = make_float2 (0.0f);
    *&((&_S398)->x) = _S396.differential_0;
    if(_S310)
    {
        theta_7 = 0.0f;
    }
    else
    {
        theta_7 = _S344;
    }
    if(_S310)
    {
        _S364 = 0.0f;
    }
    else
    {
        _S364 = _S345;
    }
    if(_S310)
    {
        _S365 = 0.0f;
    }
    else
    {
        _S365 = _S346;
    }
    if(_S310)
    {
        _S366 = 0.0f;
    }
    else
    {
        _S366 = _S347;
    }
    DiffPair_float_0 _S399;
    (&_S399)->primal_0 = theta_7;
    (&_S399)->differential_0 = 0.0f;
    DiffPair_float_0 _S400;
    (&_S400)->primal_0 = _S364;
    (&_S400)->differential_0 = 0.0f;
    DiffPair_float_0 _S401;
    (&_S401)->primal_0 = _S365;
    (&_S401)->differential_0 = 0.0f;
    DiffPair_float_0 _S402;
    (&_S402)->primal_0 = _S366;
    (&_S402)->differential_0 = 0.0f;
    DiffPair_float_0 _S403;
    (&_S403)->primal_0 = _S317;
    (&_S403)->differential_0 = _S305;
    DiffPair_float_0 _S404 = s_fwd_DistKBPolarSpline_cubic_0(&_S399, &_S400, &_S401, &_S402, &_S403);
    if(_S319)
    {
        theta_7 = 0.0f;
    }
    else
    {
        theta_7 = _S349;
    }
    if(_S319)
    {
        _S364 = 0.0f;
    }
    else
    {
        _S364 = _S350;
    }
    if(_S319)
    {
        _S365 = 0.0f;
    }
    else
    {
        _S365 = _S351;
    }
    if(_S319)
    {
        _S366 = 0.0f;
    }
    else
    {
        _S366 = _S352;
    }
    DiffPair_float_0 _S405;
    (&_S405)->primal_0 = theta_7;
    (&_S405)->differential_0 = 0.0f;
    DiffPair_float_0 _S406;
    (&_S406)->primal_0 = _S364;
    (&_S406)->differential_0 = 0.0f;
    DiffPair_float_0 _S407;
    (&_S407)->primal_0 = _S365;
    (&_S407)->differential_0 = 0.0f;
    DiffPair_float_0 _S408;
    (&_S408)->primal_0 = _S366;
    (&_S408)->differential_0 = 0.0f;
    DiffPair_float_0 _S409;
    (&_S409)->primal_0 = _S317;
    (&_S409)->differential_0 = _S305;
    DiffPair_float_0 _S410 = s_fwd_DistKBPolarSpline_cubic_0(&_S405, &_S406, &_S407, &_S408, &_S409);
    if(_S327)
    {
        theta_7 = 0.0f;
    }
    else
    {
        theta_7 = _S354;
    }
    if(_S327)
    {
        _S364 = 0.0f;
    }
    else
    {
        _S364 = _S355;
    }
    if(_S327)
    {
        _S365 = 0.0f;
    }
    else
    {
        _S365 = _S356;
    }
    if(_S327)
    {
        _S366 = 0.0f;
    }
    else
    {
        _S366 = _S357;
    }
    DiffPair_float_0 _S411;
    (&_S411)->primal_0 = theta_7;
    (&_S411)->differential_0 = 0.0f;
    DiffPair_float_0 _S412;
    (&_S412)->primal_0 = _S364;
    (&_S412)->differential_0 = 0.0f;
    DiffPair_float_0 _S413;
    (&_S413)->primal_0 = _S365;
    (&_S413)->differential_0 = 0.0f;
    DiffPair_float_0 _S414;
    (&_S414)->primal_0 = _S366;
    (&_S414)->differential_0 = 0.0f;
    DiffPair_float_0 _S415;
    (&_S415)->primal_0 = _S317;
    (&_S415)->differential_0 = _S305;
    DiffPair_float_0 _S416 = s_fwd_DistKBPolarSpline_cubic_0(&_S411, &_S412, &_S413, &_S414, &_S415);
    if(_S335)
    {
        theta_7 = 0.0f;
    }
    else
    {
        theta_7 = _S359;
    }
    if(_S335)
    {
        _S364 = 0.0f;
    }
    else
    {
        _S364 = _S360;
    }
    if(_S335)
    {
        _S365 = 0.0f;
    }
    else
    {
        _S365 = _S361;
    }
    if(_S335)
    {
        _S366 = 0.0f;
    }
    else
    {
        _S366 = _S362;
    }
    DiffPair_float_0 _S417;
    (&_S417)->primal_0 = theta_7;
    (&_S417)->differential_0 = 0.0f;
    DiffPair_float_0 _S418;
    (&_S418)->primal_0 = _S364;
    (&_S418)->differential_0 = 0.0f;
    DiffPair_float_0 _S419;
    (&_S419)->primal_0 = _S365;
    (&_S419)->differential_0 = 0.0f;
    DiffPair_float_0 _S420;
    (&_S420)->primal_0 = _S366;
    (&_S420)->differential_0 = 0.0f;
    DiffPair_float_0 _S421;
    (&_S421)->primal_0 = _S317;
    (&_S421)->differential_0 = _S305;
    DiffPair_float_0 _S422 = s_fwd_DistKBPolarSpline_cubic_0(&_S417, &_S418, &_S419, &_S420, &_S421);
    DiffPair_float_0 _S423;
    (&_S423)->primal_0 = _S404.primal_0;
    (&_S423)->differential_0 = _S404.differential_0;
    DiffPair_float_0 _S424;
    (&_S424)->primal_0 = _S410.primal_0;
    (&_S424)->differential_0 = _S410.differential_0;
    DiffPair_float_0 _S425;
    (&_S425)->primal_0 = _S416.primal_0;
    (&_S425)->differential_0 = _S416.differential_0;
    DiffPair_float_0 _S426;
    (&_S426)->primal_0 = _S422.primal_0;
    (&_S426)->differential_0 = _S422.differential_0;
    DiffPair_float_0 _S427;
    (&_S427)->primal_0 = _S342;
    (&_S427)->differential_0 = _S297.differential_0;
    DiffPair_float_0 _S428 = s_fwd_DistKBPolarSpline_cubic_0(&_S423, &_S424, &_S425, &_S426, &_S427);
    *&((&_S397)->y) = _S428.primal_0;
    *&((&_S398)->y) = _S428.differential_0;
    float _S429 = _S397.x;
    float _S430 = _S398.x;
    float _S431 = _S397.y;
    float _S432 = _S398.y;
    float2  _S433 = make_float2 (_S429 * _S300 - _S431 * _S298, _S429 * _S298 + _S431 * _S300);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S434 = { kb_1 + _S433 / make_float2 (_S297.primal_0) * _S363, s_diff_kb_0 + (make_float2 (_S430 * _S300 + _S301 * _S429 - (_S432 * _S298 + _S299 * _S431), _S430 * _S298 + _S299 * _S429 + (_S432 * _S300 + _S301 * _S431)) * make_float2 (_S297.primal_0) - _S433 * make_float2 (_S297.differential_0)) / make_float2 (_S297.primal_0 * _S297.primal_0) * _S363 };
    return _S434;
}

inline __device__ bool undistort_point_3(float2  uv_14, FixedArray<float, 58>  * dist_coeffs_11, int maxiter_3, float2  * uv_undist_3)
{
    int i_6 = int(0);
    float2  q_4 = uv_14;
    for(;;)
    {
        if(i_6 < maxiter_3)
        {
        }
        else
        {
            break;
        }
        float2  _S435 = DistKBPolarSpline_distort_0(q_4, dist_coeffs_11);
        float2  r_9 = _S435 - uv_14;
        float2  _S436 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S437;
        (&_S437)->primal_0 = q_4;
        (&_S437)->differential_0 = _S436;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S438 = s_fwd_DistKBPolarSpline_distort_0(&_S437, dist_coeffs_11);
        float2  _S439 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S440;
        (&_S440)->primal_0 = q_4;
        (&_S440)->differential_0 = _S439;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S441 = s_fwd_DistKBPolarSpline_distort_0(&_S440, dist_coeffs_11);
        Matrix<float, 2, 2>  _S442 = transpose_1(makeMatrix<float, 2, 2> (_S438.differential_0, _S441.differential_0));
        float inv_det_2 = 1.0f / (_S442.rows[int(0)].x * _S442.rows[int(1)].y - _S442.rows[int(0)].y * _S442.rows[int(1)].x);
        float _S443 = r_9.x;
        float _S444 = r_9.y;
        float2  q_5 = q_4 - make_float2 ((_S443 * _S442.rows[int(1)].y - _S444 * _S442.rows[int(0)].y) * inv_det_2, (- _S443 * _S442.rows[int(1)].x + _S444 * _S442.rows[int(0)].x) * inv_det_2);
        i_6 = i_6 + int(1);
        q_4 = q_5;
    }
    *uv_undist_3 = q_4;
    float2  _S445 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S446;
    (&_S446)->primal_0 = q_4;
    (&_S446)->differential_0 = _S445;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S447 = s_fwd_DistKBPolarSpline_distort_0(&_S446, dist_coeffs_11);
    float2  _S448 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S449;
    (&_S449)->primal_0 = q_4;
    (&_S449)->differential_0 = _S448;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S450 = s_fwd_DistKBPolarSpline_distort_0(&_S449, dist_coeffs_11);
    Matrix<float, 2, 2>  _S451 = transpose_1(makeMatrix<float, 2, 2> (_S447.differential_0, _S450.differential_0));
    float _S452 = (F32_min((determinant_0(_S451)), ((F32_min((_S451.rows[int(0)].x), (_S451.rows[int(1)].y))))));
    bool _S453;
    if(_S452 > 0.25f)
    {
        _S453 = _S452 < 4.0f;
    }
    else
    {
        _S453 = false;
    }
    if(_S453)
    {
        float2  _S454 = DistKBPolarSpline_distort_0(q_4, dist_coeffs_11);
        _S453 = (dot_0(q_4, _S454)) >= 0.0f;
    }
    else
    {
        _S453 = false;
    }
    if(_S453)
    {
        float2  _S455 = DistKBPolarSpline_distort_0(*uv_undist_3, dist_coeffs_11);
        _S453 = (length_0(_S455 - uv_14)) < 0.00999999977648258f;
    }
    else
    {
        _S453 = false;
    }
    return _S453;
}

inline __device__ bool undistort_point_none(float2  uv_15, int camera_model_1, FixedArray<float, 1>  dist_coeffs_12, float2  * uv_undist_4)
{
    bool _S456;
    for(;;)
    {
        *uv_undist_4 = make_float2 (0.0f);
        if(camera_model_1 == int(3))
        {
            float lon_0 = uv_15.x;
            float lat_0 = uv_15.y;
            float cl_0 = (F32_cos((lat_0)));
            *uv_undist_4 = make_float2 (cl_0 * (F32_sin((lon_0))), (F32_sin((lat_0)))) / make_float2 ((F32_max((cl_0 * (F32_cos((lon_0)))), (9.999999960041972e-13f))));
            _S456 = true;
            break;
        }
        FixedArray<float, 1>  _S457 = dist_coeffs_12;
        float2  uv_u_0;
        bool _S458 = undistort_point_0(uv_15, &_S457, int(8), &uv_u_0);
        if(!_S458)
        {
            _S456 = false;
            break;
        }
        float2  _S459 = uv_u_0;
        float3  raydir_0;
        if(camera_model_1 == int(1))
        {
            float r_10 = length_0(_S459);
            float s_0;
            if(r_10 < 0.00100000004749745f)
            {
                s_0 = 1.0f - r_10 * r_10 / 6.0f;
            }
            else
            {
                s_0 = (F32_sin((r_10))) / r_10;
            }
            raydir_0 = make_float3 ((_S459 * make_float2 (s_0)).x, (_S459 * make_float2 (s_0)).y, (F32_cos((r_10))));
        }
        else
        {
            if(camera_model_1 == int(2))
            {
                float r_11 = length_0(_S459);
                raydir_0 = make_float3 ((_S459 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_11 * r_11)))))))).x, (_S459 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_11 * r_11)))))))).y, 1.0f - 0.5f * r_11 * r_11);
            }
            else
            {
                raydir_0 = make_float3 (_S459.x, _S459.y, 1.0f);
            }
        }
        *uv_undist_4 = float2 {raydir_0.x, raydir_0.y} / make_float2 ((F32_max((raydir_0.z), (9.999999960041972e-13f))));
        _S456 = true;
        break;
    }
    return _S456;
}

inline __device__ bool unproject_point_none(float2  uv_16, int camera_model_2, FixedArray<float, 1>  dist_coeffs_13, float3  * raydir_1)
{
    bool _S460;
    for(;;)
    {
        int3  _S461 = make_int3 (int(0));
        float3  _S462 = make_float3 ((float)_S461.x, (float)_S461.y, (float)_S461.z);
        *raydir_1 = _S462;
        if(camera_model_2 == int(3))
        {
            float lon_1 = uv_16.x;
            float lat_1 = uv_16.y;
            float cl_1 = (F32_cos((lat_1)));
            *raydir_1 = make_float3 (cl_1 * (F32_sin((lon_1))), (F32_sin((lat_1))), cl_1 * (F32_cos((lon_1))));
            _S460 = true;
            break;
        }
        FixedArray<float, 1>  _S463 = dist_coeffs_13;
        float2  uv_u_1;
        bool _S464 = undistort_point_0(uv_16, &_S463, int(8), &uv_u_1);
        if(!_S464)
        {
            _S460 = false;
            break;
        }
        float2  _S465 = uv_u_1;
        if(camera_model_2 == int(1))
        {
            float r_12 = length_0(_S465);
            float s_1;
            if(r_12 < 0.00100000004749745f)
            {
                s_1 = 1.0f - r_12 * r_12 / 6.0f;
            }
            else
            {
                s_1 = (F32_sin((r_12))) / r_12;
            }
            *raydir_1 = make_float3 ((_S465 * make_float2 (s_1)).x, (_S465 * make_float2 (s_1)).y, (F32_cos((r_12))));
        }
        else
        {
            if(camera_model_2 == int(2))
            {
                float r_13 = length_0(_S465);
                *raydir_1 = make_float3 ((_S465 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_13 * r_13)))))))).x, (_S465 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_13 * r_13)))))))).y, 1.0f - 0.5f * r_13 * r_13);
            }
            else
            {
                *raydir_1 = make_float3 (_S465.x, _S465.y, 1.0f);
            }
        }
        _S460 = true;
        break;
    }
    return _S460;
}

inline __device__ float3  normalize_0(float3  x_12)
{
    return x_12 / make_float3 (length_1(x_12));
}

inline __device__ bool generate_ray_none(float2  uv_17, int camera_model_3, FixedArray<float, 1>  dist_coeffs_14, float3  * raydir_2)
{
    bool _S466;
    for(;;)
    {
        if(camera_model_3 == int(3))
        {
            float _S467 = uv_17.x;
            if((F32_abs((_S467))) > 3.14159274101257324f)
            {
                _S466 = true;
            }
            else
            {
                _S466 = (F32_abs((uv_17.y))) > 1.57079637050628662f;
            }
            if(_S466)
            {
                int3  _S468 = make_int3 (int(0));
                float3  _S469 = make_float3 ((float)_S468.x, (float)_S468.y, (float)_S468.z);
                *raydir_2 = _S469;
                _S466 = false;
                break;
            }
            float lat_2 = uv_17.y;
            float cl_2 = (F32_cos((lat_2)));
            *raydir_2 = make_float3 (cl_2 * (F32_sin((_S467))), (F32_sin((lat_2))), cl_2 * (F32_cos((_S467))));
            _S466 = true;
            break;
        }
        FixedArray<float, 1>  _S470 = dist_coeffs_14;
        float2  uv_u_2;
        bool _S471 = undistort_point_0(uv_17, &_S470, int(8), &uv_u_2);
        if(!_S471)
        {
            int3  _S472 = make_int3 (int(0));
            float3  _S473 = make_float3 ((float)_S472.x, (float)_S472.y, (float)_S472.z);
            *raydir_2 = _S473;
            _S466 = false;
            break;
        }
        float2  _S474 = uv_u_2;
        if(camera_model_3 == int(1))
        {
            float r_14 = length_0(_S474);
            if(r_14 >= 3.14159274101257324f)
            {
                int3  _S475 = make_int3 (int(0));
                float3  _S476 = make_float3 ((float)_S475.x, (float)_S475.y, (float)_S475.z);
                *raydir_2 = _S476;
                _S466 = false;
                break;
            }
            float s_2;
            if(r_14 < 0.00100000004749745f)
            {
                s_2 = 1.0f - r_14 * r_14 / 6.0f;
            }
            else
            {
                s_2 = (F32_sin((r_14))) / r_14;
            }
            *raydir_2 = make_float3 ((_S474 * make_float2 (s_2)).x, (_S474 * make_float2 (s_2)).y, (F32_cos((r_14))));
        }
        else
        {
            if(camera_model_3 == int(2))
            {
                float r_15 = length_0(_S474);
                if(r_15 >= 2.0f)
                {
                    int3  _S477 = make_int3 (int(0));
                    float3  _S478 = make_float3 ((float)_S477.x, (float)_S477.y, (float)_S477.z);
                    *raydir_2 = _S478;
                    _S466 = false;
                    break;
                }
                *raydir_2 = make_float3 ((_S474 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_15 * r_15)))))))).x, (_S474 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_15 * r_15)))))))).y, 1.0f - 0.5f * r_15 * r_15);
            }
            else
            {
                *raydir_2 = make_float3 (_S474.x, _S474.y, 1.0f);
            }
        }
        *raydir_2 = normalize_0(*raydir_2);
        _S466 = true;
        break;
    }
    return _S466;
}

inline __device__ bool is_valid_distortion_opencv(float2  uv_18, FixedArray<float, 4>  dist_coeffs_15)
{
    float2  _S479 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S480;
    (&_S480)->primal_0 = uv_18;
    (&_S480)->differential_0 = _S479;
    FixedArray<float, 4>  _S481 = dist_coeffs_15;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S482 = s_fwd_DistOpenCV_distort_0(&_S480, &_S481);
    float2  _S483 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S484;
    (&_S484)->primal_0 = uv_18;
    (&_S484)->differential_0 = _S483;
    FixedArray<float, 4>  _S485 = dist_coeffs_15;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S486 = s_fwd_DistOpenCV_distort_0(&_S484, &_S485);
    Matrix<float, 2, 2>  _S487 = transpose_1(makeMatrix<float, 2, 2> (_S482.differential_0, _S486.differential_0));
    float _S488 = (F32_min((determinant_0(_S487)), ((F32_min((_S487.rows[int(0)].x), (_S487.rows[int(1)].y))))));
    bool _S489;
    if(_S488 > 0.25f)
    {
        _S489 = _S488 < 4.0f;
    }
    else
    {
        _S489 = false;
    }
    if(_S489)
    {
        FixedArray<float, 4>  _S490 = dist_coeffs_15;
        float2  _S491 = DistOpenCV_distort_0(uv_18, &_S490);
        _S489 = (dot_0(uv_18, _S491)) >= 0.0f;
    }
    else
    {
        _S489 = false;
    }
    return _S489;
}

inline __device__ bool persp_proj_nav_opencv(float3  p_view_8, float4  intrins_8, FixedArray<float, 4>  dist_coeffs_16, float2  * uv_19)
{
    bool _S492;
    for(;;)
    {
        float2  _S493 = float2 {p_view_8.x, p_view_8.y};
        float _S494 = p_view_8.z;
        float2  uv0_1 = _S493 / make_float2 (_S494);
        if(_S494 < 0.0f)
        {
            _S492 = true;
        }
        else
        {
            float2  _S495 = make_float2 (1.0f, 0.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S496;
            (&_S496)->primal_0 = uv0_1;
            (&_S496)->differential_0 = _S495;
            FixedArray<float, 4>  _S497 = dist_coeffs_16;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S498 = s_fwd_DistOpenCV_distort_0(&_S496, &_S497);
            float2  _S499 = make_float2 (0.0f, 1.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S500;
            (&_S500)->primal_0 = uv0_1;
            (&_S500)->differential_0 = _S499;
            FixedArray<float, 4>  _S501 = dist_coeffs_16;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S502 = s_fwd_DistOpenCV_distort_0(&_S500, &_S501);
            Matrix<float, 2, 2>  _S503 = transpose_1(makeMatrix<float, 2, 2> (_S498.differential_0, _S502.differential_0));
            float _S504 = (F32_min((determinant_0(_S503)), ((F32_min((_S503.rows[int(0)].x), (_S503.rows[int(1)].y))))));
            if(_S504 > 0.25f)
            {
                _S492 = _S504 < 4.0f;
            }
            else
            {
                _S492 = false;
            }
            if(_S492)
            {
                FixedArray<float, 4>  _S505 = dist_coeffs_16;
                float2  _S506 = DistOpenCV_distort_0(uv0_1, &_S505);
                _S492 = (dot_0(uv0_1, _S506)) >= 0.0f;
            }
            else
            {
                _S492 = false;
            }
            _S492 = !_S492;
        }
        if(_S492)
        {
            *uv_19 = uv0_1;
            _S492 = false;
            break;
        }
        float2  uv_20 = _S493 / make_float2 (_S494);
        FixedArray<float, 4>  _S507 = dist_coeffs_16;
        float2  _S508 = DistOpenCV_distort_0(uv_20, &_S507);
        *uv_19 = make_float2 (intrins_8.x * _S508.x + intrins_8.z, intrins_8.y * _S508.y + intrins_8.w);
        _S492 = true;
        break;
    }
    return _S492;
}

inline __device__ bool fisheye_proj_nav_opencv(float3  p_view_9, float4  intrins_9, FixedArray<float, 4>  dist_coeffs_17, float2  * uv_21)
{
    bool _S509;
    for(;;)
    {
        float2  _S510 = float2 {p_view_9.x, p_view_9.y};
        float r_16 = length_0(_S510);
        float _S511 = p_view_9.z;
        float theta_8 = (F32_atan2((r_16), (_S511)));
        bool _S512 = theta_8 < 0.00100000004749745f;
        float k_5;
        if(_S512)
        {
            k_5 = (1.0f - theta_8 * theta_8 / 3.0f) / _S511;
        }
        else
        {
            k_5 = theta_8 / r_16;
        }
        float2  _S513 = _S510 * make_float2 (k_5);
        float2  _S514 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S515;
        (&_S515)->primal_0 = _S513;
        (&_S515)->differential_0 = _S514;
        FixedArray<float, 4>  _S516 = dist_coeffs_17;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S517 = s_fwd_DistOpenCV_distort_0(&_S515, &_S516);
        float2  _S518 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S519;
        (&_S519)->primal_0 = _S513;
        (&_S519)->differential_0 = _S518;
        FixedArray<float, 4>  _S520 = dist_coeffs_17;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S521 = s_fwd_DistOpenCV_distort_0(&_S519, &_S520);
        Matrix<float, 2, 2>  _S522 = transpose_1(makeMatrix<float, 2, 2> (_S517.differential_0, _S521.differential_0));
        float _S523 = (F32_min((determinant_0(_S522)), ((F32_min((_S522.rows[int(0)].x), (_S522.rows[int(1)].y))))));
        if(_S523 > 0.25f)
        {
            _S509 = _S523 < 4.0f;
        }
        else
        {
            _S509 = false;
        }
        if(_S509)
        {
            FixedArray<float, 4>  _S524 = dist_coeffs_17;
            float2  _S525 = DistOpenCV_distort_0(_S513, &_S524);
            _S509 = (dot_0(_S513, _S525)) >= 0.0f;
        }
        else
        {
            _S509 = false;
        }
        if(!_S509)
        {
            *uv_21 = _S513;
            _S509 = false;
            break;
        }
        if(_S512)
        {
            k_5 = (1.0f - theta_8 * theta_8 / 3.0f) / _S511;
        }
        else
        {
            k_5 = theta_8 / r_16;
        }
        float2  _S526 = _S510 * make_float2 (k_5);
        FixedArray<float, 4>  _S527 = dist_coeffs_17;
        float2  _S528 = DistOpenCV_distort_0(_S526, &_S527);
        *uv_21 = make_float2 (intrins_9.x * _S528.x + intrins_9.z, intrins_9.y * _S528.y + intrins_9.w);
        _S509 = true;
        break;
    }
    return _S509;
}

inline __device__ bool equisolid_proj_nav_opencv(float3  p_view_10, float4  intrins_10, FixedArray<float, 4>  dist_coeffs_18, float2  * uv_22)
{
    bool _S529;
    for(;;)
    {
        float2  _S530 = float2 {p_view_10.x, p_view_10.y};
        float r_17 = length_0(_S530);
        float _S531 = p_view_10.z;
        float theta_9 = (F32_atan2((r_17), (_S531)));
        bool _S532 = r_17 < 9.99999997475242708e-07f;
        float k_6;
        if(_S532)
        {
            k_6 = (1.0f - theta_9 * theta_9 / 24.0f) / _S531;
        }
        else
        {
            k_6 = 2.0f * (F32_sin((0.5f * theta_9))) / r_17;
        }
        float2  _S533 = _S530 * make_float2 (k_6);
        float2  _S534 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S535;
        (&_S535)->primal_0 = _S533;
        (&_S535)->differential_0 = _S534;
        FixedArray<float, 4>  _S536 = dist_coeffs_18;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S537 = s_fwd_DistOpenCV_distort_0(&_S535, &_S536);
        float2  _S538 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S539;
        (&_S539)->primal_0 = _S533;
        (&_S539)->differential_0 = _S538;
        FixedArray<float, 4>  _S540 = dist_coeffs_18;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S541 = s_fwd_DistOpenCV_distort_0(&_S539, &_S540);
        Matrix<float, 2, 2>  _S542 = transpose_1(makeMatrix<float, 2, 2> (_S537.differential_0, _S541.differential_0));
        float _S543 = (F32_min((determinant_0(_S542)), ((F32_min((_S542.rows[int(0)].x), (_S542.rows[int(1)].y))))));
        if(_S543 > 0.25f)
        {
            _S529 = _S543 < 4.0f;
        }
        else
        {
            _S529 = false;
        }
        if(_S529)
        {
            FixedArray<float, 4>  _S544 = dist_coeffs_18;
            float2  _S545 = DistOpenCV_distort_0(_S533, &_S544);
            _S529 = (dot_0(_S533, _S545)) >= 0.0f;
        }
        else
        {
            _S529 = false;
        }
        if(!_S529)
        {
            *uv_22 = _S533;
            _S529 = false;
            break;
        }
        if(_S532)
        {
            k_6 = (1.0f - theta_9 * theta_9 / 24.0f) / _S531;
        }
        else
        {
            k_6 = 2.0f * (F32_sin((0.5f * theta_9))) / r_17;
        }
        float2  _S546 = _S530 * make_float2 (k_6);
        FixedArray<float, 4>  _S547 = dist_coeffs_18;
        float2  _S548 = DistOpenCV_distort_0(_S546, &_S547);
        *uv_22 = make_float2 (intrins_10.x * _S548.x + intrins_10.z, intrins_10.y * _S548.y + intrins_10.w);
        _S529 = true;
        break;
    }
    return _S529;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_opencv(float3  p_view_11, float4  intrins_11, FixedArray<float, 4>  dist_coeffs_19)
{
    float2  _S549 = float2 {p_view_11.x, p_view_11.y};
    float _S550 = p_view_11.z;
    float2  _S551 = _S549 * make_float2 (0.0f);
    float _S552 = _S550 * _S550;
    float2  s_diff_uv_3 = (make_float2 (1.0f, 0.0f) * make_float2 (_S550) - _S551) / make_float2 (_S552);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S553;
    (&_S553)->primal_0 = _S549 / make_float2 (_S550);
    (&_S553)->differential_0 = s_diff_uv_3;
    FixedArray<float, 4>  _S554 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S555 = s_fwd_DistOpenCV_distort_0(&_S553, &_S554);
    float fx_4 = intrins_11.x;
    float fy_4 = intrins_11.y;
    float _S556 = _S555.differential_0.y * fy_4;
    Matrix<float, 2, 3>  J_4;
    *&(((&J_4)->rows + (int(0)))->x) = _S555.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->x) = _S556;
    float2  s_diff_uv_4 = (make_float2 (0.0f, 1.0f) * make_float2 (_S550) - _S551) / make_float2 (_S552);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S557;
    (&_S557)->primal_0 = _S549 / make_float2 (_S550);
    (&_S557)->differential_0 = s_diff_uv_4;
    FixedArray<float, 4>  _S558 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S559 = s_fwd_DistOpenCV_distort_0(&_S557, &_S558);
    float _S560 = _S559.differential_0.y * fy_4;
    *&(((&J_4)->rows + (int(0)))->y) = _S559.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->y) = _S560;
    float2  s_diff_uv_5 = (make_float2 (0.0f, 0.0f) * make_float2 (_S550) - _S549) / make_float2 (_S552);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S561;
    (&_S561)->primal_0 = _S549 / make_float2 (_S550);
    (&_S561)->differential_0 = s_diff_uv_5;
    FixedArray<float, 4>  _S562 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S563 = s_fwd_DistOpenCV_distort_0(&_S561, &_S562);
    float _S564 = _S563.differential_0.y * fy_4;
    *&(((&J_4)->rows + (int(0)))->z) = _S563.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->z) = _S564;
    return J_4;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_opencv(float3  p_view_12, float4  intrins_12, FixedArray<float, 4>  dist_coeffs_20)
{
    Matrix<float, 2, 3>  J_5;
    float2  _S565 = float2 {p_view_12.x, p_view_12.y};
    float2  _S566 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S567;
    (&_S567)->primal_0 = _S565;
    (&_S567)->differential_0 = _S566;
    DiffPair_float_0 _S568 = s_fwd_length_impl_0(&_S567);
    float _S569 = p_view_12.z;
    DiffPair_float_0 _S570;
    (&_S570)->primal_0 = _S568.primal_0;
    (&_S570)->differential_0 = _S568.differential_0;
    DiffPair_float_0 _S571;
    (&_S571)->primal_0 = _S569;
    (&_S571)->differential_0 = 0.0f;
    DiffPair_float_0 _S572 = _d_atan2_0(&_S570, &_S571);
    float k_7;
    float s_diff_k_2;
    if((_S572.primal_0) < 0.00100000004749745f)
    {
        float _S573 = _S572.differential_0 * _S572.primal_0;
        float _S574 = 1.0f - _S572.primal_0 * _S572.primal_0 / 3.0f;
        float _S575 = ((0.0f - (_S573 + _S573) * 0.3333333432674408f) * _S569 - _S574 * 0.0f) / (_S569 * _S569);
        k_7 = _S574 / _S569;
        s_diff_k_2 = _S575;
    }
    else
    {
        float _S576 = (_S572.differential_0 * _S568.primal_0 - _S572.primal_0 * _S568.differential_0) / (_S568.primal_0 * _S568.primal_0);
        k_7 = _S572.primal_0 / _S568.primal_0;
        s_diff_k_2 = _S576;
    }
    float2  _S577 = _S565 * make_float2 (k_7);
    float2  _S578 = _S566 * make_float2 (k_7) + make_float2 (s_diff_k_2) * _S565;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S579;
    (&_S579)->primal_0 = _S577;
    (&_S579)->differential_0 = _S578;
    FixedArray<float, 4>  _S580 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S581 = s_fwd_DistOpenCV_distort_0(&_S579, &_S580);
    float fx_5 = intrins_12.x;
    float fy_5 = intrins_12.y;
    float _S582 = _S581.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->x) = _S581.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->x) = _S582;
    float2  _S583 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S584;
    (&_S584)->primal_0 = _S565;
    (&_S584)->differential_0 = _S583;
    DiffPair_float_0 _S585 = s_fwd_length_impl_0(&_S584);
    DiffPair_float_0 _S586;
    (&_S586)->primal_0 = _S585.primal_0;
    (&_S586)->differential_0 = _S585.differential_0;
    DiffPair_float_0 _S587;
    (&_S587)->primal_0 = _S569;
    (&_S587)->differential_0 = 0.0f;
    DiffPair_float_0 _S588 = _d_atan2_0(&_S586, &_S587);
    if((_S588.primal_0) < 0.00100000004749745f)
    {
        float _S589 = _S588.differential_0 * _S588.primal_0;
        float _S590 = 1.0f - _S588.primal_0 * _S588.primal_0 / 3.0f;
        float _S591 = ((0.0f - (_S589 + _S589) * 0.3333333432674408f) * _S569 - _S590 * 0.0f) / (_S569 * _S569);
        k_7 = _S590 / _S569;
        s_diff_k_2 = _S591;
    }
    else
    {
        float _S592 = (_S588.differential_0 * _S585.primal_0 - _S588.primal_0 * _S585.differential_0) / (_S585.primal_0 * _S585.primal_0);
        k_7 = _S588.primal_0 / _S585.primal_0;
        s_diff_k_2 = _S592;
    }
    float2  _S593 = _S565 * make_float2 (k_7);
    float2  _S594 = _S583 * make_float2 (k_7) + make_float2 (s_diff_k_2) * _S565;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S595;
    (&_S595)->primal_0 = _S593;
    (&_S595)->differential_0 = _S594;
    FixedArray<float, 4>  _S596 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S597 = s_fwd_DistOpenCV_distort_0(&_S595, &_S596);
    float _S598 = _S597.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->y) = _S597.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->y) = _S598;
    float2  _S599 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S600;
    (&_S600)->primal_0 = _S565;
    (&_S600)->differential_0 = _S599;
    DiffPair_float_0 _S601 = s_fwd_length_impl_0(&_S600);
    DiffPair_float_0 _S602;
    (&_S602)->primal_0 = _S601.primal_0;
    (&_S602)->differential_0 = _S601.differential_0;
    DiffPair_float_0 _S603;
    (&_S603)->primal_0 = _S569;
    (&_S603)->differential_0 = 1.0f;
    DiffPair_float_0 _S604 = _d_atan2_0(&_S602, &_S603);
    if((_S604.primal_0) < 0.00100000004749745f)
    {
        float _S605 = _S604.differential_0 * _S604.primal_0;
        float _S606 = 1.0f - _S604.primal_0 * _S604.primal_0 / 3.0f;
        float _S607 = ((0.0f - (_S605 + _S605) * 0.3333333432674408f) * _S569 - _S606) / (_S569 * _S569);
        k_7 = _S606 / _S569;
        s_diff_k_2 = _S607;
    }
    else
    {
        float _S608 = (_S604.differential_0 * _S601.primal_0 - _S604.primal_0 * _S601.differential_0) / (_S601.primal_0 * _S601.primal_0);
        k_7 = _S604.primal_0 / _S601.primal_0;
        s_diff_k_2 = _S608;
    }
    float2  _S609 = _S565 * make_float2 (k_7);
    float2  _S610 = _S599 * make_float2 (k_7) + make_float2 (s_diff_k_2) * _S565;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S611;
    (&_S611)->primal_0 = _S609;
    (&_S611)->differential_0 = _S610;
    FixedArray<float, 4>  _S612 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S613 = s_fwd_DistOpenCV_distort_0(&_S611, &_S612);
    float _S614 = _S613.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->z) = _S613.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->z) = _S614;
    return J_5;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_opencv(float3  p_view_13, float4  intrins_13, FixedArray<float, 4>  dist_coeffs_21)
{
    Matrix<float, 2, 3>  J_6;
    float2  _S615 = float2 {p_view_13.x, p_view_13.y};
    float2  _S616 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S617;
    (&_S617)->primal_0 = _S615;
    (&_S617)->differential_0 = _S616;
    DiffPair_float_0 _S618 = s_fwd_length_impl_0(&_S617);
    float _S619 = p_view_13.z;
    DiffPair_float_0 _S620;
    (&_S620)->primal_0 = _S618.primal_0;
    (&_S620)->differential_0 = _S618.differential_0;
    DiffPair_float_0 _S621;
    (&_S621)->primal_0 = _S619;
    (&_S621)->differential_0 = 0.0f;
    DiffPair_float_0 _S622 = _d_atan2_0(&_S620, &_S621);
    float k_8;
    float s_diff_k_3;
    if((_S618.primal_0) < 9.99999997475242708e-07f)
    {
        float _S623 = _S622.differential_0 * _S622.primal_0;
        float _S624 = 1.0f - _S622.primal_0 * _S622.primal_0 / 24.0f;
        float _S625 = ((0.0f - (_S623 + _S623) * 0.0416666679084301f) * _S619 - _S624 * 0.0f) / (_S619 * _S619);
        k_8 = _S624 / _S619;
        s_diff_k_3 = _S625;
    }
    else
    {
        float _S626 = _S622.differential_0 * 0.5f;
        DiffPair_float_0 _S627;
        (&_S627)->primal_0 = 0.5f * _S622.primal_0;
        (&_S627)->differential_0 = _S626;
        DiffPair_float_0 _S628 = _d_sin_0(&_S627);
        float _S629 = 2.0f * _S628.primal_0;
        float _S630 = (_S628.differential_0 * 2.0f * _S618.primal_0 - _S629 * _S618.differential_0) / (_S618.primal_0 * _S618.primal_0);
        k_8 = _S629 / _S618.primal_0;
        s_diff_k_3 = _S630;
    }
    float2  _S631 = _S615 * make_float2 (k_8);
    float2  _S632 = _S616 * make_float2 (k_8) + make_float2 (s_diff_k_3) * _S615;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S633;
    (&_S633)->primal_0 = _S631;
    (&_S633)->differential_0 = _S632;
    FixedArray<float, 4>  _S634 = dist_coeffs_21;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S635 = s_fwd_DistOpenCV_distort_0(&_S633, &_S634);
    float fx_6 = intrins_13.x;
    float fy_6 = intrins_13.y;
    float _S636 = _S635.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->x) = _S635.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->x) = _S636;
    float2  _S637 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S638;
    (&_S638)->primal_0 = _S615;
    (&_S638)->differential_0 = _S637;
    DiffPair_float_0 _S639 = s_fwd_length_impl_0(&_S638);
    DiffPair_float_0 _S640;
    (&_S640)->primal_0 = _S639.primal_0;
    (&_S640)->differential_0 = _S639.differential_0;
    DiffPair_float_0 _S641;
    (&_S641)->primal_0 = _S619;
    (&_S641)->differential_0 = 0.0f;
    DiffPair_float_0 _S642 = _d_atan2_0(&_S640, &_S641);
    if((_S639.primal_0) < 9.99999997475242708e-07f)
    {
        float _S643 = _S642.differential_0 * _S642.primal_0;
        float _S644 = 1.0f - _S642.primal_0 * _S642.primal_0 / 24.0f;
        float _S645 = ((0.0f - (_S643 + _S643) * 0.0416666679084301f) * _S619 - _S644 * 0.0f) / (_S619 * _S619);
        k_8 = _S644 / _S619;
        s_diff_k_3 = _S645;
    }
    else
    {
        float _S646 = _S642.differential_0 * 0.5f;
        DiffPair_float_0 _S647;
        (&_S647)->primal_0 = 0.5f * _S642.primal_0;
        (&_S647)->differential_0 = _S646;
        DiffPair_float_0 _S648 = _d_sin_0(&_S647);
        float _S649 = 2.0f * _S648.primal_0;
        float _S650 = (_S648.differential_0 * 2.0f * _S639.primal_0 - _S649 * _S639.differential_0) / (_S639.primal_0 * _S639.primal_0);
        k_8 = _S649 / _S639.primal_0;
        s_diff_k_3 = _S650;
    }
    float2  _S651 = _S615 * make_float2 (k_8);
    float2  _S652 = _S637 * make_float2 (k_8) + make_float2 (s_diff_k_3) * _S615;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S653;
    (&_S653)->primal_0 = _S651;
    (&_S653)->differential_0 = _S652;
    FixedArray<float, 4>  _S654 = dist_coeffs_21;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S655 = s_fwd_DistOpenCV_distort_0(&_S653, &_S654);
    float _S656 = _S655.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->y) = _S655.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->y) = _S656;
    float2  _S657 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S658;
    (&_S658)->primal_0 = _S615;
    (&_S658)->differential_0 = _S657;
    DiffPair_float_0 _S659 = s_fwd_length_impl_0(&_S658);
    DiffPair_float_0 _S660;
    (&_S660)->primal_0 = _S659.primal_0;
    (&_S660)->differential_0 = _S659.differential_0;
    DiffPair_float_0 _S661;
    (&_S661)->primal_0 = _S619;
    (&_S661)->differential_0 = 1.0f;
    DiffPair_float_0 _S662 = _d_atan2_0(&_S660, &_S661);
    if((_S659.primal_0) < 9.99999997475242708e-07f)
    {
        float _S663 = _S662.differential_0 * _S662.primal_0;
        float _S664 = 1.0f - _S662.primal_0 * _S662.primal_0 / 24.0f;
        float _S665 = ((0.0f - (_S663 + _S663) * 0.0416666679084301f) * _S619 - _S664) / (_S619 * _S619);
        k_8 = _S664 / _S619;
        s_diff_k_3 = _S665;
    }
    else
    {
        float _S666 = _S662.differential_0 * 0.5f;
        DiffPair_float_0 _S667;
        (&_S667)->primal_0 = 0.5f * _S662.primal_0;
        (&_S667)->differential_0 = _S666;
        DiffPair_float_0 _S668 = _d_sin_0(&_S667);
        float _S669 = 2.0f * _S668.primal_0;
        float _S670 = (_S668.differential_0 * 2.0f * _S659.primal_0 - _S669 * _S659.differential_0) / (_S659.primal_0 * _S659.primal_0);
        k_8 = _S669 / _S659.primal_0;
        s_diff_k_3 = _S670;
    }
    float2  _S671 = _S615 * make_float2 (k_8);
    float2  _S672 = _S657 * make_float2 (k_8) + make_float2 (s_diff_k_3) * _S615;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S673;
    (&_S673)->primal_0 = _S671;
    (&_S673)->differential_0 = _S672;
    FixedArray<float, 4>  _S674 = dist_coeffs_21;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S675 = s_fwd_DistOpenCV_distort_0(&_S673, &_S674);
    float _S676 = _S675.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->z) = _S675.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->z) = _S676;
    return J_6;
}

inline __device__ float2  distort_point_opencv(float2  uv_23, int camera_model_4, FixedArray<float, 4>  dist_coeffs_22)
{
    float2  _S677;
    for(;;)
    {
        if(camera_model_4 == int(3))
        {
            _S677 = uv_23;
            break;
        }
        float k_9;
        if(camera_model_4 == int(1))
        {
            float r_18 = length_0(uv_23);
            float theta_10 = (F32_atan((r_18)));
            if(r_18 < 0.00100000004749745f)
            {
                k_9 = 1.0f - theta_10 * theta_10 / 6.0f;
            }
            else
            {
                k_9 = theta_10 / r_18;
            }
            _S677 = uv_23 * make_float2 (k_9);
        }
        else
        {
            if(camera_model_4 == int(2))
            {
                float r_19 = length_0(uv_23);
                float theta_11 = (F32_atan((r_19)));
                if(r_19 < 0.00100000004749745f)
                {
                    k_9 = 1.0f - theta_11 * theta_11 / 24.0f;
                }
                else
                {
                    k_9 = 2.0f * (F32_sin((0.5f * theta_11))) / r_19;
                }
                _S677 = uv_23 * make_float2 (k_9);
            }
            else
            {
                _S677 = uv_23;
            }
        }
        FixedArray<float, 4>  _S678 = dist_coeffs_22;
        float2  _S679 = DistOpenCV_distort_0(_S677, &_S678);
        _S677 = _S679;
        break;
    }
    return _S677;
}

inline __device__ bool undistort_point_opencv(float2  uv_24, int camera_model_5, FixedArray<float, 4>  dist_coeffs_23, float2  * uv_undist_5)
{
    bool _S680;
    for(;;)
    {
        *uv_undist_5 = make_float2 (0.0f);
        if(camera_model_5 == int(3))
        {
            float lon_2 = uv_24.x;
            float lat_3 = uv_24.y;
            float cl_3 = (F32_cos((lat_3)));
            *uv_undist_5 = make_float2 (cl_3 * (F32_sin((lon_2))), (F32_sin((lat_3)))) / make_float2 ((F32_max((cl_3 * (F32_cos((lon_2)))), (9.999999960041972e-13f))));
            _S680 = true;
            break;
        }
        FixedArray<float, 4>  _S681 = dist_coeffs_23;
        float2  uv_u_3;
        bool _S682 = undistort_point_1(uv_24, &_S681, int(8), &uv_u_3);
        if(!_S682)
        {
            _S680 = false;
            break;
        }
        float2  _S683 = uv_u_3;
        float3  raydir_3;
        if(camera_model_5 == int(1))
        {
            float r_20 = length_0(_S683);
            float s_3;
            if(r_20 < 0.00100000004749745f)
            {
                s_3 = 1.0f - r_20 * r_20 / 6.0f;
            }
            else
            {
                s_3 = (F32_sin((r_20))) / r_20;
            }
            raydir_3 = make_float3 ((_S683 * make_float2 (s_3)).x, (_S683 * make_float2 (s_3)).y, (F32_cos((r_20))));
        }
        else
        {
            if(camera_model_5 == int(2))
            {
                float r_21 = length_0(_S683);
                raydir_3 = make_float3 ((_S683 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_21 * r_21)))))))).x, (_S683 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_21 * r_21)))))))).y, 1.0f - 0.5f * r_21 * r_21);
            }
            else
            {
                raydir_3 = make_float3 (_S683.x, _S683.y, 1.0f);
            }
        }
        *uv_undist_5 = float2 {raydir_3.x, raydir_3.y} / make_float2 ((F32_max((raydir_3.z), (9.999999960041972e-13f))));
        _S680 = true;
        break;
    }
    return _S680;
}

inline __device__ bool unproject_point_opencv(float2  uv_25, int camera_model_6, FixedArray<float, 4>  dist_coeffs_24, float3  * raydir_4)
{
    bool _S684;
    for(;;)
    {
        int3  _S685 = make_int3 (int(0));
        float3  _S686 = make_float3 ((float)_S685.x, (float)_S685.y, (float)_S685.z);
        *raydir_4 = _S686;
        if(camera_model_6 == int(3))
        {
            float lon_3 = uv_25.x;
            float lat_4 = uv_25.y;
            float cl_4 = (F32_cos((lat_4)));
            *raydir_4 = make_float3 (cl_4 * (F32_sin((lon_3))), (F32_sin((lat_4))), cl_4 * (F32_cos((lon_3))));
            _S684 = true;
            break;
        }
        FixedArray<float, 4>  _S687 = dist_coeffs_24;
        float2  uv_u_4;
        bool _S688 = undistort_point_1(uv_25, &_S687, int(8), &uv_u_4);
        if(!_S688)
        {
            _S684 = false;
            break;
        }
        float2  _S689 = uv_u_4;
        if(camera_model_6 == int(1))
        {
            float r_22 = length_0(_S689);
            float s_4;
            if(r_22 < 0.00100000004749745f)
            {
                s_4 = 1.0f - r_22 * r_22 / 6.0f;
            }
            else
            {
                s_4 = (F32_sin((r_22))) / r_22;
            }
            *raydir_4 = make_float3 ((_S689 * make_float2 (s_4)).x, (_S689 * make_float2 (s_4)).y, (F32_cos((r_22))));
        }
        else
        {
            if(camera_model_6 == int(2))
            {
                float r_23 = length_0(_S689);
                *raydir_4 = make_float3 ((_S689 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_23 * r_23)))))))).x, (_S689 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_23 * r_23)))))))).y, 1.0f - 0.5f * r_23 * r_23);
            }
            else
            {
                *raydir_4 = make_float3 (_S689.x, _S689.y, 1.0f);
            }
        }
        _S684 = true;
        break;
    }
    return _S684;
}

inline __device__ bool generate_ray_opencv(float2  uv_26, int camera_model_7, FixedArray<float, 4>  dist_coeffs_25, float3  * raydir_5)
{
    bool _S690;
    for(;;)
    {
        if(camera_model_7 == int(3))
        {
            float _S691 = uv_26.x;
            if((F32_abs((_S691))) > 3.14159274101257324f)
            {
                _S690 = true;
            }
            else
            {
                _S690 = (F32_abs((uv_26.y))) > 1.57079637050628662f;
            }
            if(_S690)
            {
                int3  _S692 = make_int3 (int(0));
                float3  _S693 = make_float3 ((float)_S692.x, (float)_S692.y, (float)_S692.z);
                *raydir_5 = _S693;
                _S690 = false;
                break;
            }
            float lat_5 = uv_26.y;
            float cl_5 = (F32_cos((lat_5)));
            *raydir_5 = make_float3 (cl_5 * (F32_sin((_S691))), (F32_sin((lat_5))), cl_5 * (F32_cos((_S691))));
            _S690 = true;
            break;
        }
        FixedArray<float, 4>  _S694 = dist_coeffs_25;
        float2  uv_u_5;
        bool _S695 = undistort_point_1(uv_26, &_S694, int(8), &uv_u_5);
        if(!_S695)
        {
            int3  _S696 = make_int3 (int(0));
            float3  _S697 = make_float3 ((float)_S696.x, (float)_S696.y, (float)_S696.z);
            *raydir_5 = _S697;
            _S690 = false;
            break;
        }
        float2  _S698 = uv_u_5;
        if(camera_model_7 == int(1))
        {
            float r_24 = length_0(_S698);
            if(r_24 >= 3.14159274101257324f)
            {
                int3  _S699 = make_int3 (int(0));
                float3  _S700 = make_float3 ((float)_S699.x, (float)_S699.y, (float)_S699.z);
                *raydir_5 = _S700;
                _S690 = false;
                break;
            }
            float s_5;
            if(r_24 < 0.00100000004749745f)
            {
                s_5 = 1.0f - r_24 * r_24 / 6.0f;
            }
            else
            {
                s_5 = (F32_sin((r_24))) / r_24;
            }
            *raydir_5 = make_float3 ((_S698 * make_float2 (s_5)).x, (_S698 * make_float2 (s_5)).y, (F32_cos((r_24))));
        }
        else
        {
            if(camera_model_7 == int(2))
            {
                float r_25 = length_0(_S698);
                if(r_25 >= 2.0f)
                {
                    int3  _S701 = make_int3 (int(0));
                    float3  _S702 = make_float3 ((float)_S701.x, (float)_S701.y, (float)_S701.z);
                    *raydir_5 = _S702;
                    _S690 = false;
                    break;
                }
                *raydir_5 = make_float3 ((_S698 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_25 * r_25)))))))).x, (_S698 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_25 * r_25)))))))).y, 1.0f - 0.5f * r_25 * r_25);
            }
            else
            {
                *raydir_5 = make_float3 (_S698.x, _S698.y, 1.0f);
            }
        }
        *raydir_5 = normalize_0(*raydir_5);
        _S690 = true;
        break;
    }
    return _S690;
}

inline __device__ bool is_valid_distortion_prism(float2  uv_27, FixedArray<float, 8>  dist_coeffs_26)
{
    float2  _S703 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S704;
    (&_S704)->primal_0 = uv_27;
    (&_S704)->differential_0 = _S703;
    FixedArray<float, 8>  _S705 = dist_coeffs_26;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S706 = s_fwd_DistThinPrism_distort_0(&_S704, &_S705);
    float2  _S707 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S708;
    (&_S708)->primal_0 = uv_27;
    (&_S708)->differential_0 = _S707;
    FixedArray<float, 8>  _S709 = dist_coeffs_26;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S710 = s_fwd_DistThinPrism_distort_0(&_S708, &_S709);
    Matrix<float, 2, 2>  _S711 = transpose_1(makeMatrix<float, 2, 2> (_S706.differential_0, _S710.differential_0));
    float _S712 = (F32_min((determinant_0(_S711)), ((F32_min((_S711.rows[int(0)].x), (_S711.rows[int(1)].y))))));
    bool _S713;
    if(_S712 > 0.25f)
    {
        _S713 = _S712 < 4.0f;
    }
    else
    {
        _S713 = false;
    }
    if(_S713)
    {
        FixedArray<float, 8>  _S714 = dist_coeffs_26;
        float2  _S715 = DistThinPrism_distort_0(uv_27, &_S714);
        _S713 = (dot_0(uv_27, _S715)) >= 0.0f;
    }
    else
    {
        _S713 = false;
    }
    return _S713;
}

inline __device__ bool persp_proj_nav_prism(float3  p_view_14, float4  intrins_14, FixedArray<float, 8>  dist_coeffs_27, float2  * uv_28)
{
    bool _S716;
    for(;;)
    {
        float2  _S717 = float2 {p_view_14.x, p_view_14.y};
        float _S718 = p_view_14.z;
        float2  uv0_2 = _S717 / make_float2 (_S718);
        if(_S718 < 0.0f)
        {
            _S716 = true;
        }
        else
        {
            float2  _S719 = make_float2 (1.0f, 0.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S720;
            (&_S720)->primal_0 = uv0_2;
            (&_S720)->differential_0 = _S719;
            FixedArray<float, 8>  _S721 = dist_coeffs_27;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S722 = s_fwd_DistThinPrism_distort_0(&_S720, &_S721);
            float2  _S723 = make_float2 (0.0f, 1.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S724;
            (&_S724)->primal_0 = uv0_2;
            (&_S724)->differential_0 = _S723;
            FixedArray<float, 8>  _S725 = dist_coeffs_27;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S726 = s_fwd_DistThinPrism_distort_0(&_S724, &_S725);
            Matrix<float, 2, 2>  _S727 = transpose_1(makeMatrix<float, 2, 2> (_S722.differential_0, _S726.differential_0));
            float _S728 = (F32_min((determinant_0(_S727)), ((F32_min((_S727.rows[int(0)].x), (_S727.rows[int(1)].y))))));
            if(_S728 > 0.25f)
            {
                _S716 = _S728 < 4.0f;
            }
            else
            {
                _S716 = false;
            }
            if(_S716)
            {
                FixedArray<float, 8>  _S729 = dist_coeffs_27;
                float2  _S730 = DistThinPrism_distort_0(uv0_2, &_S729);
                _S716 = (dot_0(uv0_2, _S730)) >= 0.0f;
            }
            else
            {
                _S716 = false;
            }
            _S716 = !_S716;
        }
        if(_S716)
        {
            *uv_28 = uv0_2;
            _S716 = false;
            break;
        }
        float2  uv_29 = _S717 / make_float2 (_S718);
        FixedArray<float, 8>  _S731 = dist_coeffs_27;
        float2  _S732 = DistThinPrism_distort_0(uv_29, &_S731);
        *uv_28 = make_float2 (intrins_14.x * _S732.x + intrins_14.z, intrins_14.y * _S732.y + intrins_14.w);
        _S716 = true;
        break;
    }
    return _S716;
}

inline __device__ bool fisheye_proj_nav_prism(float3  p_view_15, float4  intrins_15, FixedArray<float, 8>  dist_coeffs_28, float2  * uv_30)
{
    bool _S733;
    for(;;)
    {
        float2  _S734 = float2 {p_view_15.x, p_view_15.y};
        float r_26 = length_0(_S734);
        float _S735 = p_view_15.z;
        float theta_12 = (F32_atan2((r_26), (_S735)));
        bool _S736 = theta_12 < 0.00100000004749745f;
        float k_10;
        if(_S736)
        {
            k_10 = (1.0f - theta_12 * theta_12 / 3.0f) / _S735;
        }
        else
        {
            k_10 = theta_12 / r_26;
        }
        float2  _S737 = _S734 * make_float2 (k_10);
        float2  _S738 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S739;
        (&_S739)->primal_0 = _S737;
        (&_S739)->differential_0 = _S738;
        FixedArray<float, 8>  _S740 = dist_coeffs_28;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S741 = s_fwd_DistThinPrism_distort_0(&_S739, &_S740);
        float2  _S742 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S743;
        (&_S743)->primal_0 = _S737;
        (&_S743)->differential_0 = _S742;
        FixedArray<float, 8>  _S744 = dist_coeffs_28;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S745 = s_fwd_DistThinPrism_distort_0(&_S743, &_S744);
        Matrix<float, 2, 2>  _S746 = transpose_1(makeMatrix<float, 2, 2> (_S741.differential_0, _S745.differential_0));
        float _S747 = (F32_min((determinant_0(_S746)), ((F32_min((_S746.rows[int(0)].x), (_S746.rows[int(1)].y))))));
        if(_S747 > 0.25f)
        {
            _S733 = _S747 < 4.0f;
        }
        else
        {
            _S733 = false;
        }
        if(_S733)
        {
            FixedArray<float, 8>  _S748 = dist_coeffs_28;
            float2  _S749 = DistThinPrism_distort_0(_S737, &_S748);
            _S733 = (dot_0(_S737, _S749)) >= 0.0f;
        }
        else
        {
            _S733 = false;
        }
        if(!_S733)
        {
            *uv_30 = _S737;
            _S733 = false;
            break;
        }
        if(_S736)
        {
            k_10 = (1.0f - theta_12 * theta_12 / 3.0f) / _S735;
        }
        else
        {
            k_10 = theta_12 / r_26;
        }
        float2  _S750 = _S734 * make_float2 (k_10);
        FixedArray<float, 8>  _S751 = dist_coeffs_28;
        float2  _S752 = DistThinPrism_distort_0(_S750, &_S751);
        *uv_30 = make_float2 (intrins_15.x * _S752.x + intrins_15.z, intrins_15.y * _S752.y + intrins_15.w);
        _S733 = true;
        break;
    }
    return _S733;
}

inline __device__ bool equisolid_proj_nav_prism(float3  p_view_16, float4  intrins_16, FixedArray<float, 8>  dist_coeffs_29, float2  * uv_31)
{
    bool _S753;
    for(;;)
    {
        float2  _S754 = float2 {p_view_16.x, p_view_16.y};
        float r_27 = length_0(_S754);
        float _S755 = p_view_16.z;
        float theta_13 = (F32_atan2((r_27), (_S755)));
        bool _S756 = r_27 < 9.99999997475242708e-07f;
        float k_11;
        if(_S756)
        {
            k_11 = (1.0f - theta_13 * theta_13 / 24.0f) / _S755;
        }
        else
        {
            k_11 = 2.0f * (F32_sin((0.5f * theta_13))) / r_27;
        }
        float2  _S757 = _S754 * make_float2 (k_11);
        float2  _S758 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S759;
        (&_S759)->primal_0 = _S757;
        (&_S759)->differential_0 = _S758;
        FixedArray<float, 8>  _S760 = dist_coeffs_29;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S761 = s_fwd_DistThinPrism_distort_0(&_S759, &_S760);
        float2  _S762 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S763;
        (&_S763)->primal_0 = _S757;
        (&_S763)->differential_0 = _S762;
        FixedArray<float, 8>  _S764 = dist_coeffs_29;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S765 = s_fwd_DistThinPrism_distort_0(&_S763, &_S764);
        Matrix<float, 2, 2>  _S766 = transpose_1(makeMatrix<float, 2, 2> (_S761.differential_0, _S765.differential_0));
        float _S767 = (F32_min((determinant_0(_S766)), ((F32_min((_S766.rows[int(0)].x), (_S766.rows[int(1)].y))))));
        if(_S767 > 0.25f)
        {
            _S753 = _S767 < 4.0f;
        }
        else
        {
            _S753 = false;
        }
        if(_S753)
        {
            FixedArray<float, 8>  _S768 = dist_coeffs_29;
            float2  _S769 = DistThinPrism_distort_0(_S757, &_S768);
            _S753 = (dot_0(_S757, _S769)) >= 0.0f;
        }
        else
        {
            _S753 = false;
        }
        if(!_S753)
        {
            *uv_31 = _S757;
            _S753 = false;
            break;
        }
        if(_S756)
        {
            k_11 = (1.0f - theta_13 * theta_13 / 24.0f) / _S755;
        }
        else
        {
            k_11 = 2.0f * (F32_sin((0.5f * theta_13))) / r_27;
        }
        float2  _S770 = _S754 * make_float2 (k_11);
        FixedArray<float, 8>  _S771 = dist_coeffs_29;
        float2  _S772 = DistThinPrism_distort_0(_S770, &_S771);
        *uv_31 = make_float2 (intrins_16.x * _S772.x + intrins_16.z, intrins_16.y * _S772.y + intrins_16.w);
        _S753 = true;
        break;
    }
    return _S753;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_prism(float3  p_view_17, float4  intrins_17, FixedArray<float, 8>  dist_coeffs_30)
{
    float2  _S773 = float2 {p_view_17.x, p_view_17.y};
    float _S774 = p_view_17.z;
    float2  _S775 = _S773 * make_float2 (0.0f);
    float _S776 = _S774 * _S774;
    float2  s_diff_uv_6 = (make_float2 (1.0f, 0.0f) * make_float2 (_S774) - _S775) / make_float2 (_S776);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S777;
    (&_S777)->primal_0 = _S773 / make_float2 (_S774);
    (&_S777)->differential_0 = s_diff_uv_6;
    FixedArray<float, 8>  _S778 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S779 = s_fwd_DistThinPrism_distort_0(&_S777, &_S778);
    float fx_7 = intrins_17.x;
    float fy_7 = intrins_17.y;
    float _S780 = _S779.differential_0.y * fy_7;
    Matrix<float, 2, 3>  J_7;
    *&(((&J_7)->rows + (int(0)))->x) = _S779.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->x) = _S780;
    float2  s_diff_uv_7 = (make_float2 (0.0f, 1.0f) * make_float2 (_S774) - _S775) / make_float2 (_S776);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S781;
    (&_S781)->primal_0 = _S773 / make_float2 (_S774);
    (&_S781)->differential_0 = s_diff_uv_7;
    FixedArray<float, 8>  _S782 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S783 = s_fwd_DistThinPrism_distort_0(&_S781, &_S782);
    float _S784 = _S783.differential_0.y * fy_7;
    *&(((&J_7)->rows + (int(0)))->y) = _S783.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->y) = _S784;
    float2  s_diff_uv_8 = (make_float2 (0.0f, 0.0f) * make_float2 (_S774) - _S773) / make_float2 (_S776);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S785;
    (&_S785)->primal_0 = _S773 / make_float2 (_S774);
    (&_S785)->differential_0 = s_diff_uv_8;
    FixedArray<float, 8>  _S786 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S787 = s_fwd_DistThinPrism_distort_0(&_S785, &_S786);
    float _S788 = _S787.differential_0.y * fy_7;
    *&(((&J_7)->rows + (int(0)))->z) = _S787.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->z) = _S788;
    return J_7;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_prism(float3  p_view_18, float4  intrins_18, FixedArray<float, 8>  dist_coeffs_31)
{
    Matrix<float, 2, 3>  J_8;
    float2  _S789 = float2 {p_view_18.x, p_view_18.y};
    float2  _S790 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S791;
    (&_S791)->primal_0 = _S789;
    (&_S791)->differential_0 = _S790;
    DiffPair_float_0 _S792 = s_fwd_length_impl_0(&_S791);
    float _S793 = p_view_18.z;
    DiffPair_float_0 _S794;
    (&_S794)->primal_0 = _S792.primal_0;
    (&_S794)->differential_0 = _S792.differential_0;
    DiffPair_float_0 _S795;
    (&_S795)->primal_0 = _S793;
    (&_S795)->differential_0 = 0.0f;
    DiffPair_float_0 _S796 = _d_atan2_0(&_S794, &_S795);
    float k_12;
    float s_diff_k_4;
    if((_S796.primal_0) < 0.00100000004749745f)
    {
        float _S797 = _S796.differential_0 * _S796.primal_0;
        float _S798 = 1.0f - _S796.primal_0 * _S796.primal_0 / 3.0f;
        float _S799 = ((0.0f - (_S797 + _S797) * 0.3333333432674408f) * _S793 - _S798 * 0.0f) / (_S793 * _S793);
        k_12 = _S798 / _S793;
        s_diff_k_4 = _S799;
    }
    else
    {
        float _S800 = (_S796.differential_0 * _S792.primal_0 - _S796.primal_0 * _S792.differential_0) / (_S792.primal_0 * _S792.primal_0);
        k_12 = _S796.primal_0 / _S792.primal_0;
        s_diff_k_4 = _S800;
    }
    float2  _S801 = _S789 * make_float2 (k_12);
    float2  _S802 = _S790 * make_float2 (k_12) + make_float2 (s_diff_k_4) * _S789;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S803;
    (&_S803)->primal_0 = _S801;
    (&_S803)->differential_0 = _S802;
    FixedArray<float, 8>  _S804 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S805 = s_fwd_DistThinPrism_distort_0(&_S803, &_S804);
    float fx_8 = intrins_18.x;
    float fy_8 = intrins_18.y;
    float _S806 = _S805.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->x) = _S805.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->x) = _S806;
    float2  _S807 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S808;
    (&_S808)->primal_0 = _S789;
    (&_S808)->differential_0 = _S807;
    DiffPair_float_0 _S809 = s_fwd_length_impl_0(&_S808);
    DiffPair_float_0 _S810;
    (&_S810)->primal_0 = _S809.primal_0;
    (&_S810)->differential_0 = _S809.differential_0;
    DiffPair_float_0 _S811;
    (&_S811)->primal_0 = _S793;
    (&_S811)->differential_0 = 0.0f;
    DiffPair_float_0 _S812 = _d_atan2_0(&_S810, &_S811);
    if((_S812.primal_0) < 0.00100000004749745f)
    {
        float _S813 = _S812.differential_0 * _S812.primal_0;
        float _S814 = 1.0f - _S812.primal_0 * _S812.primal_0 / 3.0f;
        float _S815 = ((0.0f - (_S813 + _S813) * 0.3333333432674408f) * _S793 - _S814 * 0.0f) / (_S793 * _S793);
        k_12 = _S814 / _S793;
        s_diff_k_4 = _S815;
    }
    else
    {
        float _S816 = (_S812.differential_0 * _S809.primal_0 - _S812.primal_0 * _S809.differential_0) / (_S809.primal_0 * _S809.primal_0);
        k_12 = _S812.primal_0 / _S809.primal_0;
        s_diff_k_4 = _S816;
    }
    float2  _S817 = _S789 * make_float2 (k_12);
    float2  _S818 = _S807 * make_float2 (k_12) + make_float2 (s_diff_k_4) * _S789;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S819;
    (&_S819)->primal_0 = _S817;
    (&_S819)->differential_0 = _S818;
    FixedArray<float, 8>  _S820 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S821 = s_fwd_DistThinPrism_distort_0(&_S819, &_S820);
    float _S822 = _S821.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->y) = _S821.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->y) = _S822;
    float2  _S823 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S824;
    (&_S824)->primal_0 = _S789;
    (&_S824)->differential_0 = _S823;
    DiffPair_float_0 _S825 = s_fwd_length_impl_0(&_S824);
    DiffPair_float_0 _S826;
    (&_S826)->primal_0 = _S825.primal_0;
    (&_S826)->differential_0 = _S825.differential_0;
    DiffPair_float_0 _S827;
    (&_S827)->primal_0 = _S793;
    (&_S827)->differential_0 = 1.0f;
    DiffPair_float_0 _S828 = _d_atan2_0(&_S826, &_S827);
    if((_S828.primal_0) < 0.00100000004749745f)
    {
        float _S829 = _S828.differential_0 * _S828.primal_0;
        float _S830 = 1.0f - _S828.primal_0 * _S828.primal_0 / 3.0f;
        float _S831 = ((0.0f - (_S829 + _S829) * 0.3333333432674408f) * _S793 - _S830) / (_S793 * _S793);
        k_12 = _S830 / _S793;
        s_diff_k_4 = _S831;
    }
    else
    {
        float _S832 = (_S828.differential_0 * _S825.primal_0 - _S828.primal_0 * _S825.differential_0) / (_S825.primal_0 * _S825.primal_0);
        k_12 = _S828.primal_0 / _S825.primal_0;
        s_diff_k_4 = _S832;
    }
    float2  _S833 = _S789 * make_float2 (k_12);
    float2  _S834 = _S823 * make_float2 (k_12) + make_float2 (s_diff_k_4) * _S789;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S835;
    (&_S835)->primal_0 = _S833;
    (&_S835)->differential_0 = _S834;
    FixedArray<float, 8>  _S836 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S837 = s_fwd_DistThinPrism_distort_0(&_S835, &_S836);
    float _S838 = _S837.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->z) = _S837.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->z) = _S838;
    return J_8;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_prism(float3  p_view_19, float4  intrins_19, FixedArray<float, 8>  dist_coeffs_32)
{
    Matrix<float, 2, 3>  J_9;
    float2  _S839 = float2 {p_view_19.x, p_view_19.y};
    float2  _S840 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S841;
    (&_S841)->primal_0 = _S839;
    (&_S841)->differential_0 = _S840;
    DiffPair_float_0 _S842 = s_fwd_length_impl_0(&_S841);
    float _S843 = p_view_19.z;
    DiffPair_float_0 _S844;
    (&_S844)->primal_0 = _S842.primal_0;
    (&_S844)->differential_0 = _S842.differential_0;
    DiffPair_float_0 _S845;
    (&_S845)->primal_0 = _S843;
    (&_S845)->differential_0 = 0.0f;
    DiffPair_float_0 _S846 = _d_atan2_0(&_S844, &_S845);
    float k_13;
    float s_diff_k_5;
    if((_S842.primal_0) < 9.99999997475242708e-07f)
    {
        float _S847 = _S846.differential_0 * _S846.primal_0;
        float _S848 = 1.0f - _S846.primal_0 * _S846.primal_0 / 24.0f;
        float _S849 = ((0.0f - (_S847 + _S847) * 0.0416666679084301f) * _S843 - _S848 * 0.0f) / (_S843 * _S843);
        k_13 = _S848 / _S843;
        s_diff_k_5 = _S849;
    }
    else
    {
        float _S850 = _S846.differential_0 * 0.5f;
        DiffPair_float_0 _S851;
        (&_S851)->primal_0 = 0.5f * _S846.primal_0;
        (&_S851)->differential_0 = _S850;
        DiffPair_float_0 _S852 = _d_sin_0(&_S851);
        float _S853 = 2.0f * _S852.primal_0;
        float _S854 = (_S852.differential_0 * 2.0f * _S842.primal_0 - _S853 * _S842.differential_0) / (_S842.primal_0 * _S842.primal_0);
        k_13 = _S853 / _S842.primal_0;
        s_diff_k_5 = _S854;
    }
    float2  _S855 = _S839 * make_float2 (k_13);
    float2  _S856 = _S840 * make_float2 (k_13) + make_float2 (s_diff_k_5) * _S839;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S857;
    (&_S857)->primal_0 = _S855;
    (&_S857)->differential_0 = _S856;
    FixedArray<float, 8>  _S858 = dist_coeffs_32;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S859 = s_fwd_DistThinPrism_distort_0(&_S857, &_S858);
    float fx_9 = intrins_19.x;
    float fy_9 = intrins_19.y;
    float _S860 = _S859.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->x) = _S859.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->x) = _S860;
    float2  _S861 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S862;
    (&_S862)->primal_0 = _S839;
    (&_S862)->differential_0 = _S861;
    DiffPair_float_0 _S863 = s_fwd_length_impl_0(&_S862);
    DiffPair_float_0 _S864;
    (&_S864)->primal_0 = _S863.primal_0;
    (&_S864)->differential_0 = _S863.differential_0;
    DiffPair_float_0 _S865;
    (&_S865)->primal_0 = _S843;
    (&_S865)->differential_0 = 0.0f;
    DiffPair_float_0 _S866 = _d_atan2_0(&_S864, &_S865);
    if((_S863.primal_0) < 9.99999997475242708e-07f)
    {
        float _S867 = _S866.differential_0 * _S866.primal_0;
        float _S868 = 1.0f - _S866.primal_0 * _S866.primal_0 / 24.0f;
        float _S869 = ((0.0f - (_S867 + _S867) * 0.0416666679084301f) * _S843 - _S868 * 0.0f) / (_S843 * _S843);
        k_13 = _S868 / _S843;
        s_diff_k_5 = _S869;
    }
    else
    {
        float _S870 = _S866.differential_0 * 0.5f;
        DiffPair_float_0 _S871;
        (&_S871)->primal_0 = 0.5f * _S866.primal_0;
        (&_S871)->differential_0 = _S870;
        DiffPair_float_0 _S872 = _d_sin_0(&_S871);
        float _S873 = 2.0f * _S872.primal_0;
        float _S874 = (_S872.differential_0 * 2.0f * _S863.primal_0 - _S873 * _S863.differential_0) / (_S863.primal_0 * _S863.primal_0);
        k_13 = _S873 / _S863.primal_0;
        s_diff_k_5 = _S874;
    }
    float2  _S875 = _S839 * make_float2 (k_13);
    float2  _S876 = _S861 * make_float2 (k_13) + make_float2 (s_diff_k_5) * _S839;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S877;
    (&_S877)->primal_0 = _S875;
    (&_S877)->differential_0 = _S876;
    FixedArray<float, 8>  _S878 = dist_coeffs_32;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S879 = s_fwd_DistThinPrism_distort_0(&_S877, &_S878);
    float _S880 = _S879.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->y) = _S879.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->y) = _S880;
    float2  _S881 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S882;
    (&_S882)->primal_0 = _S839;
    (&_S882)->differential_0 = _S881;
    DiffPair_float_0 _S883 = s_fwd_length_impl_0(&_S882);
    DiffPair_float_0 _S884;
    (&_S884)->primal_0 = _S883.primal_0;
    (&_S884)->differential_0 = _S883.differential_0;
    DiffPair_float_0 _S885;
    (&_S885)->primal_0 = _S843;
    (&_S885)->differential_0 = 1.0f;
    DiffPair_float_0 _S886 = _d_atan2_0(&_S884, &_S885);
    if((_S883.primal_0) < 9.99999997475242708e-07f)
    {
        float _S887 = _S886.differential_0 * _S886.primal_0;
        float _S888 = 1.0f - _S886.primal_0 * _S886.primal_0 / 24.0f;
        float _S889 = ((0.0f - (_S887 + _S887) * 0.0416666679084301f) * _S843 - _S888) / (_S843 * _S843);
        k_13 = _S888 / _S843;
        s_diff_k_5 = _S889;
    }
    else
    {
        float _S890 = _S886.differential_0 * 0.5f;
        DiffPair_float_0 _S891;
        (&_S891)->primal_0 = 0.5f * _S886.primal_0;
        (&_S891)->differential_0 = _S890;
        DiffPair_float_0 _S892 = _d_sin_0(&_S891);
        float _S893 = 2.0f * _S892.primal_0;
        float _S894 = (_S892.differential_0 * 2.0f * _S883.primal_0 - _S893 * _S883.differential_0) / (_S883.primal_0 * _S883.primal_0);
        k_13 = _S893 / _S883.primal_0;
        s_diff_k_5 = _S894;
    }
    float2  _S895 = _S839 * make_float2 (k_13);
    float2  _S896 = _S881 * make_float2 (k_13) + make_float2 (s_diff_k_5) * _S839;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S897;
    (&_S897)->primal_0 = _S895;
    (&_S897)->differential_0 = _S896;
    FixedArray<float, 8>  _S898 = dist_coeffs_32;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S899 = s_fwd_DistThinPrism_distort_0(&_S897, &_S898);
    float _S900 = _S899.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->z) = _S899.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->z) = _S900;
    return J_9;
}

inline __device__ float2  distort_point_prism(float2  uv_32, int camera_model_8, FixedArray<float, 8>  dist_coeffs_33)
{
    float2  _S901;
    for(;;)
    {
        if(camera_model_8 == int(3))
        {
            _S901 = uv_32;
            break;
        }
        float k_14;
        if(camera_model_8 == int(1))
        {
            float r_28 = length_0(uv_32);
            float theta_14 = (F32_atan((r_28)));
            if(r_28 < 0.00100000004749745f)
            {
                k_14 = 1.0f - theta_14 * theta_14 / 6.0f;
            }
            else
            {
                k_14 = theta_14 / r_28;
            }
            _S901 = uv_32 * make_float2 (k_14);
        }
        else
        {
            if(camera_model_8 == int(2))
            {
                float r_29 = length_0(uv_32);
                float theta_15 = (F32_atan((r_29)));
                if(r_29 < 0.00100000004749745f)
                {
                    k_14 = 1.0f - theta_15 * theta_15 / 24.0f;
                }
                else
                {
                    k_14 = 2.0f * (F32_sin((0.5f * theta_15))) / r_29;
                }
                _S901 = uv_32 * make_float2 (k_14);
            }
            else
            {
                _S901 = uv_32;
            }
        }
        FixedArray<float, 8>  _S902 = dist_coeffs_33;
        float2  _S903 = DistThinPrism_distort_0(_S901, &_S902);
        _S901 = _S903;
        break;
    }
    return _S901;
}

inline __device__ bool undistort_point_prism(float2  uv_33, int camera_model_9, FixedArray<float, 8>  dist_coeffs_34, float2  * uv_undist_6)
{
    bool _S904;
    for(;;)
    {
        *uv_undist_6 = make_float2 (0.0f);
        if(camera_model_9 == int(3))
        {
            float lon_4 = uv_33.x;
            float lat_6 = uv_33.y;
            float cl_6 = (F32_cos((lat_6)));
            *uv_undist_6 = make_float2 (cl_6 * (F32_sin((lon_4))), (F32_sin((lat_6)))) / make_float2 ((F32_max((cl_6 * (F32_cos((lon_4)))), (9.999999960041972e-13f))));
            _S904 = true;
            break;
        }
        FixedArray<float, 8>  _S905 = dist_coeffs_34;
        float2  uv_u_6;
        bool _S906 = undistort_point_2(uv_33, &_S905, int(8), &uv_u_6);
        if(!_S906)
        {
            _S904 = false;
            break;
        }
        float2  _S907 = uv_u_6;
        float3  raydir_6;
        if(camera_model_9 == int(1))
        {
            float r_30 = length_0(_S907);
            float s_6;
            if(r_30 < 0.00100000004749745f)
            {
                s_6 = 1.0f - r_30 * r_30 / 6.0f;
            }
            else
            {
                s_6 = (F32_sin((r_30))) / r_30;
            }
            raydir_6 = make_float3 ((_S907 * make_float2 (s_6)).x, (_S907 * make_float2 (s_6)).y, (F32_cos((r_30))));
        }
        else
        {
            if(camera_model_9 == int(2))
            {
                float r_31 = length_0(_S907);
                raydir_6 = make_float3 ((_S907 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_31 * r_31)))))))).x, (_S907 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_31 * r_31)))))))).y, 1.0f - 0.5f * r_31 * r_31);
            }
            else
            {
                raydir_6 = make_float3 (_S907.x, _S907.y, 1.0f);
            }
        }
        *uv_undist_6 = float2 {raydir_6.x, raydir_6.y} / make_float2 ((F32_max((raydir_6.z), (9.999999960041972e-13f))));
        _S904 = true;
        break;
    }
    return _S904;
}

inline __device__ bool unproject_point_prism(float2  uv_34, int camera_model_10, FixedArray<float, 8>  dist_coeffs_35, float3  * raydir_7)
{
    bool _S908;
    for(;;)
    {
        int3  _S909 = make_int3 (int(0));
        float3  _S910 = make_float3 ((float)_S909.x, (float)_S909.y, (float)_S909.z);
        *raydir_7 = _S910;
        if(camera_model_10 == int(3))
        {
            float lon_5 = uv_34.x;
            float lat_7 = uv_34.y;
            float cl_7 = (F32_cos((lat_7)));
            *raydir_7 = make_float3 (cl_7 * (F32_sin((lon_5))), (F32_sin((lat_7))), cl_7 * (F32_cos((lon_5))));
            _S908 = true;
            break;
        }
        FixedArray<float, 8>  _S911 = dist_coeffs_35;
        float2  uv_u_7;
        bool _S912 = undistort_point_2(uv_34, &_S911, int(8), &uv_u_7);
        if(!_S912)
        {
            _S908 = false;
            break;
        }
        float2  _S913 = uv_u_7;
        if(camera_model_10 == int(1))
        {
            float r_32 = length_0(_S913);
            float s_7;
            if(r_32 < 0.00100000004749745f)
            {
                s_7 = 1.0f - r_32 * r_32 / 6.0f;
            }
            else
            {
                s_7 = (F32_sin((r_32))) / r_32;
            }
            *raydir_7 = make_float3 ((_S913 * make_float2 (s_7)).x, (_S913 * make_float2 (s_7)).y, (F32_cos((r_32))));
        }
        else
        {
            if(camera_model_10 == int(2))
            {
                float r_33 = length_0(_S913);
                *raydir_7 = make_float3 ((_S913 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_33 * r_33)))))))).x, (_S913 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_33 * r_33)))))))).y, 1.0f - 0.5f * r_33 * r_33);
            }
            else
            {
                *raydir_7 = make_float3 (_S913.x, _S913.y, 1.0f);
            }
        }
        _S908 = true;
        break;
    }
    return _S908;
}

inline __device__ bool generate_ray_prism(float2  uv_35, int camera_model_11, FixedArray<float, 8>  dist_coeffs_36, float3  * raydir_8)
{
    bool _S914;
    for(;;)
    {
        if(camera_model_11 == int(3))
        {
            float _S915 = uv_35.x;
            if((F32_abs((_S915))) > 3.14159274101257324f)
            {
                _S914 = true;
            }
            else
            {
                _S914 = (F32_abs((uv_35.y))) > 1.57079637050628662f;
            }
            if(_S914)
            {
                int3  _S916 = make_int3 (int(0));
                float3  _S917 = make_float3 ((float)_S916.x, (float)_S916.y, (float)_S916.z);
                *raydir_8 = _S917;
                _S914 = false;
                break;
            }
            float lat_8 = uv_35.y;
            float cl_8 = (F32_cos((lat_8)));
            *raydir_8 = make_float3 (cl_8 * (F32_sin((_S915))), (F32_sin((lat_8))), cl_8 * (F32_cos((_S915))));
            _S914 = true;
            break;
        }
        FixedArray<float, 8>  _S918 = dist_coeffs_36;
        float2  uv_u_8;
        bool _S919 = undistort_point_2(uv_35, &_S918, int(8), &uv_u_8);
        if(!_S919)
        {
            int3  _S920 = make_int3 (int(0));
            float3  _S921 = make_float3 ((float)_S920.x, (float)_S920.y, (float)_S920.z);
            *raydir_8 = _S921;
            _S914 = false;
            break;
        }
        float2  _S922 = uv_u_8;
        if(camera_model_11 == int(1))
        {
            float r_34 = length_0(_S922);
            if(r_34 >= 3.14159274101257324f)
            {
                int3  _S923 = make_int3 (int(0));
                float3  _S924 = make_float3 ((float)_S923.x, (float)_S923.y, (float)_S923.z);
                *raydir_8 = _S924;
                _S914 = false;
                break;
            }
            float s_8;
            if(r_34 < 0.00100000004749745f)
            {
                s_8 = 1.0f - r_34 * r_34 / 6.0f;
            }
            else
            {
                s_8 = (F32_sin((r_34))) / r_34;
            }
            *raydir_8 = make_float3 ((_S922 * make_float2 (s_8)).x, (_S922 * make_float2 (s_8)).y, (F32_cos((r_34))));
        }
        else
        {
            if(camera_model_11 == int(2))
            {
                float r_35 = length_0(_S922);
                if(r_35 >= 2.0f)
                {
                    int3  _S925 = make_int3 (int(0));
                    float3  _S926 = make_float3 ((float)_S925.x, (float)_S925.y, (float)_S925.z);
                    *raydir_8 = _S926;
                    _S914 = false;
                    break;
                }
                *raydir_8 = make_float3 ((_S922 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_35 * r_35)))))))).x, (_S922 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_35 * r_35)))))))).y, 1.0f - 0.5f * r_35 * r_35);
            }
            else
            {
                *raydir_8 = make_float3 (_S922.x, _S922.y, 1.0f);
            }
        }
        *raydir_8 = normalize_0(*raydir_8);
        _S914 = true;
        break;
    }
    return _S914;
}

inline __device__ bool is_valid_distortion_polar(float2  uv_36, FixedArray<float, 58>  dist_coeffs_37)
{
    float2  _S927 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S928;
    (&_S928)->primal_0 = uv_36;
    (&_S928)->differential_0 = _S927;
    FixedArray<float, 58>  _S929 = dist_coeffs_37;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S930 = s_fwd_DistKBPolarSpline_distort_0(&_S928, &_S929);
    float2  _S931 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S932;
    (&_S932)->primal_0 = uv_36;
    (&_S932)->differential_0 = _S931;
    FixedArray<float, 58>  _S933 = dist_coeffs_37;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S934 = s_fwd_DistKBPolarSpline_distort_0(&_S932, &_S933);
    Matrix<float, 2, 2>  _S935 = transpose_1(makeMatrix<float, 2, 2> (_S930.differential_0, _S934.differential_0));
    float _S936 = (F32_min((determinant_0(_S935)), ((F32_min((_S935.rows[int(0)].x), (_S935.rows[int(1)].y))))));
    bool _S937;
    if(_S936 > 0.25f)
    {
        _S937 = _S936 < 4.0f;
    }
    else
    {
        _S937 = false;
    }
    if(_S937)
    {
        FixedArray<float, 58>  _S938 = dist_coeffs_37;
        float2  _S939 = DistKBPolarSpline_distort_0(uv_36, &_S938);
        _S937 = (dot_0(uv_36, _S939)) >= 0.0f;
    }
    else
    {
        _S937 = false;
    }
    return _S937;
}

inline __device__ bool persp_proj_nav_polar(float3  p_view_20, float4  intrins_20, FixedArray<float, 58>  dist_coeffs_38, float2  * uv_37)
{
    bool _S940;
    for(;;)
    {
        float2  _S941 = float2 {p_view_20.x, p_view_20.y};
        float _S942 = p_view_20.z;
        float2  uv0_3 = _S941 / make_float2 (_S942);
        if(_S942 < 0.0f)
        {
            _S940 = true;
        }
        else
        {
            float2  _S943 = make_float2 (1.0f, 0.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S944;
            (&_S944)->primal_0 = uv0_3;
            (&_S944)->differential_0 = _S943;
            FixedArray<float, 58>  _S945 = dist_coeffs_38;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S946 = s_fwd_DistKBPolarSpline_distort_0(&_S944, &_S945);
            float2  _S947 = make_float2 (0.0f, 1.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S948;
            (&_S948)->primal_0 = uv0_3;
            (&_S948)->differential_0 = _S947;
            FixedArray<float, 58>  _S949 = dist_coeffs_38;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S950 = s_fwd_DistKBPolarSpline_distort_0(&_S948, &_S949);
            Matrix<float, 2, 2>  _S951 = transpose_1(makeMatrix<float, 2, 2> (_S946.differential_0, _S950.differential_0));
            float _S952 = (F32_min((determinant_0(_S951)), ((F32_min((_S951.rows[int(0)].x), (_S951.rows[int(1)].y))))));
            if(_S952 > 0.25f)
            {
                _S940 = _S952 < 4.0f;
            }
            else
            {
                _S940 = false;
            }
            if(_S940)
            {
                FixedArray<float, 58>  _S953 = dist_coeffs_38;
                float2  _S954 = DistKBPolarSpline_distort_0(uv0_3, &_S953);
                _S940 = (dot_0(uv0_3, _S954)) >= 0.0f;
            }
            else
            {
                _S940 = false;
            }
            _S940 = !_S940;
        }
        if(_S940)
        {
            *uv_37 = uv0_3;
            _S940 = false;
            break;
        }
        float2  uv_38 = _S941 / make_float2 (_S942);
        FixedArray<float, 58>  _S955 = dist_coeffs_38;
        float2  _S956 = DistKBPolarSpline_distort_0(uv_38, &_S955);
        *uv_37 = make_float2 (intrins_20.x * _S956.x + intrins_20.z, intrins_20.y * _S956.y + intrins_20.w);
        _S940 = true;
        break;
    }
    return _S940;
}

inline __device__ bool fisheye_proj_nav_polar(float3  p_view_21, float4  intrins_21, FixedArray<float, 58>  dist_coeffs_39, float2  * uv_39)
{
    bool _S957;
    for(;;)
    {
        float2  _S958 = float2 {p_view_21.x, p_view_21.y};
        float r_36 = length_0(_S958);
        float _S959 = p_view_21.z;
        float theta_16 = (F32_atan2((r_36), (_S959)));
        bool _S960 = theta_16 < 0.00100000004749745f;
        float k_15;
        if(_S960)
        {
            k_15 = (1.0f - theta_16 * theta_16 / 3.0f) / _S959;
        }
        else
        {
            k_15 = theta_16 / r_36;
        }
        float2  _S961 = _S958 * make_float2 (k_15);
        float2  _S962 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S963;
        (&_S963)->primal_0 = _S961;
        (&_S963)->differential_0 = _S962;
        FixedArray<float, 58>  _S964 = dist_coeffs_39;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S965 = s_fwd_DistKBPolarSpline_distort_0(&_S963, &_S964);
        float2  _S966 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S967;
        (&_S967)->primal_0 = _S961;
        (&_S967)->differential_0 = _S966;
        FixedArray<float, 58>  _S968 = dist_coeffs_39;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S969 = s_fwd_DistKBPolarSpline_distort_0(&_S967, &_S968);
        Matrix<float, 2, 2>  _S970 = transpose_1(makeMatrix<float, 2, 2> (_S965.differential_0, _S969.differential_0));
        float _S971 = (F32_min((determinant_0(_S970)), ((F32_min((_S970.rows[int(0)].x), (_S970.rows[int(1)].y))))));
        if(_S971 > 0.25f)
        {
            _S957 = _S971 < 4.0f;
        }
        else
        {
            _S957 = false;
        }
        if(_S957)
        {
            FixedArray<float, 58>  _S972 = dist_coeffs_39;
            float2  _S973 = DistKBPolarSpline_distort_0(_S961, &_S972);
            _S957 = (dot_0(_S961, _S973)) >= 0.0f;
        }
        else
        {
            _S957 = false;
        }
        if(!_S957)
        {
            *uv_39 = _S961;
            _S957 = false;
            break;
        }
        if(_S960)
        {
            k_15 = (1.0f - theta_16 * theta_16 / 3.0f) / _S959;
        }
        else
        {
            k_15 = theta_16 / r_36;
        }
        float2  _S974 = _S958 * make_float2 (k_15);
        FixedArray<float, 58>  _S975 = dist_coeffs_39;
        float2  _S976 = DistKBPolarSpline_distort_0(_S974, &_S975);
        *uv_39 = make_float2 (intrins_21.x * _S976.x + intrins_21.z, intrins_21.y * _S976.y + intrins_21.w);
        _S957 = true;
        break;
    }
    return _S957;
}

inline __device__ bool equisolid_proj_nav_polar(float3  p_view_22, float4  intrins_22, FixedArray<float, 58>  dist_coeffs_40, float2  * uv_40)
{
    bool _S977;
    for(;;)
    {
        float2  _S978 = float2 {p_view_22.x, p_view_22.y};
        float r_37 = length_0(_S978);
        float _S979 = p_view_22.z;
        float theta_17 = (F32_atan2((r_37), (_S979)));
        bool _S980 = r_37 < 9.99999997475242708e-07f;
        float k_16;
        if(_S980)
        {
            k_16 = (1.0f - theta_17 * theta_17 / 24.0f) / _S979;
        }
        else
        {
            k_16 = 2.0f * (F32_sin((0.5f * theta_17))) / r_37;
        }
        float2  _S981 = _S978 * make_float2 (k_16);
        float2  _S982 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S983;
        (&_S983)->primal_0 = _S981;
        (&_S983)->differential_0 = _S982;
        FixedArray<float, 58>  _S984 = dist_coeffs_40;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S985 = s_fwd_DistKBPolarSpline_distort_0(&_S983, &_S984);
        float2  _S986 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S987;
        (&_S987)->primal_0 = _S981;
        (&_S987)->differential_0 = _S986;
        FixedArray<float, 58>  _S988 = dist_coeffs_40;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S989 = s_fwd_DistKBPolarSpline_distort_0(&_S987, &_S988);
        Matrix<float, 2, 2>  _S990 = transpose_1(makeMatrix<float, 2, 2> (_S985.differential_0, _S989.differential_0));
        float _S991 = (F32_min((determinant_0(_S990)), ((F32_min((_S990.rows[int(0)].x), (_S990.rows[int(1)].y))))));
        if(_S991 > 0.25f)
        {
            _S977 = _S991 < 4.0f;
        }
        else
        {
            _S977 = false;
        }
        if(_S977)
        {
            FixedArray<float, 58>  _S992 = dist_coeffs_40;
            float2  _S993 = DistKBPolarSpline_distort_0(_S981, &_S992);
            _S977 = (dot_0(_S981, _S993)) >= 0.0f;
        }
        else
        {
            _S977 = false;
        }
        if(!_S977)
        {
            *uv_40 = _S981;
            _S977 = false;
            break;
        }
        if(_S980)
        {
            k_16 = (1.0f - theta_17 * theta_17 / 24.0f) / _S979;
        }
        else
        {
            k_16 = 2.0f * (F32_sin((0.5f * theta_17))) / r_37;
        }
        float2  _S994 = _S978 * make_float2 (k_16);
        FixedArray<float, 58>  _S995 = dist_coeffs_40;
        float2  _S996 = DistKBPolarSpline_distort_0(_S994, &_S995);
        *uv_40 = make_float2 (intrins_22.x * _S996.x + intrins_22.z, intrins_22.y * _S996.y + intrins_22.w);
        _S977 = true;
        break;
    }
    return _S977;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_polar(float3  p_view_23, float4  intrins_23, FixedArray<float, 58>  dist_coeffs_41)
{
    float2  _S997 = float2 {p_view_23.x, p_view_23.y};
    float _S998 = p_view_23.z;
    float2  _S999 = _S997 * make_float2 (0.0f);
    float _S1000 = _S998 * _S998;
    float2  s_diff_uv_9 = (make_float2 (1.0f, 0.0f) * make_float2 (_S998) - _S999) / make_float2 (_S1000);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1001;
    (&_S1001)->primal_0 = _S997 / make_float2 (_S998);
    (&_S1001)->differential_0 = s_diff_uv_9;
    FixedArray<float, 58>  _S1002 = dist_coeffs_41;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1003 = s_fwd_DistKBPolarSpline_distort_0(&_S1001, &_S1002);
    float fx_10 = intrins_23.x;
    float fy_10 = intrins_23.y;
    float _S1004 = _S1003.differential_0.y * fy_10;
    Matrix<float, 2, 3>  J_10;
    *&(((&J_10)->rows + (int(0)))->x) = _S1003.differential_0.x * fx_10;
    *&(((&J_10)->rows + (int(1)))->x) = _S1004;
    float2  s_diff_uv_10 = (make_float2 (0.0f, 1.0f) * make_float2 (_S998) - _S999) / make_float2 (_S1000);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1005;
    (&_S1005)->primal_0 = _S997 / make_float2 (_S998);
    (&_S1005)->differential_0 = s_diff_uv_10;
    FixedArray<float, 58>  _S1006 = dist_coeffs_41;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1007 = s_fwd_DistKBPolarSpline_distort_0(&_S1005, &_S1006);
    float _S1008 = _S1007.differential_0.y * fy_10;
    *&(((&J_10)->rows + (int(0)))->y) = _S1007.differential_0.x * fx_10;
    *&(((&J_10)->rows + (int(1)))->y) = _S1008;
    float2  s_diff_uv_11 = (make_float2 (0.0f, 0.0f) * make_float2 (_S998) - _S997) / make_float2 (_S1000);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1009;
    (&_S1009)->primal_0 = _S997 / make_float2 (_S998);
    (&_S1009)->differential_0 = s_diff_uv_11;
    FixedArray<float, 58>  _S1010 = dist_coeffs_41;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1011 = s_fwd_DistKBPolarSpline_distort_0(&_S1009, &_S1010);
    float _S1012 = _S1011.differential_0.y * fy_10;
    *&(((&J_10)->rows + (int(0)))->z) = _S1011.differential_0.x * fx_10;
    *&(((&J_10)->rows + (int(1)))->z) = _S1012;
    return J_10;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_polar(float3  p_view_24, float4  intrins_24, FixedArray<float, 58>  dist_coeffs_42)
{
    Matrix<float, 2, 3>  J_11;
    float2  _S1013 = float2 {p_view_24.x, p_view_24.y};
    float2  _S1014 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1015;
    (&_S1015)->primal_0 = _S1013;
    (&_S1015)->differential_0 = _S1014;
    DiffPair_float_0 _S1016 = s_fwd_length_impl_0(&_S1015);
    float _S1017 = p_view_24.z;
    DiffPair_float_0 _S1018;
    (&_S1018)->primal_0 = _S1016.primal_0;
    (&_S1018)->differential_0 = _S1016.differential_0;
    DiffPair_float_0 _S1019;
    (&_S1019)->primal_0 = _S1017;
    (&_S1019)->differential_0 = 0.0f;
    DiffPair_float_0 _S1020 = _d_atan2_0(&_S1018, &_S1019);
    float k_17;
    float s_diff_k_6;
    if((_S1020.primal_0) < 0.00100000004749745f)
    {
        float _S1021 = _S1020.differential_0 * _S1020.primal_0;
        float _S1022 = 1.0f - _S1020.primal_0 * _S1020.primal_0 / 3.0f;
        float _S1023 = ((0.0f - (_S1021 + _S1021) * 0.3333333432674408f) * _S1017 - _S1022 * 0.0f) / (_S1017 * _S1017);
        k_17 = _S1022 / _S1017;
        s_diff_k_6 = _S1023;
    }
    else
    {
        float _S1024 = (_S1020.differential_0 * _S1016.primal_0 - _S1020.primal_0 * _S1016.differential_0) / (_S1016.primal_0 * _S1016.primal_0);
        k_17 = _S1020.primal_0 / _S1016.primal_0;
        s_diff_k_6 = _S1024;
    }
    float2  _S1025 = _S1013 * make_float2 (k_17);
    float2  _S1026 = _S1014 * make_float2 (k_17) + make_float2 (s_diff_k_6) * _S1013;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1027;
    (&_S1027)->primal_0 = _S1025;
    (&_S1027)->differential_0 = _S1026;
    FixedArray<float, 58>  _S1028 = dist_coeffs_42;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1029 = s_fwd_DistKBPolarSpline_distort_0(&_S1027, &_S1028);
    float fx_11 = intrins_24.x;
    float fy_11 = intrins_24.y;
    float _S1030 = _S1029.differential_0.y * fy_11;
    *&(((&J_11)->rows + (int(0)))->x) = _S1029.differential_0.x * fx_11;
    *&(((&J_11)->rows + (int(1)))->x) = _S1030;
    float2  _S1031 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1032;
    (&_S1032)->primal_0 = _S1013;
    (&_S1032)->differential_0 = _S1031;
    DiffPair_float_0 _S1033 = s_fwd_length_impl_0(&_S1032);
    DiffPair_float_0 _S1034;
    (&_S1034)->primal_0 = _S1033.primal_0;
    (&_S1034)->differential_0 = _S1033.differential_0;
    DiffPair_float_0 _S1035;
    (&_S1035)->primal_0 = _S1017;
    (&_S1035)->differential_0 = 0.0f;
    DiffPair_float_0 _S1036 = _d_atan2_0(&_S1034, &_S1035);
    if((_S1036.primal_0) < 0.00100000004749745f)
    {
        float _S1037 = _S1036.differential_0 * _S1036.primal_0;
        float _S1038 = 1.0f - _S1036.primal_0 * _S1036.primal_0 / 3.0f;
        float _S1039 = ((0.0f - (_S1037 + _S1037) * 0.3333333432674408f) * _S1017 - _S1038 * 0.0f) / (_S1017 * _S1017);
        k_17 = _S1038 / _S1017;
        s_diff_k_6 = _S1039;
    }
    else
    {
        float _S1040 = (_S1036.differential_0 * _S1033.primal_0 - _S1036.primal_0 * _S1033.differential_0) / (_S1033.primal_0 * _S1033.primal_0);
        k_17 = _S1036.primal_0 / _S1033.primal_0;
        s_diff_k_6 = _S1040;
    }
    float2  _S1041 = _S1013 * make_float2 (k_17);
    float2  _S1042 = _S1031 * make_float2 (k_17) + make_float2 (s_diff_k_6) * _S1013;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1043;
    (&_S1043)->primal_0 = _S1041;
    (&_S1043)->differential_0 = _S1042;
    FixedArray<float, 58>  _S1044 = dist_coeffs_42;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1045 = s_fwd_DistKBPolarSpline_distort_0(&_S1043, &_S1044);
    float _S1046 = _S1045.differential_0.y * fy_11;
    *&(((&J_11)->rows + (int(0)))->y) = _S1045.differential_0.x * fx_11;
    *&(((&J_11)->rows + (int(1)))->y) = _S1046;
    float2  _S1047 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1048;
    (&_S1048)->primal_0 = _S1013;
    (&_S1048)->differential_0 = _S1047;
    DiffPair_float_0 _S1049 = s_fwd_length_impl_0(&_S1048);
    DiffPair_float_0 _S1050;
    (&_S1050)->primal_0 = _S1049.primal_0;
    (&_S1050)->differential_0 = _S1049.differential_0;
    DiffPair_float_0 _S1051;
    (&_S1051)->primal_0 = _S1017;
    (&_S1051)->differential_0 = 1.0f;
    DiffPair_float_0 _S1052 = _d_atan2_0(&_S1050, &_S1051);
    if((_S1052.primal_0) < 0.00100000004749745f)
    {
        float _S1053 = _S1052.differential_0 * _S1052.primal_0;
        float _S1054 = 1.0f - _S1052.primal_0 * _S1052.primal_0 / 3.0f;
        float _S1055 = ((0.0f - (_S1053 + _S1053) * 0.3333333432674408f) * _S1017 - _S1054) / (_S1017 * _S1017);
        k_17 = _S1054 / _S1017;
        s_diff_k_6 = _S1055;
    }
    else
    {
        float _S1056 = (_S1052.differential_0 * _S1049.primal_0 - _S1052.primal_0 * _S1049.differential_0) / (_S1049.primal_0 * _S1049.primal_0);
        k_17 = _S1052.primal_0 / _S1049.primal_0;
        s_diff_k_6 = _S1056;
    }
    float2  _S1057 = _S1013 * make_float2 (k_17);
    float2  _S1058 = _S1047 * make_float2 (k_17) + make_float2 (s_diff_k_6) * _S1013;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1059;
    (&_S1059)->primal_0 = _S1057;
    (&_S1059)->differential_0 = _S1058;
    FixedArray<float, 58>  _S1060 = dist_coeffs_42;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1061 = s_fwd_DistKBPolarSpline_distort_0(&_S1059, &_S1060);
    float _S1062 = _S1061.differential_0.y * fy_11;
    *&(((&J_11)->rows + (int(0)))->z) = _S1061.differential_0.x * fx_11;
    *&(((&J_11)->rows + (int(1)))->z) = _S1062;
    return J_11;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_polar(float3  p_view_25, float4  intrins_25, FixedArray<float, 58>  dist_coeffs_43)
{
    Matrix<float, 2, 3>  J_12;
    float2  _S1063 = float2 {p_view_25.x, p_view_25.y};
    float2  _S1064 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1065;
    (&_S1065)->primal_0 = _S1063;
    (&_S1065)->differential_0 = _S1064;
    DiffPair_float_0 _S1066 = s_fwd_length_impl_0(&_S1065);
    float _S1067 = p_view_25.z;
    DiffPair_float_0 _S1068;
    (&_S1068)->primal_0 = _S1066.primal_0;
    (&_S1068)->differential_0 = _S1066.differential_0;
    DiffPair_float_0 _S1069;
    (&_S1069)->primal_0 = _S1067;
    (&_S1069)->differential_0 = 0.0f;
    DiffPair_float_0 _S1070 = _d_atan2_0(&_S1068, &_S1069);
    float k_18;
    float s_diff_k_7;
    if((_S1066.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1071 = _S1070.differential_0 * _S1070.primal_0;
        float _S1072 = 1.0f - _S1070.primal_0 * _S1070.primal_0 / 24.0f;
        float _S1073 = ((0.0f - (_S1071 + _S1071) * 0.0416666679084301f) * _S1067 - _S1072 * 0.0f) / (_S1067 * _S1067);
        k_18 = _S1072 / _S1067;
        s_diff_k_7 = _S1073;
    }
    else
    {
        float _S1074 = _S1070.differential_0 * 0.5f;
        DiffPair_float_0 _S1075;
        (&_S1075)->primal_0 = 0.5f * _S1070.primal_0;
        (&_S1075)->differential_0 = _S1074;
        DiffPair_float_0 _S1076 = _d_sin_0(&_S1075);
        float _S1077 = 2.0f * _S1076.primal_0;
        float _S1078 = (_S1076.differential_0 * 2.0f * _S1066.primal_0 - _S1077 * _S1066.differential_0) / (_S1066.primal_0 * _S1066.primal_0);
        k_18 = _S1077 / _S1066.primal_0;
        s_diff_k_7 = _S1078;
    }
    float2  _S1079 = _S1063 * make_float2 (k_18);
    float2  _S1080 = _S1064 * make_float2 (k_18) + make_float2 (s_diff_k_7) * _S1063;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1081;
    (&_S1081)->primal_0 = _S1079;
    (&_S1081)->differential_0 = _S1080;
    FixedArray<float, 58>  _S1082 = dist_coeffs_43;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1083 = s_fwd_DistKBPolarSpline_distort_0(&_S1081, &_S1082);
    float fx_12 = intrins_25.x;
    float fy_12 = intrins_25.y;
    float _S1084 = _S1083.differential_0.y * fy_12;
    *&(((&J_12)->rows + (int(0)))->x) = _S1083.differential_0.x * fx_12;
    *&(((&J_12)->rows + (int(1)))->x) = _S1084;
    float2  _S1085 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1086;
    (&_S1086)->primal_0 = _S1063;
    (&_S1086)->differential_0 = _S1085;
    DiffPair_float_0 _S1087 = s_fwd_length_impl_0(&_S1086);
    DiffPair_float_0 _S1088;
    (&_S1088)->primal_0 = _S1087.primal_0;
    (&_S1088)->differential_0 = _S1087.differential_0;
    DiffPair_float_0 _S1089;
    (&_S1089)->primal_0 = _S1067;
    (&_S1089)->differential_0 = 0.0f;
    DiffPair_float_0 _S1090 = _d_atan2_0(&_S1088, &_S1089);
    if((_S1087.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1091 = _S1090.differential_0 * _S1090.primal_0;
        float _S1092 = 1.0f - _S1090.primal_0 * _S1090.primal_0 / 24.0f;
        float _S1093 = ((0.0f - (_S1091 + _S1091) * 0.0416666679084301f) * _S1067 - _S1092 * 0.0f) / (_S1067 * _S1067);
        k_18 = _S1092 / _S1067;
        s_diff_k_7 = _S1093;
    }
    else
    {
        float _S1094 = _S1090.differential_0 * 0.5f;
        DiffPair_float_0 _S1095;
        (&_S1095)->primal_0 = 0.5f * _S1090.primal_0;
        (&_S1095)->differential_0 = _S1094;
        DiffPair_float_0 _S1096 = _d_sin_0(&_S1095);
        float _S1097 = 2.0f * _S1096.primal_0;
        float _S1098 = (_S1096.differential_0 * 2.0f * _S1087.primal_0 - _S1097 * _S1087.differential_0) / (_S1087.primal_0 * _S1087.primal_0);
        k_18 = _S1097 / _S1087.primal_0;
        s_diff_k_7 = _S1098;
    }
    float2  _S1099 = _S1063 * make_float2 (k_18);
    float2  _S1100 = _S1085 * make_float2 (k_18) + make_float2 (s_diff_k_7) * _S1063;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1101;
    (&_S1101)->primal_0 = _S1099;
    (&_S1101)->differential_0 = _S1100;
    FixedArray<float, 58>  _S1102 = dist_coeffs_43;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1103 = s_fwd_DistKBPolarSpline_distort_0(&_S1101, &_S1102);
    float _S1104 = _S1103.differential_0.y * fy_12;
    *&(((&J_12)->rows + (int(0)))->y) = _S1103.differential_0.x * fx_12;
    *&(((&J_12)->rows + (int(1)))->y) = _S1104;
    float2  _S1105 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1106;
    (&_S1106)->primal_0 = _S1063;
    (&_S1106)->differential_0 = _S1105;
    DiffPair_float_0 _S1107 = s_fwd_length_impl_0(&_S1106);
    DiffPair_float_0 _S1108;
    (&_S1108)->primal_0 = _S1107.primal_0;
    (&_S1108)->differential_0 = _S1107.differential_0;
    DiffPair_float_0 _S1109;
    (&_S1109)->primal_0 = _S1067;
    (&_S1109)->differential_0 = 1.0f;
    DiffPair_float_0 _S1110 = _d_atan2_0(&_S1108, &_S1109);
    if((_S1107.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1111 = _S1110.differential_0 * _S1110.primal_0;
        float _S1112 = 1.0f - _S1110.primal_0 * _S1110.primal_0 / 24.0f;
        float _S1113 = ((0.0f - (_S1111 + _S1111) * 0.0416666679084301f) * _S1067 - _S1112) / (_S1067 * _S1067);
        k_18 = _S1112 / _S1067;
        s_diff_k_7 = _S1113;
    }
    else
    {
        float _S1114 = _S1110.differential_0 * 0.5f;
        DiffPair_float_0 _S1115;
        (&_S1115)->primal_0 = 0.5f * _S1110.primal_0;
        (&_S1115)->differential_0 = _S1114;
        DiffPair_float_0 _S1116 = _d_sin_0(&_S1115);
        float _S1117 = 2.0f * _S1116.primal_0;
        float _S1118 = (_S1116.differential_0 * 2.0f * _S1107.primal_0 - _S1117 * _S1107.differential_0) / (_S1107.primal_0 * _S1107.primal_0);
        k_18 = _S1117 / _S1107.primal_0;
        s_diff_k_7 = _S1118;
    }
    float2  _S1119 = _S1063 * make_float2 (k_18);
    float2  _S1120 = _S1105 * make_float2 (k_18) + make_float2 (s_diff_k_7) * _S1063;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1121;
    (&_S1121)->primal_0 = _S1119;
    (&_S1121)->differential_0 = _S1120;
    FixedArray<float, 58>  _S1122 = dist_coeffs_43;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1123 = s_fwd_DistKBPolarSpline_distort_0(&_S1121, &_S1122);
    float _S1124 = _S1123.differential_0.y * fy_12;
    *&(((&J_12)->rows + (int(0)))->z) = _S1123.differential_0.x * fx_12;
    *&(((&J_12)->rows + (int(1)))->z) = _S1124;
    return J_12;
}

inline __device__ float2  distort_point_polar(float2  uv_41, int camera_model_12, FixedArray<float, 58>  dist_coeffs_44)
{
    float2  _S1125;
    for(;;)
    {
        if(camera_model_12 == int(3))
        {
            _S1125 = uv_41;
            break;
        }
        float k_19;
        if(camera_model_12 == int(1))
        {
            float r_38 = length_0(uv_41);
            float theta_18 = (F32_atan((r_38)));
            if(r_38 < 0.00100000004749745f)
            {
                k_19 = 1.0f - theta_18 * theta_18 / 6.0f;
            }
            else
            {
                k_19 = theta_18 / r_38;
            }
            _S1125 = uv_41 * make_float2 (k_19);
        }
        else
        {
            if(camera_model_12 == int(2))
            {
                float r_39 = length_0(uv_41);
                float theta_19 = (F32_atan((r_39)));
                if(r_39 < 0.00100000004749745f)
                {
                    k_19 = 1.0f - theta_19 * theta_19 / 24.0f;
                }
                else
                {
                    k_19 = 2.0f * (F32_sin((0.5f * theta_19))) / r_39;
                }
                _S1125 = uv_41 * make_float2 (k_19);
            }
            else
            {
                _S1125 = uv_41;
            }
        }
        FixedArray<float, 58>  _S1126 = dist_coeffs_44;
        float2  _S1127 = DistKBPolarSpline_distort_0(_S1125, &_S1126);
        _S1125 = _S1127;
        break;
    }
    return _S1125;
}

inline __device__ bool undistort_point_polar(float2  uv_42, int camera_model_13, FixedArray<float, 58>  dist_coeffs_45, float2  * uv_undist_7)
{
    bool _S1128;
    for(;;)
    {
        *uv_undist_7 = make_float2 (0.0f);
        if(camera_model_13 == int(3))
        {
            float lon_6 = uv_42.x;
            float lat_9 = uv_42.y;
            float cl_9 = (F32_cos((lat_9)));
            *uv_undist_7 = make_float2 (cl_9 * (F32_sin((lon_6))), (F32_sin((lat_9)))) / make_float2 ((F32_max((cl_9 * (F32_cos((lon_6)))), (9.999999960041972e-13f))));
            _S1128 = true;
            break;
        }
        FixedArray<float, 58>  _S1129 = dist_coeffs_45;
        float2  uv_u_9;
        bool _S1130 = undistort_point_3(uv_42, &_S1129, int(8), &uv_u_9);
        if(!_S1130)
        {
            _S1128 = false;
            break;
        }
        float2  _S1131 = uv_u_9;
        float3  raydir_9;
        if(camera_model_13 == int(1))
        {
            float r_40 = length_0(_S1131);
            float s_9;
            if(r_40 < 0.00100000004749745f)
            {
                s_9 = 1.0f - r_40 * r_40 / 6.0f;
            }
            else
            {
                s_9 = (F32_sin((r_40))) / r_40;
            }
            raydir_9 = make_float3 ((_S1131 * make_float2 (s_9)).x, (_S1131 * make_float2 (s_9)).y, (F32_cos((r_40))));
        }
        else
        {
            if(camera_model_13 == int(2))
            {
                float r_41 = length_0(_S1131);
                raydir_9 = make_float3 ((_S1131 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_41 * r_41)))))))).x, (_S1131 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_41 * r_41)))))))).y, 1.0f - 0.5f * r_41 * r_41);
            }
            else
            {
                raydir_9 = make_float3 (_S1131.x, _S1131.y, 1.0f);
            }
        }
        *uv_undist_7 = float2 {raydir_9.x, raydir_9.y} / make_float2 ((F32_max((raydir_9.z), (9.999999960041972e-13f))));
        _S1128 = true;
        break;
    }
    return _S1128;
}

inline __device__ bool unproject_point_polar(float2  uv_43, int camera_model_14, FixedArray<float, 58>  dist_coeffs_46, float3  * raydir_10)
{
    bool _S1132;
    for(;;)
    {
        int3  _S1133 = make_int3 (int(0));
        float3  _S1134 = make_float3 ((float)_S1133.x, (float)_S1133.y, (float)_S1133.z);
        *raydir_10 = _S1134;
        if(camera_model_14 == int(3))
        {
            float lon_7 = uv_43.x;
            float lat_10 = uv_43.y;
            float cl_10 = (F32_cos((lat_10)));
            *raydir_10 = make_float3 (cl_10 * (F32_sin((lon_7))), (F32_sin((lat_10))), cl_10 * (F32_cos((lon_7))));
            _S1132 = true;
            break;
        }
        FixedArray<float, 58>  _S1135 = dist_coeffs_46;
        float2  uv_u_10;
        bool _S1136 = undistort_point_3(uv_43, &_S1135, int(8), &uv_u_10);
        if(!_S1136)
        {
            _S1132 = false;
            break;
        }
        float2  _S1137 = uv_u_10;
        if(camera_model_14 == int(1))
        {
            float r_42 = length_0(_S1137);
            float s_10;
            if(r_42 < 0.00100000004749745f)
            {
                s_10 = 1.0f - r_42 * r_42 / 6.0f;
            }
            else
            {
                s_10 = (F32_sin((r_42))) / r_42;
            }
            *raydir_10 = make_float3 ((_S1137 * make_float2 (s_10)).x, (_S1137 * make_float2 (s_10)).y, (F32_cos((r_42))));
        }
        else
        {
            if(camera_model_14 == int(2))
            {
                float r_43 = length_0(_S1137);
                *raydir_10 = make_float3 ((_S1137 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_43 * r_43)))))))).x, (_S1137 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_43 * r_43)))))))).y, 1.0f - 0.5f * r_43 * r_43);
            }
            else
            {
                *raydir_10 = make_float3 (_S1137.x, _S1137.y, 1.0f);
            }
        }
        _S1132 = true;
        break;
    }
    return _S1132;
}

inline __device__ bool generate_ray_polar(float2  uv_44, int camera_model_15, FixedArray<float, 58>  dist_coeffs_47, float3  * raydir_11)
{
    bool _S1138;
    for(;;)
    {
        if(camera_model_15 == int(3))
        {
            float _S1139 = uv_44.x;
            if((F32_abs((_S1139))) > 3.14159274101257324f)
            {
                _S1138 = true;
            }
            else
            {
                _S1138 = (F32_abs((uv_44.y))) > 1.57079637050628662f;
            }
            if(_S1138)
            {
                int3  _S1140 = make_int3 (int(0));
                float3  _S1141 = make_float3 ((float)_S1140.x, (float)_S1140.y, (float)_S1140.z);
                *raydir_11 = _S1141;
                _S1138 = false;
                break;
            }
            float lat_11 = uv_44.y;
            float cl_11 = (F32_cos((lat_11)));
            *raydir_11 = make_float3 (cl_11 * (F32_sin((_S1139))), (F32_sin((lat_11))), cl_11 * (F32_cos((_S1139))));
            _S1138 = true;
            break;
        }
        FixedArray<float, 58>  _S1142 = dist_coeffs_47;
        float2  uv_u_11;
        bool _S1143 = undistort_point_3(uv_44, &_S1142, int(8), &uv_u_11);
        if(!_S1143)
        {
            int3  _S1144 = make_int3 (int(0));
            float3  _S1145 = make_float3 ((float)_S1144.x, (float)_S1144.y, (float)_S1144.z);
            *raydir_11 = _S1145;
            _S1138 = false;
            break;
        }
        float2  _S1146 = uv_u_11;
        if(camera_model_15 == int(1))
        {
            float r_44 = length_0(_S1146);
            if(r_44 >= 3.14159274101257324f)
            {
                int3  _S1147 = make_int3 (int(0));
                float3  _S1148 = make_float3 ((float)_S1147.x, (float)_S1147.y, (float)_S1147.z);
                *raydir_11 = _S1148;
                _S1138 = false;
                break;
            }
            float s_11;
            if(r_44 < 0.00100000004749745f)
            {
                s_11 = 1.0f - r_44 * r_44 / 6.0f;
            }
            else
            {
                s_11 = (F32_sin((r_44))) / r_44;
            }
            *raydir_11 = make_float3 ((_S1146 * make_float2 (s_11)).x, (_S1146 * make_float2 (s_11)).y, (F32_cos((r_44))));
        }
        else
        {
            if(camera_model_15 == int(2))
            {
                float r_45 = length_0(_S1146);
                if(r_45 >= 2.0f)
                {
                    int3  _S1149 = make_int3 (int(0));
                    float3  _S1150 = make_float3 ((float)_S1149.x, (float)_S1149.y, (float)_S1149.z);
                    *raydir_11 = _S1150;
                    _S1138 = false;
                    break;
                }
                *raydir_11 = make_float3 ((_S1146 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_45 * r_45)))))))).x, (_S1146 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_45 * r_45)))))))).y, 1.0f - 0.5f * r_45 * r_45);
            }
            else
            {
                *raydir_11 = make_float3 (_S1146.x, _S1146.y, 1.0f);
            }
        }
        *raydir_11 = normalize_0(*raydir_11);
        _S1138 = true;
        break;
    }
    return _S1138;
}

inline __device__ void _d_mul_1(DiffPair_vectorx3Cfloatx2C3x3E_0 * left_4, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * right_4, float3  dOut_3)
{
    float _S1151 = (*right_4).primal_0.rows[int(0)].x * dOut_3.x;
    Matrix<float, 3, 3>  right_d_result_2;
    *&(((&right_d_result_2)->rows + (int(0)))->x) = (*left_4).primal_0.x * dOut_3.x;
    float sum_10 = _S1151 + (*right_4).primal_0.rows[int(0)].y * dOut_3.y;
    *&(((&right_d_result_2)->rows + (int(0)))->y) = (*left_4).primal_0.x * dOut_3.y;
    float sum_11 = sum_10 + (*right_4).primal_0.rows[int(0)].z * dOut_3.z;
    *&(((&right_d_result_2)->rows + (int(0)))->z) = (*left_4).primal_0.x * dOut_3.z;
    float3  left_d_result_2;
    *&((&left_d_result_2)->x) = sum_11;
    float _S1152 = (*right_4).primal_0.rows[int(1)].x * dOut_3.x;
    *&(((&right_d_result_2)->rows + (int(1)))->x) = (*left_4).primal_0.y * dOut_3.x;
    float sum_12 = _S1152 + (*right_4).primal_0.rows[int(1)].y * dOut_3.y;
    *&(((&right_d_result_2)->rows + (int(1)))->y) = (*left_4).primal_0.y * dOut_3.y;
    float sum_13 = sum_12 + (*right_4).primal_0.rows[int(1)].z * dOut_3.z;
    *&(((&right_d_result_2)->rows + (int(1)))->z) = (*left_4).primal_0.y * dOut_3.z;
    *&((&left_d_result_2)->y) = sum_13;
    float _S1153 = (*right_4).primal_0.rows[int(2)].x * dOut_3.x;
    *&(((&right_d_result_2)->rows + (int(2)))->x) = (*left_4).primal_0.z * dOut_3.x;
    float sum_14 = _S1153 + (*right_4).primal_0.rows[int(2)].y * dOut_3.y;
    *&(((&right_d_result_2)->rows + (int(2)))->y) = (*left_4).primal_0.z * dOut_3.y;
    float sum_15 = sum_14 + (*right_4).primal_0.rows[int(2)].z * dOut_3.z;
    *&(((&right_d_result_2)->rows + (int(2)))->z) = (*left_4).primal_0.z * dOut_3.z;
    *&((&left_d_result_2)->z) = sum_15;
    left_4->primal_0 = (*left_4).primal_0;
    left_4->differential_0 = left_d_result_2;
    right_4->primal_0 = (*right_4).primal_0;
    right_4->differential_0 = right_d_result_2;
    return;
}

inline __device__ float3  mul_3(float3  left_5, Matrix<float, 3, 3>  right_5)
{
    float3  result_8;
    int j_1 = int(0);
    for(;;)
    {
        if(j_1 < int(3))
        {
        }
        else
        {
            break;
        }
        int i_7 = int(0);
        float sum_16 = 0.0f;
        for(;;)
        {
            if(i_7 < int(3))
            {
            }
            else
            {
                break;
            }
            float sum_17 = sum_16 + _slang_vector_get_element(left_5, i_7) * _slang_vector_get_element(right_5.rows[i_7], j_1);
            i_7 = i_7 + int(1);
            sum_16 = sum_17;
        }
        *_slang_vector_get_element_ptr(&result_8, j_1) = sum_16;
        j_1 = j_1 + int(1);
    }
    return result_8;
}

inline __device__ float3  transform_ray_o(Matrix<float, 3, 3>  R_0, float3  t_1)
{
    return - mul_3(t_1, R_0);
}

inline __device__ float3  transform_ray_d(Matrix<float, 3, 3>  R_1, float3  raydir_12)
{
    return mul_3(raydir_12, R_1);
}

inline __device__ float3  undo_transform_ray_d(Matrix<float, 3, 3>  R_2, float3  raydir_13)
{
    return mul_3(raydir_13, transpose_0(R_2));
}

inline __device__ void s_bwd_prop_mul_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1154, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1155, float3  _S1156)
{
    _d_mul_1(_S1154, _S1155, _S1156);
    return;
}

inline __device__ void s_bwd_prop_transform_ray_o_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * dpR_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpt_1, float3  _s_dOut_0)
{
    float3  _S1157 = - _s_dOut_0;
    float3  _S1158 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1159;
    (&_S1159)->primal_0 = (*dpt_1).primal_0;
    (&_S1159)->differential_0 = _S1158;
    Matrix<float, 3, 3>  _S1160 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1161;
    (&_S1161)->primal_0 = (*dpR_0).primal_0;
    (&_S1161)->differential_0 = _S1160;
    s_bwd_prop_mul_0(&_S1159, &_S1161, _S1157);
    dpt_1->primal_0 = (*dpt_1).primal_0;
    dpt_1->differential_0 = _S1159.differential_0;
    dpR_0->primal_0 = (*dpR_0).primal_0;
    dpR_0->differential_0 = _S1161.differential_0;
    return;
}

inline __device__ void s_bwd_transform_ray_o_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1162, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1163, float3  _S1164)
{
    s_bwd_prop_transform_ray_o_0(_S1162, _S1163, _S1164);
    return;
}

inline __device__ void transform_ray_o_vjp(Matrix<float, 3, 3>  R_3, float3  t_2, float3  v_ray_o_0, Matrix<float, 3, 3>  * v_R_0, float3  * v_t_0)
{
    Matrix<float, 3, 3>  _S1165 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_R_0;
    (&dp_R_0)->primal_0 = R_3;
    (&dp_R_0)->differential_0 = _S1165;
    float3  _S1166 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_t_0;
    (&dp_t_0)->primal_0 = t_2;
    (&dp_t_0)->differential_0 = _S1166;
    s_bwd_transform_ray_o_0(&dp_R_0, &dp_t_0, v_ray_o_0);
    *v_R_0 = dp_R_0.differential_0;
    *v_t_0 = dp_t_0.differential_0;
    return;
}

inline __device__ void s_bwd_prop_transform_ray_d_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * dpR_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpraydir_0, float3  _s_dOut_1)
{
    float3  _S1167 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1168;
    (&_S1168)->primal_0 = (*dpraydir_0).primal_0;
    (&_S1168)->differential_0 = _S1167;
    Matrix<float, 3, 3>  _S1169 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1170;
    (&_S1170)->primal_0 = (*dpR_1).primal_0;
    (&_S1170)->differential_0 = _S1169;
    s_bwd_prop_mul_0(&_S1168, &_S1170, _s_dOut_1);
    dpraydir_0->primal_0 = (*dpraydir_0).primal_0;
    dpraydir_0->differential_0 = _S1168.differential_0;
    dpR_1->primal_0 = (*dpR_1).primal_0;
    dpR_1->differential_0 = _S1170.differential_0;
    return;
}

inline __device__ void s_bwd_transform_ray_d_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1171, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1172, float3  _S1173)
{
    s_bwd_prop_transform_ray_d_0(_S1171, _S1172, _S1173);
    return;
}

inline __device__ void transform_ray_d_vjp(Matrix<float, 3, 3>  R_4, float3  raydir_14, float3  v_ray_d_0, Matrix<float, 3, 3>  * v_R_1, float3  * v_raydir_0)
{
    Matrix<float, 3, 3>  _S1174 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_R_1;
    (&dp_R_1)->primal_0 = R_4;
    (&dp_R_1)->differential_0 = _S1174;
    float3  _S1175 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_raydir_0;
    (&dp_raydir_0)->primal_0 = raydir_14;
    (&dp_raydir_0)->differential_0 = _S1175;
    s_bwd_transform_ray_d_0(&dp_R_1, &dp_raydir_0, v_ray_d_0);
    *v_R_1 = dp_R_1.differential_0;
    *v_raydir_0 = dp_raydir_0.differential_0;
    return;
}

inline __device__ void _d_exp_0(DiffPair_float_0 * dpx_6, float dOut_4)
{
    float _S1176 = (F32_exp(((*dpx_6).primal_0))) * dOut_4;
    dpx_6->primal_0 = (*dpx_6).primal_0;
    dpx_6->differential_0 = _S1176;
    return;
}

inline __device__ float3  exp_0(float3  x_13)
{
    float3  result_9;
    int i_8 = int(0);
    for(;;)
    {
        if(i_8 < int(3))
        {
        }
        else
        {
            break;
        }
        *_slang_vector_get_element_ptr(&result_9, i_8) = (F32_exp((_slang_vector_get_element(x_13, i_8))));
        i_8 = i_8 + int(1);
    }
    return result_9;
}

inline __device__ void _d_exp_vector_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_7, float3  dOut_5)
{
    float3  _S1177 = exp_0((*dpx_7).primal_0) * dOut_5;
    dpx_7->primal_0 = (*dpx_7).primal_0;
    dpx_7->differential_0 = _S1177;
    return;
}

inline __device__ Matrix<float, 3, 3>  compute_3dgut_iscl_rot(float4  quat_5, float3  scale_4)
{
    float x_14 = quat_5.y;
    float x2_5 = x_14 * x_14;
    float y2_5 = quat_5.z * quat_5.z;
    float z2_5 = quat_5.w * quat_5.w;
    float xy_5 = quat_5.y * quat_5.z;
    float xz_5 = quat_5.y * quat_5.w;
    float yz_5 = quat_5.z * quat_5.w;
    float wx_5 = quat_5.x * quat_5.y;
    float wy_5 = quat_5.x * quat_5.z;
    float wz_5 = quat_5.x * quat_5.w;
    float3  _S1178 = exp_0(- scale_4);
    return mul_1(makeMatrix<float, 3, 3> (_S1178.x, 0.0f, 0.0f, 0.0f, _S1178.y, 0.0f, 0.0f, 0.0f, _S1178.z), transpose_0(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_5 + z2_5), 2.0f * (xy_5 + wz_5), 2.0f * (xz_5 - wy_5), 2.0f * (xy_5 - wz_5), 1.0f - 2.0f * (x2_5 + z2_5), 2.0f * (yz_5 + wx_5), 2.0f * (xz_5 + wy_5), 2.0f * (yz_5 - wx_5), 1.0f - 2.0f * (x2_5 + y2_5)))));
}

struct DiffPair_vectorx3Cfloatx2C4x3E_0
{
    float4  primal_0;
    float4  differential_0;
};

inline __device__ float3  s_primal_ctx_exp_0(float3  _S1179)
{
    return exp_0(_S1179);
}

inline __device__ void s_bwd_prop_mul_1(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1180, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1181, Matrix<float, 3, 3>  _S1182)
{
    mul_0(_S1180, _S1181, _S1182);
    return;
}

inline __device__ void s_bwd_prop_exp_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1183, float3  _S1184)
{
    _d_exp_vector_0(_S1183, _S1184);
    return;
}

inline __device__ void s_bwd_prop_compute_3dgut_iscl_rot_0(DiffPair_vectorx3Cfloatx2C4x3E_0 * dpquat_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpscale_0, Matrix<float, 3, 3>  _s_dOut_2)
{
    float _S1185 = (*dpquat_0).primal_0.y;
    float x2_6 = _S1185 * _S1185;
    float y2_6 = (*dpquat_0).primal_0.z * (*dpquat_0).primal_0.z;
    float z2_6 = (*dpquat_0).primal_0.w * (*dpquat_0).primal_0.w;
    float xy_6 = (*dpquat_0).primal_0.y * (*dpquat_0).primal_0.z;
    float xz_6 = (*dpquat_0).primal_0.y * (*dpquat_0).primal_0.w;
    float yz_6 = (*dpquat_0).primal_0.z * (*dpquat_0).primal_0.w;
    float wx_6 = (*dpquat_0).primal_0.x * (*dpquat_0).primal_0.y;
    float wy_6 = (*dpquat_0).primal_0.x * (*dpquat_0).primal_0.z;
    float wz_6 = (*dpquat_0).primal_0.x * (*dpquat_0).primal_0.w;
    float3  _S1186 = - (*dpscale_0).primal_0;
    float3  _S1187 = s_primal_ctx_exp_0(_S1186);
    Matrix<float, 3, 3>  _S1188 = transpose_0(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_6 + z2_6), 2.0f * (xy_6 + wz_6), 2.0f * (xz_6 - wy_6), 2.0f * (xy_6 - wz_6), 1.0f - 2.0f * (x2_6 + z2_6), 2.0f * (yz_6 + wx_6), 2.0f * (xz_6 + wy_6), 2.0f * (yz_6 - wx_6), 1.0f - 2.0f * (x2_6 + y2_6))));
    Matrix<float, 3, 3>  _S1189 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1190;
    (&_S1190)->primal_0 = makeMatrix<float, 3, 3> (_S1187.x, 0.0f, 0.0f, 0.0f, _S1187.y, 0.0f, 0.0f, 0.0f, _S1187.z);
    (&_S1190)->differential_0 = _S1189;
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1191;
    (&_S1191)->primal_0 = _S1188;
    (&_S1191)->differential_0 = _S1189;
    s_bwd_prop_mul_1(&_S1190, &_S1191, _s_dOut_2);
    Matrix<float, 3, 3>  _S1192 = transpose_0(_S1191.differential_0);
    float3  _S1193 = make_float3 (_S1190.differential_0.rows[int(0)].x, _S1190.differential_0.rows[int(1)].y, _S1190.differential_0.rows[int(2)].z);
    float3  _S1194 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1195;
    (&_S1195)->primal_0 = _S1186;
    (&_S1195)->differential_0 = _S1194;
    s_bwd_prop_exp_0(&_S1195, _S1193);
    float3  _S1196 = - _S1195.differential_0;
    Matrix<float, 3, 3>  _S1197 = transpose_0(_S1192);
    float _S1198 = 2.0f * - _S1197.rows[int(2)].z;
    float _S1199 = 2.0f * _S1197.rows[int(2)].y;
    float _S1200 = 2.0f * _S1197.rows[int(2)].x;
    float _S1201 = 2.0f * _S1197.rows[int(1)].z;
    float _S1202 = 2.0f * - _S1197.rows[int(1)].y;
    float _S1203 = 2.0f * _S1197.rows[int(1)].x;
    float _S1204 = 2.0f * _S1197.rows[int(0)].z;
    float _S1205 = 2.0f * _S1197.rows[int(0)].y;
    float _S1206 = 2.0f * - _S1197.rows[int(0)].x;
    float _S1207 = - _S1203 + _S1205;
    float _S1208 = _S1200 + - _S1204;
    float _S1209 = - _S1199 + _S1201;
    float _S1210 = _S1199 + _S1201;
    float _S1211 = _S1200 + _S1204;
    float _S1212 = _S1203 + _S1205;
    float _S1213 = (*dpquat_0).primal_0.w * (_S1202 + _S1206);
    float _S1214 = (*dpquat_0).primal_0.z * (_S1198 + _S1206);
    float _S1215 = (*dpquat_0).primal_0.y * (_S1198 + _S1202);
    float _S1216 = (*dpquat_0).primal_0.x * _S1207 + (*dpquat_0).primal_0.z * _S1210 + (*dpquat_0).primal_0.y * _S1211 + _S1213 + _S1213;
    float _S1217 = (*dpquat_0).primal_0.x * _S1208 + (*dpquat_0).primal_0.w * _S1210 + (*dpquat_0).primal_0.y * _S1212 + _S1214 + _S1214;
    float _S1218 = (*dpquat_0).primal_0.x * _S1209 + (*dpquat_0).primal_0.w * _S1211 + (*dpquat_0).primal_0.z * _S1212 + _S1215 + _S1215;
    float _S1219 = (*dpquat_0).primal_0.w * _S1207 + (*dpquat_0).primal_0.z * _S1208 + (*dpquat_0).primal_0.y * _S1209;
    dpscale_0->primal_0 = (*dpscale_0).primal_0;
    dpscale_0->differential_0 = _S1196;
    float4  _S1220 = make_float4 (0.0f);
    *&((&_S1220)->w) = _S1216;
    *&((&_S1220)->z) = _S1217;
    *&((&_S1220)->y) = _S1218;
    *&((&_S1220)->x) = _S1219;
    dpquat_0->primal_0 = (*dpquat_0).primal_0;
    dpquat_0->differential_0 = _S1220;
    return;
}

inline __device__ void s_bwd_compute_3dgut_iscl_rot_0(DiffPair_vectorx3Cfloatx2C4x3E_0 * _S1221, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1222, Matrix<float, 3, 3>  _S1223)
{
    s_bwd_prop_compute_3dgut_iscl_rot_0(_S1221, _S1222, _S1223);
    return;
}

inline __device__ void compute_3dgut_iscl_rot_vjp(float4  quat_6, float3  scale_5, Matrix<float, 3, 3>  v_iscl_rot_0, float4  * v_quat_0, float3  * v_scale_0)
{
    float4  _S1224 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_quat_0;
    (&dp_quat_0)->primal_0 = quat_6;
    (&dp_quat_0)->differential_0 = _S1224;
    float3  _S1225 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_scale_0;
    (&dp_scale_0)->primal_0 = scale_5;
    (&dp_scale_0)->differential_0 = _S1225;
    s_bwd_compute_3dgut_iscl_rot_0(&dp_quat_0, &dp_scale_0, v_iscl_rot_0);
    *v_quat_0 = dp_quat_0.differential_0;
    *v_scale_0 = dp_scale_0.differential_0;
    return;
}

inline __device__ void _d_cross_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * a_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * b_1, float3  dOut_6)
{
    float _S1226 = dOut_6.y;
    float _S1227 = dOut_6.z;
    float _S1228 = dOut_6.x;
    float _S1229 = (*a_1).primal_0.z * _S1226 + - (*a_1).primal_0.y * _S1227;
    float _S1230 = - (*a_1).primal_0.z * _S1228 + (*a_1).primal_0.x * _S1227;
    float _S1231 = (*a_1).primal_0.y * _S1228 + - (*a_1).primal_0.x * _S1226;
    float3  _S1232 = make_float3 (- (*b_1).primal_0.z * _S1226 + (*b_1).primal_0.y * _S1227, (*b_1).primal_0.z * _S1228 + - (*b_1).primal_0.x * _S1227, - (*b_1).primal_0.y * _S1228 + (*b_1).primal_0.x * _S1226);
    a_1->primal_0 = (*a_1).primal_0;
    a_1->differential_0 = _S1232;
    float3  _S1233 = make_float3 (_S1229, _S1230, _S1231);
    b_1->primal_0 = (*b_1).primal_0;
    b_1->differential_0 = _S1233;
    return;
}

inline __device__ float3  cross_0(float3  left_6, float3  right_6)
{
    float _S1234 = left_6.y;
    float _S1235 = right_6.z;
    float _S1236 = left_6.z;
    float _S1237 = right_6.y;
    float _S1238 = right_6.x;
    float _S1239 = left_6.x;
    return make_float3 (_S1234 * _S1235 - _S1236 * _S1237, _S1236 * _S1238 - _S1239 * _S1235, _S1239 * _S1237 - _S1234 * _S1238);
}

inline __device__ float evaluate_alpha_3dgs(float3  mean_0, Matrix<float, 3, 3>  iscl_rot_0, float opacity_0, float3  ray_o_0, float3  ray_d_0)
{
    float3  grd_0 = mul_2(iscl_rot_0, ray_d_0);
    float3  gcrod_0 = cross_0(grd_0, mul_2(iscl_rot_0, ray_o_0 - mean_0));
    return opacity_0 * (F32_exp((-0.5f * dot_1(gcrod_0, gcrod_0) / dot_1(grd_0, grd_0))));
}

inline __device__ float3  s_primal_ctx_mul_0(Matrix<float, 3, 3>  _S1240, float3  _S1241)
{
    return mul_2(_S1240, _S1241);
}

inline __device__ float3  s_primal_ctx_cross_0(float3  _S1242, float3  _S1243)
{
    return cross_0(_S1242, _S1243);
}

inline __device__ float s_primal_ctx_dot_0(float3  _S1244, float3  _S1245)
{
    return dot_1(_S1244, _S1245);
}

inline __device__ float s_primal_ctx_exp_1(float _S1246)
{
    return (F32_exp((_S1246)));
}

inline __device__ void s_bwd_prop_exp_1(DiffPair_float_0 * _S1247, float _S1248)
{
    _d_exp_0(_S1247, _S1248);
    return;
}

inline __device__ void s_bwd_prop_dot_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1249, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1250, float _S1251)
{
    _d_dot_0(_S1249, _S1250, _S1251);
    return;
}

inline __device__ void s_bwd_prop_cross_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1252, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1253, float3  _S1254)
{
    _d_cross_0(_S1252, _S1253, _S1254);
    return;
}

inline __device__ void s_bwd_prop_mul_2(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1255, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1256, float3  _S1257)
{
    _d_mul_0(_S1255, _S1256, _S1257);
    return;
}

inline __device__ void s_bwd_prop_evaluate_alpha_3dgs_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpmean_0, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * dpiscl_rot_0, DiffPair_float_0 * dpopacity_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpray_o_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpray_d_0, float _s_dOut_3)
{
    float3  _S1258 = (*dpray_o_0).primal_0 - (*dpmean_0).primal_0;
    float3  _S1259 = s_primal_ctx_mul_0((*dpiscl_rot_0).primal_0, _S1258);
    float3  _S1260 = s_primal_ctx_mul_0((*dpiscl_rot_0).primal_0, (*dpray_d_0).primal_0);
    float3  _S1261 = s_primal_ctx_cross_0(_S1260, _S1259);
    float _S1262 = -0.5f * s_primal_ctx_dot_0(_S1261, _S1261);
    float _S1263 = s_primal_ctx_dot_0(_S1260, _S1260);
    float _S1264 = _S1262 / _S1263;
    float _S1265 = _S1263 * _S1263;
    float _S1266 = (*dpopacity_0).primal_0 * _s_dOut_3;
    float _S1267 = s_primal_ctx_exp_1(_S1264) * _s_dOut_3;
    DiffPair_float_0 _S1268;
    (&_S1268)->primal_0 = _S1264;
    (&_S1268)->differential_0 = 0.0f;
    s_bwd_prop_exp_1(&_S1268, _S1266);
    float _S1269 = _S1268.differential_0 / _S1265;
    float _S1270 = _S1262 * - _S1269;
    float _S1271 = _S1263 * _S1269;
    float3  _S1272 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1273;
    (&_S1273)->primal_0 = _S1260;
    (&_S1273)->differential_0 = _S1272;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1274;
    (&_S1274)->primal_0 = _S1260;
    (&_S1274)->differential_0 = _S1272;
    s_bwd_prop_dot_0(&_S1273, &_S1274, _S1270);
    float _S1275 = -0.5f * _S1271;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1276;
    (&_S1276)->primal_0 = _S1261;
    (&_S1276)->differential_0 = _S1272;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1277;
    (&_S1277)->primal_0 = _S1261;
    (&_S1277)->differential_0 = _S1272;
    s_bwd_prop_dot_0(&_S1276, &_S1277, _S1275);
    float3  _S1278 = _S1277.differential_0 + _S1276.differential_0;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1279;
    (&_S1279)->primal_0 = _S1260;
    (&_S1279)->differential_0 = _S1272;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1280;
    (&_S1280)->primal_0 = _S1259;
    (&_S1280)->differential_0 = _S1272;
    s_bwd_prop_cross_0(&_S1279, &_S1280, _S1278);
    float3  _S1281 = _S1274.differential_0 + _S1273.differential_0 + _S1279.differential_0;
    Matrix<float, 3, 3>  _S1282 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1283;
    (&_S1283)->primal_0 = (*dpiscl_rot_0).primal_0;
    (&_S1283)->differential_0 = _S1282;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1284;
    (&_S1284)->primal_0 = (*dpray_d_0).primal_0;
    (&_S1284)->differential_0 = _S1272;
    s_bwd_prop_mul_2(&_S1283, &_S1284, _S1281);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1285;
    (&_S1285)->primal_0 = (*dpiscl_rot_0).primal_0;
    (&_S1285)->differential_0 = _S1282;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1286;
    (&_S1286)->primal_0 = _S1258;
    (&_S1286)->differential_0 = _S1272;
    s_bwd_prop_mul_2(&_S1285, &_S1286, _S1280.differential_0);
    float3  _S1287 = - _S1286.differential_0;
    dpray_d_0->primal_0 = (*dpray_d_0).primal_0;
    dpray_d_0->differential_0 = _S1284.differential_0;
    dpray_o_0->primal_0 = (*dpray_o_0).primal_0;
    dpray_o_0->differential_0 = _S1286.differential_0;
    dpopacity_0->primal_0 = (*dpopacity_0).primal_0;
    dpopacity_0->differential_0 = _S1267;
    Matrix<float, 3, 3>  _S1288 = _S1283.differential_0 + _S1285.differential_0;
    dpiscl_rot_0->primal_0 = (*dpiscl_rot_0).primal_0;
    dpiscl_rot_0->differential_0 = _S1288;
    dpmean_0->primal_0 = (*dpmean_0).primal_0;
    dpmean_0->differential_0 = _S1287;
    return;
}

inline __device__ void s_bwd_evaluate_alpha_3dgs_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1289, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1290, DiffPair_float_0 * _S1291, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1292, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1293, float _S1294)
{
    s_bwd_prop_evaluate_alpha_3dgs_0(_S1289, _S1290, _S1291, _S1292, _S1293, _S1294);
    return;
}

inline __device__ void evaluate_alpha_3dgs_vjp(float3  mean_1, Matrix<float, 3, 3>  iscl_rot_1, float opacity_1, float3  ray_o_1, float3  ray_d_1, float v_alpha_0, float3  * v_mean_0, Matrix<float, 3, 3>  * v_iscl_rot_1, float * v_opacity_0, float3  * v_ray_o_1, float3  * v_ray_d_1)
{
    float3  _S1295 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_mean_0;
    (&dp_mean_0)->primal_0 = mean_1;
    (&dp_mean_0)->differential_0 = _S1295;
    Matrix<float, 3, 3>  _S1296 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_iscl_rot_0;
    (&dp_iscl_rot_0)->primal_0 = iscl_rot_1;
    (&dp_iscl_rot_0)->differential_0 = _S1296;
    DiffPair_float_0 dp_opacity_0;
    (&dp_opacity_0)->primal_0 = opacity_1;
    (&dp_opacity_0)->differential_0 = 0.0f;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_o_0;
    (&dp_ray_o_0)->primal_0 = ray_o_1;
    (&dp_ray_o_0)->differential_0 = _S1295;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_d_0;
    (&dp_ray_d_0)->primal_0 = ray_d_1;
    (&dp_ray_d_0)->differential_0 = _S1295;
    s_bwd_evaluate_alpha_3dgs_0(&dp_mean_0, &dp_iscl_rot_0, &dp_opacity_0, &dp_ray_o_0, &dp_ray_d_0, v_alpha_0);
    *v_mean_0 = dp_mean_0.differential_0;
    *v_iscl_rot_1 = dp_iscl_rot_0.differential_0;
    *v_opacity_0 = dp_opacity_0.differential_0;
    *v_ray_o_1 = dp_ray_o_0.differential_0;
    *v_ray_d_1 = dp_ray_d_0.differential_0;
    return;
}

inline __device__ void evaluate_color_3dgs(float3  mean_2, Matrix<float, 3, 3>  iscl_rot_2, float opacity_2, float3  rgb_0, float3  ray_o_2, float3  ray_d_2, float3  * out_rgb_0, float * depth_0)
{
    *out_rgb_0 = rgb_0;
    float3  grd_1 = mul_2(iscl_rot_2, ray_d_2);
    *depth_0 = - dot_1(mul_2(iscl_rot_2, ray_o_2 - mean_2), grd_1) / dot_1(grd_1, grd_1);
    return;
}

inline __device__ void s_bwd_prop_evaluate_color_3dgs_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpmean_1, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * dpiscl_rot_1, DiffPair_float_0 * dpopacity_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * dprgb_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpray_o_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpray_d_1, float3  dpout_rgb_0, float dpdepth_0)
{
    float3  _S1297 = (*dpray_o_1).primal_0 - (*dpmean_1).primal_0;
    float3  _S1298 = s_primal_ctx_mul_0((*dpiscl_rot_1).primal_0, _S1297);
    float3  _S1299 = s_primal_ctx_mul_0((*dpiscl_rot_1).primal_0, (*dpray_d_1).primal_0);
    float _S1300 = s_primal_ctx_dot_0(_S1299, _S1299);
    float _S1301 = dpdepth_0 / (_S1300 * _S1300);
    float _S1302 = - s_primal_ctx_dot_0(_S1298, _S1299) * - _S1301;
    float _S1303 = _S1300 * _S1301;
    float3  _S1304 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1305;
    (&_S1305)->primal_0 = _S1299;
    (&_S1305)->differential_0 = _S1304;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1306;
    (&_S1306)->primal_0 = _S1299;
    (&_S1306)->differential_0 = _S1304;
    s_bwd_prop_dot_0(&_S1305, &_S1306, _S1302);
    float _S1307 = - _S1303;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1308;
    (&_S1308)->primal_0 = _S1298;
    (&_S1308)->differential_0 = _S1304;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1309;
    (&_S1309)->primal_0 = _S1299;
    (&_S1309)->differential_0 = _S1304;
    s_bwd_prop_dot_0(&_S1308, &_S1309, _S1307);
    float3  _S1310 = _S1306.differential_0 + _S1305.differential_0 + _S1309.differential_0;
    Matrix<float, 3, 3>  _S1311 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1312;
    (&_S1312)->primal_0 = (*dpiscl_rot_1).primal_0;
    (&_S1312)->differential_0 = _S1311;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1313;
    (&_S1313)->primal_0 = (*dpray_d_1).primal_0;
    (&_S1313)->differential_0 = _S1304;
    s_bwd_prop_mul_2(&_S1312, &_S1313, _S1310);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S1314;
    (&_S1314)->primal_0 = (*dpiscl_rot_1).primal_0;
    (&_S1314)->differential_0 = _S1311;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S1315;
    (&_S1315)->primal_0 = _S1297;
    (&_S1315)->differential_0 = _S1304;
    s_bwd_prop_mul_2(&_S1314, &_S1315, _S1308.differential_0);
    float3  _S1316 = - _S1315.differential_0;
    dpray_d_1->primal_0 = (*dpray_d_1).primal_0;
    dpray_d_1->differential_0 = _S1313.differential_0;
    dpray_o_1->primal_0 = (*dpray_o_1).primal_0;
    dpray_o_1->differential_0 = _S1315.differential_0;
    dprgb_0->primal_0 = (*dprgb_0).primal_0;
    dprgb_0->differential_0 = dpout_rgb_0;
    dpopacity_1->primal_0 = (*dpopacity_1).primal_0;
    dpopacity_1->differential_0 = 0.0f;
    Matrix<float, 3, 3>  _S1317 = _S1312.differential_0 + _S1314.differential_0;
    dpiscl_rot_1->primal_0 = (*dpiscl_rot_1).primal_0;
    dpiscl_rot_1->differential_0 = _S1317;
    dpmean_1->primal_0 = (*dpmean_1).primal_0;
    dpmean_1->differential_0 = _S1316;
    return;
}

inline __device__ void s_bwd_evaluate_color_3dgs_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1318, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S1319, DiffPair_float_0 * _S1320, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1321, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1322, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1323, float3  _S1324, float _S1325)
{
    s_bwd_prop_evaluate_color_3dgs_0(_S1318, _S1319, _S1320, _S1321, _S1322, _S1323, _S1324, _S1325);
    return;
}

inline __device__ void evaluate_color_3dgs_vjp(float3  mean_3, Matrix<float, 3, 3>  iscl_rot_3, float opacity_3, float3  rgb_1, float3  ray_o_3, float3  ray_d_3, float3  v_out_rgb_0, float v_depth_0, float3  * v_mean_1, Matrix<float, 3, 3>  * v_iscl_rot_2, float * v_opacity_1, float3  * v_rgb_0, float3  * v_ray_o_2, float3  * v_ray_d_2)
{
    float3  _S1326 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_mean_1;
    (&dp_mean_1)->primal_0 = mean_3;
    (&dp_mean_1)->differential_0 = _S1326;
    Matrix<float, 3, 3>  _S1327 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_iscl_rot_1;
    (&dp_iscl_rot_1)->primal_0 = iscl_rot_3;
    (&dp_iscl_rot_1)->differential_0 = _S1327;
    DiffPair_float_0 dp_opacity_1;
    (&dp_opacity_1)->primal_0 = opacity_3;
    (&dp_opacity_1)->differential_0 = 0.0f;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_rgb_0;
    (&dp_rgb_0)->primal_0 = rgb_1;
    (&dp_rgb_0)->differential_0 = _S1326;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_o_1;
    (&dp_ray_o_1)->primal_0 = ray_o_3;
    (&dp_ray_o_1)->differential_0 = _S1326;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_d_1;
    (&dp_ray_d_1)->primal_0 = ray_d_3;
    (&dp_ray_d_1)->differential_0 = _S1326;
    s_bwd_evaluate_color_3dgs_0(&dp_mean_1, &dp_iscl_rot_1, &dp_opacity_1, &dp_rgb_0, &dp_ray_o_1, &dp_ray_d_1, v_out_rgb_0, v_depth_0);
    *v_mean_1 = dp_mean_1.differential_0;
    *v_iscl_rot_2 = dp_iscl_rot_1.differential_0;
    *v_opacity_1 = dp_opacity_1.differential_0;
    *v_rgb_0 = dp_rgb_0.differential_0;
    *v_ray_o_2 = dp_ray_o_1.differential_0;
    *v_ray_d_2 = dp_ray_d_1.differential_0;
    return;
}

inline __device__ float view_radius_3dgs(float3  mean_4, float3  log_scale_0, float logit_opacity_0, float3  campos_0)
{
    float radius_1 = (F32_exp(((F32_max((log_scale_0.x), ((F32_max((log_scale_0.y), (log_scale_0.z))))))))) * (F32_sqrt((2.0f * (F32_log(((F32_max((255.0f / (1.0f + (F32_exp((- logit_opacity_0))))), (1.0f)))))))));
    float dist_0 = length_1(mean_4 - campos_0);
    return radius_1 / ((F32_max((dist_0), (radius_1))) + (F32_sqrt(((F32_max((dist_0 * dist_0 - radius_1 * radius_1), (0.0f)))))));
}

