#pragma once

#include "generated/slang.cuh"

struct Tuple_0
{
    float value0_0;
};

inline __device__ Tuple_0 s_apply_exp_0(float x_0)
{
    Tuple_0 _S1 = { (F32_exp((x_0))) };
    return _S1;
}

struct s_bwdCallableCtx_exp_0
{
    float _S2;
};

struct DiffPair_float_0
{
    float primal_0;
    float differential_0;
};

inline __device__ void _d_exp_0(DiffPair_float_0 * dpx_0, float dOut_0)
{
    float _S3 = (F32_exp(((*dpx_0).primal_0))) * dOut_0;
    dpx_0->primal_0 = (*dpx_0).primal_0;
    dpx_0->differential_0 = _S3;
    return;
}

inline __device__ void s_bwdProp_exp_0(s_bwdCallableCtx_exp_0 * ctx_0, float * d_x_0, float d_out_0)
{
    DiffPair_float_0 _S4;
    (&_S4)->primal_0 = ctx_0->_S2;
    _d_exp_0(&_S4, d_out_0);
    *d_x_0 = (&_S4)->differential_0;
    return;
}

struct Tuple_1
{
    float value0_1;
};

inline __device__ float dot_0(float3  x_1, float3  y_0)
{
    int i_0 = int(0);
    float result_0 = 0.0f;
    for(;;)
    {
        if(i_0 < int(3))
        {
        }
        else
        {
            break;
        }
        float result_1 = result_0 + _slang_vector_get_element(x_1, i_0) * _slang_vector_get_element(y_0, i_0);
        i_0 = i_0 + int(1);
        result_0 = result_1;
    }
    return result_0;
}

inline __device__ Tuple_1 s_apply_dot_0(float3  x_2, float3  y_1)
{
    Tuple_1 _S5 = { dot_0(x_2, y_1) };
    return _S5;
}

struct s_bwdCallableCtx_dot_0
{
    float3  _S6;
    float3  _S7;
};

struct DiffPair_vectorx3Cfloatx2C3x3E_0
{
    float3  primal_0;
    float3  differential_0;
};

inline __device__ void _d_dot_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_1, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpy_0, float dOut_1)
{
    float3  x_d_result_0;
    *&((&x_d_result_0)->x) = (*dpy_0).primal_0.x * dOut_1;
    float3  y_d_result_0;
    *&((&y_d_result_0)->x) = (*dpx_1).primal_0.x * dOut_1;
    *&((&x_d_result_0)->y) = (*dpy_0).primal_0.y * dOut_1;
    *&((&y_d_result_0)->y) = (*dpx_1).primal_0.y * dOut_1;
    *&((&x_d_result_0)->z) = (*dpy_0).primal_0.z * dOut_1;
    *&((&y_d_result_0)->z) = (*dpx_1).primal_0.z * dOut_1;
    dpx_1->primal_0 = (*dpx_1).primal_0;
    dpx_1->differential_0 = x_d_result_0;
    dpy_0->primal_0 = (*dpy_0).primal_0;
    dpy_0->differential_0 = y_d_result_0;
    return;
}

inline __device__ void s_bwdProp_dot_0(s_bwdCallableCtx_dot_0 * ctx_1, float3  * d_x_1, float3  * d_y_0, float d_out_1)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S8;
    (&_S8)->primal_0 = ctx_1->_S6;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S9;
    (&_S9)->primal_0 = ctx_1->_S7;
    _d_dot_0(&_S8, &_S9, d_out_1);
    *d_x_1 = (&_S8)->differential_0;
    *d_y_0 = (&_S9)->differential_0;
    return;
}

struct Tuple_2
{
    float3  value0_2;
};

inline __device__ float3  cross_0(float3  left_0, float3  right_0)
{
    float _S10 = left_0.y;
    float _S11 = right_0.z;
    float _S12 = left_0.z;
    float _S13 = right_0.y;
    float _S14 = right_0.x;
    float _S15 = left_0.x;
    return make_float3 (_S10 * _S11 - _S12 * _S13, _S12 * _S14 - _S15 * _S11, _S15 * _S13 - _S10 * _S14);
}

inline __device__ Tuple_2 s_apply_cross_0(float3  left_1, float3  right_1)
{
    Tuple_2 _S16 = { cross_0(left_1, right_1) };
    return _S16;
}

struct s_bwdCallableCtx_cross_0
{
    float3  _S17;
    float3  _S18;
};

inline __device__ void _d_cross_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * a_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * b_0, float3  dOut_2)
{
    float _S19 = dOut_2.y;
    float _S20 = dOut_2.z;
    float _S21 = dOut_2.x;
    float _S22 = (*a_0).primal_0.z * _S19 + - (*a_0).primal_0.y * _S20;
    float _S23 = - (*a_0).primal_0.z * _S21 + (*a_0).primal_0.x * _S20;
    float _S24 = (*a_0).primal_0.y * _S21 + - (*a_0).primal_0.x * _S19;
    float3  _S25 = make_float3 (- (*b_0).primal_0.z * _S19 + (*b_0).primal_0.y * _S20, (*b_0).primal_0.z * _S21 + - (*b_0).primal_0.x * _S20, - (*b_0).primal_0.y * _S21 + (*b_0).primal_0.x * _S19);
    a_0->primal_0 = (*a_0).primal_0;
    a_0->differential_0 = _S25;
    float3  _S26 = make_float3 (_S22, _S23, _S24);
    b_0->primal_0 = (*b_0).primal_0;
    b_0->differential_0 = _S26;
    return;
}

inline __device__ void s_bwdProp_cross_0(s_bwdCallableCtx_cross_0 * ctx_2, float3  * d_left_0, float3  * d_right_0, float3  d_out_2)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S27;
    (&_S27)->primal_0 = ctx_2->_S17;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S28;
    (&_S28)->primal_0 = ctx_2->_S18;
    _d_cross_0(&_S27, &_S28, d_out_2);
    *d_left_0 = (&_S27)->differential_0;
    *d_right_0 = (&_S28)->differential_0;
    return;
}

struct Tuple_3
{
    float3  value0_3;
};

inline __device__ float3  mul_0(Matrix<float, 3, 3>  left_2, float3  right_2)
{
    float3  result_2;
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
        float sum_0 = 0.0f;
        for(;;)
        {
            if(j_0 < int(3))
            {
            }
            else
            {
                break;
            }
            float sum_1 = sum_0 + _slang_vector_get_element(left_2.rows[i_1], j_0) * _slang_vector_get_element(right_2, j_0);
            j_0 = j_0 + int(1);
            sum_0 = sum_1;
        }
        *_slang_vector_get_element_ptr(&result_2, i_1) = sum_0;
        i_1 = i_1 + int(1);
    }
    return result_2;
}

inline __device__ Tuple_3 s_apply_mul_0(Matrix<float, 3, 3>  left_3, float3  right_3)
{
    Tuple_3 _S29 = { mul_0(left_3, right_3) };
    return _S29;
}

struct s_bwdCallableCtx_mul_0
{
    Matrix<float, 3, 3>  _S30;
    float3  _S31;
};

struct DiffPair_matrixx3Cfloatx2C3x2C3x3E_0
{
    Matrix<float, 3, 3>  primal_0;
    Matrix<float, 3, 3>  differential_0;
};

inline __device__ void _d_mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * left_4, DiffPair_vectorx3Cfloatx2C3x3E_0 * right_4, float3  dOut_3)
{
    float _S32 = (*left_4).primal_0.rows[int(0)].x * dOut_3.x;
    Matrix<float, 3, 3>  left_d_result_0;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = (*right_4).primal_0.x * dOut_3.x;
    float sum_2 = _S32 + (*left_4).primal_0.rows[int(1)].x * dOut_3.y;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = (*right_4).primal_0.x * dOut_3.y;
    float sum_3 = sum_2 + (*left_4).primal_0.rows[int(2)].x * dOut_3.z;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = (*right_4).primal_0.x * dOut_3.z;
    float3  right_d_result_0;
    *&((&right_d_result_0)->x) = sum_3;
    float _S33 = (*left_4).primal_0.rows[int(0)].y * dOut_3.x;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = (*right_4).primal_0.y * dOut_3.x;
    float sum_4 = _S33 + (*left_4).primal_0.rows[int(1)].y * dOut_3.y;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = (*right_4).primal_0.y * dOut_3.y;
    float sum_5 = sum_4 + (*left_4).primal_0.rows[int(2)].y * dOut_3.z;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = (*right_4).primal_0.y * dOut_3.z;
    *&((&right_d_result_0)->y) = sum_5;
    float _S34 = (*left_4).primal_0.rows[int(0)].z * dOut_3.x;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = (*right_4).primal_0.z * dOut_3.x;
    float sum_6 = _S34 + (*left_4).primal_0.rows[int(1)].z * dOut_3.y;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = (*right_4).primal_0.z * dOut_3.y;
    float sum_7 = sum_6 + (*left_4).primal_0.rows[int(2)].z * dOut_3.z;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = (*right_4).primal_0.z * dOut_3.z;
    *&((&right_d_result_0)->z) = sum_7;
    left_4->primal_0 = (*left_4).primal_0;
    left_4->differential_0 = left_d_result_0;
    right_4->primal_0 = (*right_4).primal_0;
    right_4->differential_0 = right_d_result_0;
    return;
}

inline __device__ void s_bwdProp_mul_0(s_bwdCallableCtx_mul_0 * ctx_3, Matrix<float, 3, 3>  * d_left_1, float3  * d_right_1, float3  d_out_3)
{
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S35;
    (&_S35)->primal_0 = ctx_3->_S30;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S36;
    (&_S36)->primal_0 = ctx_3->_S31;
    _d_mul_0(&_S35, &_S36, d_out_3);
    *d_left_1 = (&_S35)->differential_0;
    *d_right_1 = (&_S36)->differential_0;
    return;
}

struct s_bwdCallableCtx_mul_1
{
    Matrix<float, 3, 3>  _S37;
    Matrix<float, 3, 3>  _S38;
};

inline __device__ void mul_1(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * left_5, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * right_5, Matrix<float, 3, 3>  dOut_4)
{
    Matrix<float, 3, 3>  left_d_result_1;
    *&(((&left_d_result_1)->rows + (int(0)))->x) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(0)))->y) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(0)))->z) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(1)))->x) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(1)))->y) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(1)))->z) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(2)))->x) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(2)))->y) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(2)))->z) = 0.0f;
    Matrix<float, 3, 3>  right_d_result_1;
    *&(((&right_d_result_1)->rows + (int(0)))->x) = 0.0f;
    *&(((&right_d_result_1)->rows + (int(0)))->y) = 0.0f;
    *&(((&right_d_result_1)->rows + (int(0)))->z) = 0.0f;
    *&(((&right_d_result_1)->rows + (int(1)))->x) = 0.0f;
    *&(((&right_d_result_1)->rows + (int(1)))->y) = 0.0f;
    *&(((&right_d_result_1)->rows + (int(1)))->z) = 0.0f;
    *&(((&right_d_result_1)->rows + (int(2)))->x) = 0.0f;
    *&(((&right_d_result_1)->rows + (int(2)))->y) = 0.0f;
    *&(((&right_d_result_1)->rows + (int(2)))->z) = 0.0f;
    *&(((&left_d_result_1)->rows + (int(0)))->x) = *&(((&left_d_result_1)->rows + (int(0)))->x) + (*right_5).primal_0.rows[int(0)].x * dOut_4.rows[int(0)].x;
    *&(((&right_d_result_1)->rows + (int(0)))->x) = *&(((&right_d_result_1)->rows + (int(0)))->x) + (*left_5).primal_0.rows[int(0)].x * dOut_4.rows[int(0)].x;
    *&(((&left_d_result_1)->rows + (int(0)))->y) = *&(((&left_d_result_1)->rows + (int(0)))->y) + (*right_5).primal_0.rows[int(1)].x * dOut_4.rows[int(0)].x;
    *&(((&right_d_result_1)->rows + (int(1)))->x) = *&(((&right_d_result_1)->rows + (int(1)))->x) + (*left_5).primal_0.rows[int(0)].y * dOut_4.rows[int(0)].x;
    *&(((&left_d_result_1)->rows + (int(0)))->z) = *&(((&left_d_result_1)->rows + (int(0)))->z) + (*right_5).primal_0.rows[int(2)].x * dOut_4.rows[int(0)].x;
    *&(((&right_d_result_1)->rows + (int(2)))->x) = *&(((&right_d_result_1)->rows + (int(2)))->x) + (*left_5).primal_0.rows[int(0)].z * dOut_4.rows[int(0)].x;
    *&(((&left_d_result_1)->rows + (int(0)))->x) = *&(((&left_d_result_1)->rows + (int(0)))->x) + (*right_5).primal_0.rows[int(0)].y * dOut_4.rows[int(0)].y;
    *&(((&right_d_result_1)->rows + (int(0)))->y) = *&(((&right_d_result_1)->rows + (int(0)))->y) + (*left_5).primal_0.rows[int(0)].x * dOut_4.rows[int(0)].y;
    *&(((&left_d_result_1)->rows + (int(0)))->y) = *&(((&left_d_result_1)->rows + (int(0)))->y) + (*right_5).primal_0.rows[int(1)].y * dOut_4.rows[int(0)].y;
    *&(((&right_d_result_1)->rows + (int(1)))->y) = *&(((&right_d_result_1)->rows + (int(1)))->y) + (*left_5).primal_0.rows[int(0)].y * dOut_4.rows[int(0)].y;
    *&(((&left_d_result_1)->rows + (int(0)))->z) = *&(((&left_d_result_1)->rows + (int(0)))->z) + (*right_5).primal_0.rows[int(2)].y * dOut_4.rows[int(0)].y;
    *&(((&right_d_result_1)->rows + (int(2)))->y) = *&(((&right_d_result_1)->rows + (int(2)))->y) + (*left_5).primal_0.rows[int(0)].z * dOut_4.rows[int(0)].y;
    *&(((&left_d_result_1)->rows + (int(0)))->x) = *&(((&left_d_result_1)->rows + (int(0)))->x) + (*right_5).primal_0.rows[int(0)].z * dOut_4.rows[int(0)].z;
    *&(((&right_d_result_1)->rows + (int(0)))->z) = *&(((&right_d_result_1)->rows + (int(0)))->z) + (*left_5).primal_0.rows[int(0)].x * dOut_4.rows[int(0)].z;
    *&(((&left_d_result_1)->rows + (int(0)))->y) = *&(((&left_d_result_1)->rows + (int(0)))->y) + (*right_5).primal_0.rows[int(1)].z * dOut_4.rows[int(0)].z;
    *&(((&right_d_result_1)->rows + (int(1)))->z) = *&(((&right_d_result_1)->rows + (int(1)))->z) + (*left_5).primal_0.rows[int(0)].y * dOut_4.rows[int(0)].z;
    *&(((&left_d_result_1)->rows + (int(0)))->z) = *&(((&left_d_result_1)->rows + (int(0)))->z) + (*right_5).primal_0.rows[int(2)].z * dOut_4.rows[int(0)].z;
    *&(((&right_d_result_1)->rows + (int(2)))->z) = *&(((&right_d_result_1)->rows + (int(2)))->z) + (*left_5).primal_0.rows[int(0)].z * dOut_4.rows[int(0)].z;
    *&(((&left_d_result_1)->rows + (int(1)))->x) = *&(((&left_d_result_1)->rows + (int(1)))->x) + (*right_5).primal_0.rows[int(0)].x * dOut_4.rows[int(1)].x;
    *&(((&right_d_result_1)->rows + (int(0)))->x) = *&(((&right_d_result_1)->rows + (int(0)))->x) + (*left_5).primal_0.rows[int(1)].x * dOut_4.rows[int(1)].x;
    *&(((&left_d_result_1)->rows + (int(1)))->y) = *&(((&left_d_result_1)->rows + (int(1)))->y) + (*right_5).primal_0.rows[int(1)].x * dOut_4.rows[int(1)].x;
    *&(((&right_d_result_1)->rows + (int(1)))->x) = *&(((&right_d_result_1)->rows + (int(1)))->x) + (*left_5).primal_0.rows[int(1)].y * dOut_4.rows[int(1)].x;
    *&(((&left_d_result_1)->rows + (int(1)))->z) = *&(((&left_d_result_1)->rows + (int(1)))->z) + (*right_5).primal_0.rows[int(2)].x * dOut_4.rows[int(1)].x;
    *&(((&right_d_result_1)->rows + (int(2)))->x) = *&(((&right_d_result_1)->rows + (int(2)))->x) + (*left_5).primal_0.rows[int(1)].z * dOut_4.rows[int(1)].x;
    *&(((&left_d_result_1)->rows + (int(1)))->x) = *&(((&left_d_result_1)->rows + (int(1)))->x) + (*right_5).primal_0.rows[int(0)].y * dOut_4.rows[int(1)].y;
    *&(((&right_d_result_1)->rows + (int(0)))->y) = *&(((&right_d_result_1)->rows + (int(0)))->y) + (*left_5).primal_0.rows[int(1)].x * dOut_4.rows[int(1)].y;
    *&(((&left_d_result_1)->rows + (int(1)))->y) = *&(((&left_d_result_1)->rows + (int(1)))->y) + (*right_5).primal_0.rows[int(1)].y * dOut_4.rows[int(1)].y;
    *&(((&right_d_result_1)->rows + (int(1)))->y) = *&(((&right_d_result_1)->rows + (int(1)))->y) + (*left_5).primal_0.rows[int(1)].y * dOut_4.rows[int(1)].y;
    *&(((&left_d_result_1)->rows + (int(1)))->z) = *&(((&left_d_result_1)->rows + (int(1)))->z) + (*right_5).primal_0.rows[int(2)].y * dOut_4.rows[int(1)].y;
    *&(((&right_d_result_1)->rows + (int(2)))->y) = *&(((&right_d_result_1)->rows + (int(2)))->y) + (*left_5).primal_0.rows[int(1)].z * dOut_4.rows[int(1)].y;
    *&(((&left_d_result_1)->rows + (int(1)))->x) = *&(((&left_d_result_1)->rows + (int(1)))->x) + (*right_5).primal_0.rows[int(0)].z * dOut_4.rows[int(1)].z;
    *&(((&right_d_result_1)->rows + (int(0)))->z) = *&(((&right_d_result_1)->rows + (int(0)))->z) + (*left_5).primal_0.rows[int(1)].x * dOut_4.rows[int(1)].z;
    *&(((&left_d_result_1)->rows + (int(1)))->y) = *&(((&left_d_result_1)->rows + (int(1)))->y) + (*right_5).primal_0.rows[int(1)].z * dOut_4.rows[int(1)].z;
    *&(((&right_d_result_1)->rows + (int(1)))->z) = *&(((&right_d_result_1)->rows + (int(1)))->z) + (*left_5).primal_0.rows[int(1)].y * dOut_4.rows[int(1)].z;
    *&(((&left_d_result_1)->rows + (int(1)))->z) = *&(((&left_d_result_1)->rows + (int(1)))->z) + (*right_5).primal_0.rows[int(2)].z * dOut_4.rows[int(1)].z;
    *&(((&right_d_result_1)->rows + (int(2)))->z) = *&(((&right_d_result_1)->rows + (int(2)))->z) + (*left_5).primal_0.rows[int(1)].z * dOut_4.rows[int(1)].z;
    *&(((&left_d_result_1)->rows + (int(2)))->x) = *&(((&left_d_result_1)->rows + (int(2)))->x) + (*right_5).primal_0.rows[int(0)].x * dOut_4.rows[int(2)].x;
    *&(((&right_d_result_1)->rows + (int(0)))->x) = *&(((&right_d_result_1)->rows + (int(0)))->x) + (*left_5).primal_0.rows[int(2)].x * dOut_4.rows[int(2)].x;
    *&(((&left_d_result_1)->rows + (int(2)))->y) = *&(((&left_d_result_1)->rows + (int(2)))->y) + (*right_5).primal_0.rows[int(1)].x * dOut_4.rows[int(2)].x;
    *&(((&right_d_result_1)->rows + (int(1)))->x) = *&(((&right_d_result_1)->rows + (int(1)))->x) + (*left_5).primal_0.rows[int(2)].y * dOut_4.rows[int(2)].x;
    *&(((&left_d_result_1)->rows + (int(2)))->z) = *&(((&left_d_result_1)->rows + (int(2)))->z) + (*right_5).primal_0.rows[int(2)].x * dOut_4.rows[int(2)].x;
    *&(((&right_d_result_1)->rows + (int(2)))->x) = *&(((&right_d_result_1)->rows + (int(2)))->x) + (*left_5).primal_0.rows[int(2)].z * dOut_4.rows[int(2)].x;
    *&(((&left_d_result_1)->rows + (int(2)))->x) = *&(((&left_d_result_1)->rows + (int(2)))->x) + (*right_5).primal_0.rows[int(0)].y * dOut_4.rows[int(2)].y;
    *&(((&right_d_result_1)->rows + (int(0)))->y) = *&(((&right_d_result_1)->rows + (int(0)))->y) + (*left_5).primal_0.rows[int(2)].x * dOut_4.rows[int(2)].y;
    *&(((&left_d_result_1)->rows + (int(2)))->y) = *&(((&left_d_result_1)->rows + (int(2)))->y) + (*right_5).primal_0.rows[int(1)].y * dOut_4.rows[int(2)].y;
    *&(((&right_d_result_1)->rows + (int(1)))->y) = *&(((&right_d_result_1)->rows + (int(1)))->y) + (*left_5).primal_0.rows[int(2)].y * dOut_4.rows[int(2)].y;
    *&(((&left_d_result_1)->rows + (int(2)))->z) = *&(((&left_d_result_1)->rows + (int(2)))->z) + (*right_5).primal_0.rows[int(2)].y * dOut_4.rows[int(2)].y;
    *&(((&right_d_result_1)->rows + (int(2)))->y) = *&(((&right_d_result_1)->rows + (int(2)))->y) + (*left_5).primal_0.rows[int(2)].z * dOut_4.rows[int(2)].y;
    *&(((&left_d_result_1)->rows + (int(2)))->x) = *&(((&left_d_result_1)->rows + (int(2)))->x) + (*right_5).primal_0.rows[int(0)].z * dOut_4.rows[int(2)].z;
    *&(((&right_d_result_1)->rows + (int(0)))->z) = *&(((&right_d_result_1)->rows + (int(0)))->z) + (*left_5).primal_0.rows[int(2)].x * dOut_4.rows[int(2)].z;
    *&(((&left_d_result_1)->rows + (int(2)))->y) = *&(((&left_d_result_1)->rows + (int(2)))->y) + (*right_5).primal_0.rows[int(1)].z * dOut_4.rows[int(2)].z;
    *&(((&right_d_result_1)->rows + (int(1)))->z) = *&(((&right_d_result_1)->rows + (int(1)))->z) + (*left_5).primal_0.rows[int(2)].y * dOut_4.rows[int(2)].z;
    *&(((&left_d_result_1)->rows + (int(2)))->z) = *&(((&left_d_result_1)->rows + (int(2)))->z) + (*right_5).primal_0.rows[int(2)].z * dOut_4.rows[int(2)].z;
    *&(((&right_d_result_1)->rows + (int(2)))->z) = *&(((&right_d_result_1)->rows + (int(2)))->z) + (*left_5).primal_0.rows[int(2)].z * dOut_4.rows[int(2)].z;
    left_5->primal_0 = (*left_5).primal_0;
    left_5->differential_0 = left_d_result_1;
    right_5->primal_0 = (*right_5).primal_0;
    right_5->differential_0 = right_d_result_1;
    return;
}

inline __device__ void s_bwdProp_mul_1(s_bwdCallableCtx_mul_1 * ctx_4, Matrix<float, 3, 3>  * d_left_2, Matrix<float, 3, 3>  * d_right_2, Matrix<float, 3, 3>  d_out_4)
{
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S39;
    (&_S39)->primal_0 = ctx_4->_S37;
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S40;
    (&_S40)->primal_0 = ctx_4->_S38;
    mul_1(&_S39, &_S40, d_out_4);
    *d_left_2 = (&_S39)->differential_0;
    *d_right_2 = (&_S40)->differential_0;
    return;
}

struct Tuple_4
{
    Matrix<float, 3, 3>  value0_4;
};

inline __device__ Matrix<float, 3, 3>  transpose_0(Matrix<float, 3, 3>  x_3)
{
    Matrix<float, 3, 3>  result_3;
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
            *_slang_vector_get_element_ptr(((&result_3)->rows + (r_0)), c_0) = _slang_vector_get_element(x_3.rows[c_0], r_0);
            c_0 = c_0 + int(1);
        }
        r_0 = r_0 + int(1);
    }
    return result_3;
}

inline __device__ Tuple_4 s_apply_transpose_0(Matrix<float, 3, 3>  x_4)
{
    Tuple_4 _S41 = { transpose_0(x_4) };
    return _S41;
}

struct s_bwdCallableCtx_transpose_0
{
    Matrix<float, 3, 3>  _S42;
};

inline __device__ void s_bwdProp_transpose_0(s_bwdCallableCtx_transpose_0 * ctx_5, Matrix<float, 3, 3>  * d_x_2, Matrix<float, 3, 3>  d_out_5)
{
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S43;
    (&_S43)->primal_0 = ctx_5->_S42;
    Matrix<float, 3, 3>  _S44 = transpose_0(d_out_5);
    (&_S43)->primal_0 = _S43.primal_0;
    (&_S43)->differential_0 = _S44;
    *d_x_2 = (&_S43)->differential_0;
    return;
}

struct Tuple_5
{
    float3  value0_5;
};

inline __device__ float3  exp_0(float3  x_5)
{
    float3  result_4;
    int i_2 = int(0);
    for(;;)
    {
        if(i_2 < int(3))
        {
        }
        else
        {
            break;
        }
        *_slang_vector_get_element_ptr(&result_4, i_2) = (F32_exp((_slang_vector_get_element(x_5, i_2))));
        i_2 = i_2 + int(1);
    }
    return result_4;
}

inline __device__ Tuple_5 s_apply_exp_1(float3  x_6)
{
    Tuple_5 _S45 = { exp_0(x_6) };
    return _S45;
}

struct s_bwdCallableCtx_exp_1
{
    float3  _S46;
};

inline __device__ void _d_exp_vector_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_2, float3  dOut_5)
{
    float3  _S47 = exp_0((*dpx_2).primal_0) * dOut_5;
    dpx_2->primal_0 = (*dpx_2).primal_0;
    dpx_2->differential_0 = _S47;
    return;
}

inline __device__ void s_bwdProp_exp_1(s_bwdCallableCtx_exp_1 * ctx_6, float3  * d_x_3, float3  d_out_6)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S48;
    (&_S48)->primal_0 = ctx_6->_S46;
    _d_exp_vector_0(&_S48, d_out_6);
    *d_x_3 = (&_S48)->differential_0;
    return;
}

struct s_bwdCallableCtx_mul_2
{
    float3  _S49;
    Matrix<float, 3, 3>  _S50;
};

inline __device__ void _d_mul_1(DiffPair_vectorx3Cfloatx2C3x3E_0 * left_6, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * right_6, float3  dOut_6)
{
    float _S51 = (*right_6).primal_0.rows[int(0)].x * dOut_6.x;
    Matrix<float, 3, 3>  right_d_result_2;
    *&(((&right_d_result_2)->rows + (int(0)))->x) = (*left_6).primal_0.x * dOut_6.x;
    float sum_8 = _S51 + (*right_6).primal_0.rows[int(0)].y * dOut_6.y;
    *&(((&right_d_result_2)->rows + (int(0)))->y) = (*left_6).primal_0.x * dOut_6.y;
    float sum_9 = sum_8 + (*right_6).primal_0.rows[int(0)].z * dOut_6.z;
    *&(((&right_d_result_2)->rows + (int(0)))->z) = (*left_6).primal_0.x * dOut_6.z;
    float3  left_d_result_2;
    *&((&left_d_result_2)->x) = sum_9;
    float _S52 = (*right_6).primal_0.rows[int(1)].x * dOut_6.x;
    *&(((&right_d_result_2)->rows + (int(1)))->x) = (*left_6).primal_0.y * dOut_6.x;
    float sum_10 = _S52 + (*right_6).primal_0.rows[int(1)].y * dOut_6.y;
    *&(((&right_d_result_2)->rows + (int(1)))->y) = (*left_6).primal_0.y * dOut_6.y;
    float sum_11 = sum_10 + (*right_6).primal_0.rows[int(1)].z * dOut_6.z;
    *&(((&right_d_result_2)->rows + (int(1)))->z) = (*left_6).primal_0.y * dOut_6.z;
    *&((&left_d_result_2)->y) = sum_11;
    float _S53 = (*right_6).primal_0.rows[int(2)].x * dOut_6.x;
    *&(((&right_d_result_2)->rows + (int(2)))->x) = (*left_6).primal_0.z * dOut_6.x;
    float sum_12 = _S53 + (*right_6).primal_0.rows[int(2)].y * dOut_6.y;
    *&(((&right_d_result_2)->rows + (int(2)))->y) = (*left_6).primal_0.z * dOut_6.y;
    float sum_13 = sum_12 + (*right_6).primal_0.rows[int(2)].z * dOut_6.z;
    *&(((&right_d_result_2)->rows + (int(2)))->z) = (*left_6).primal_0.z * dOut_6.z;
    *&((&left_d_result_2)->z) = sum_13;
    left_6->primal_0 = (*left_6).primal_0;
    left_6->differential_0 = left_d_result_2;
    right_6->primal_0 = (*right_6).primal_0;
    right_6->differential_0 = right_d_result_2;
    return;
}

inline __device__ void s_bwdProp_mul_2(s_bwdCallableCtx_mul_2 * ctx_7, float3  * d_left_3, Matrix<float, 3, 3>  * d_right_3, float3  d_out_7)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S54;
    (&_S54)->primal_0 = ctx_7->_S49;
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S55;
    (&_S55)->primal_0 = ctx_7->_S50;
    _d_mul_1(&_S54, &_S55, d_out_7);
    *d_left_3 = (&_S54)->differential_0;
    *d_right_3 = (&_S55)->differential_0;
    return;
}

inline __device__ float dot_1(float2  x_7, float2  y_2)
{
    int i_3 = int(0);
    float result_5 = 0.0f;
    for(;;)
    {
        if(i_3 < int(2))
        {
        }
        else
        {
            break;
        }
        float result_6 = result_5 + _slang_vector_get_element(x_7, i_3) * _slang_vector_get_element(y_2, i_3);
        i_3 = i_3 + int(1);
        result_5 = result_6;
    }
    return result_5;
}

inline __device__ float length_0(float2  x_8)
{
    return (F32_sqrt((dot_1(x_8, x_8))));
}

inline __device__ int clamp_0(int x_9, int minBound_0, int maxBound_0)
{
    return (I32_min(((I32_max((x_9), (minBound_0)))), (maxBound_0)));
}

inline __device__ float DistKBPolarSpline_cubic_0(float a_1, float b_1, float c_1, float d_0, float t_0)
{
    return b_1 + 0.5f * t_0 * (c_1 - a_1 + t_0 * (2.0f * a_1 - 5.0f * b_1 + 4.0f * c_1 - d_0 + t_0 * (3.0f * (b_1 - c_1) + d_0 - a_1)));
}

inline __device__ float2  DistKBPolarSpline_distort_0(float2  uv_0, FixedArray<float, 58>  * coeffs_0)
{
    float r2_0 = dot_1(uv_0, uv_0);
    float2  kb_0 = uv_0 * make_float2 (1.0f + r2_0 * ((*coeffs_0)[int(0)] + r2_0 * ((*coeffs_0)[int(1)] + r2_0 * ((*coeffs_0)[int(2)] + r2_0 * (*coeffs_0)[int(3)]))));
    float2  grid_0 = kb_0 * make_float2 ((*coeffs_0)[int(4)], (*coeffs_0)[int(5)]);
    if((dot_1(grid_0, grid_0)) < 9.99999968265522539e-21f)
    {
        return kb_0;
    }
    float radius_0 = length_0(grid_0);
    float _S56 = grid_0.y;
    float _S57 = grid_0.x;
    float theta_0 = (F32_atan2((_S56), (_S57))) * 0.79577469825744629f;
    float theta_1;
    if(theta_0 < 0.0f)
    {
        theta_1 = theta_0 + 5.0f;
    }
    else
    {
        theta_1 = theta_0;
    }
    int _S58 = int((F32_floor((radius_0))));
    int _S59 = int((F32_floor((theta_1))));
    int2  _S60 = make_int2 (int(0));
    float2  _S61 = make_float2 ((float)_S60.x, (float)_S60.y);
    float2  rt_0 = _S61;
    FixedArray<float, 4>  rows_0;
    int _S62 = clamp_0(_S58 - int(1), int(0), int(6));
    int col_0 = (_S59 + int(4)) % int(5);
    FixedArray<float, 4>  nodes_0;
    bool _S63 = _S62 < int(2);
    float _S64;
    if(_S63)
    {
        _S64 = 0.0f;
    }
    else
    {
        _S64 = (*coeffs_0)[int(8) + (_S62 - int(2)) * int(5) + col_0];
    }
    nodes_0[int(0)] = _S64;
    int col_1 = (_S59 + int(1) + int(4)) % int(5);
    if(_S63)
    {
        _S64 = 0.0f;
    }
    else
    {
        _S64 = (*coeffs_0)[int(8) + (_S62 - int(2)) * int(5) + col_1];
    }
    nodes_0[int(1)] = _S64;
    int col_2 = (_S59 + int(2) + int(4)) % int(5);
    if(_S63)
    {
        _S64 = 0.0f;
    }
    else
    {
        _S64 = (*coeffs_0)[int(8) + (_S62 - int(2)) * int(5) + col_2];
    }
    nodes_0[int(2)] = _S64;
    int col_3 = (_S59 + int(3) + int(4)) % int(5);
    if(_S63)
    {
        _S64 = 0.0f;
    }
    else
    {
        _S64 = (*coeffs_0)[int(8) + (_S62 - int(2)) * int(5) + col_3];
    }
    nodes_0[int(3)] = _S64;
    float _S65 = theta_1 - float(_S59);
    rows_0[int(0)] = DistKBPolarSpline_cubic_0(nodes_0[int(0)], nodes_0[int(1)], nodes_0[int(2)], nodes_0[int(3)], _S65);
    int _S66 = clamp_0(_S58 + int(1) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_1;
    bool _S67 = _S66 < int(2);
    if(_S67)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S66 - int(2)) * int(5) + col_0];
    }
    nodes_1[int(0)] = theta_1;
    if(_S67)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S66 - int(2)) * int(5) + col_1];
    }
    nodes_1[int(1)] = theta_1;
    if(_S67)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S66 - int(2)) * int(5) + col_2];
    }
    nodes_1[int(2)] = theta_1;
    if(_S67)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S66 - int(2)) * int(5) + col_3];
    }
    nodes_1[int(3)] = theta_1;
    rows_0[int(1)] = DistKBPolarSpline_cubic_0(nodes_1[int(0)], nodes_1[int(1)], nodes_1[int(2)], nodes_1[int(3)], _S65);
    int _S68 = clamp_0(_S58 + int(2) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_2;
    bool _S69 = _S68 < int(2);
    if(_S69)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S68 - int(2)) * int(5) + col_0];
    }
    nodes_2[int(0)] = theta_1;
    if(_S69)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S68 - int(2)) * int(5) + col_1];
    }
    nodes_2[int(1)] = theta_1;
    if(_S69)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S68 - int(2)) * int(5) + col_2];
    }
    nodes_2[int(2)] = theta_1;
    if(_S69)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S68 - int(2)) * int(5) + col_3];
    }
    nodes_2[int(3)] = theta_1;
    rows_0[int(2)] = DistKBPolarSpline_cubic_0(nodes_2[int(0)], nodes_2[int(1)], nodes_2[int(2)], nodes_2[int(3)], _S65);
    int _S70 = clamp_0(_S58 + int(3) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_3;
    bool _S71 = _S70 < int(2);
    if(_S71)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S70 - int(2)) * int(5) + col_0];
    }
    nodes_3[int(0)] = theta_1;
    if(_S71)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S70 - int(2)) * int(5) + col_1];
    }
    nodes_3[int(1)] = theta_1;
    if(_S71)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S70 - int(2)) * int(5) + col_2];
    }
    nodes_3[int(2)] = theta_1;
    if(_S71)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S70 - int(2)) * int(5) + col_3];
    }
    nodes_3[int(3)] = theta_1;
    float _S72 = DistKBPolarSpline_cubic_0(nodes_3[int(0)], nodes_3[int(1)], nodes_3[int(2)], nodes_3[int(3)], _S65);
    rows_0[int(3)] = _S72;
    float _S73 = radius_0 - float(_S58);
    *&((&rt_0)->x) = DistKBPolarSpline_cubic_0(rows_0[int(0)], rows_0[int(1)], rows_0[int(2)], _S72, _S73);
    FixedArray<float, 4>  rows_1;
    FixedArray<float, 4>  nodes_4;
    if(_S63)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S62 - int(2)) * int(5) + col_0];
    }
    nodes_4[int(0)] = theta_1;
    if(_S63)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S62 - int(2)) * int(5) + col_1];
    }
    nodes_4[int(1)] = theta_1;
    if(_S63)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S62 - int(2)) * int(5) + col_2];
    }
    nodes_4[int(2)] = theta_1;
    if(_S63)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S62 - int(2)) * int(5) + col_3];
    }
    nodes_4[int(3)] = theta_1;
    rows_1[int(0)] = DistKBPolarSpline_cubic_0(nodes_4[int(0)], nodes_4[int(1)], nodes_4[int(2)], nodes_4[int(3)], _S65);
    FixedArray<float, 4>  nodes_5;
    if(_S67)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S66 - int(2)) * int(5) + col_0];
    }
    nodes_5[int(0)] = theta_1;
    if(_S67)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S66 - int(2)) * int(5) + col_1];
    }
    nodes_5[int(1)] = theta_1;
    if(_S67)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S66 - int(2)) * int(5) + col_2];
    }
    nodes_5[int(2)] = theta_1;
    if(_S67)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S66 - int(2)) * int(5) + col_3];
    }
    nodes_5[int(3)] = theta_1;
    rows_1[int(1)] = DistKBPolarSpline_cubic_0(nodes_5[int(0)], nodes_5[int(1)], nodes_5[int(2)], nodes_5[int(3)], _S65);
    FixedArray<float, 4>  nodes_6;
    if(_S69)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S68 - int(2)) * int(5) + col_0];
    }
    nodes_6[int(0)] = theta_1;
    if(_S69)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S68 - int(2)) * int(5) + col_1];
    }
    nodes_6[int(1)] = theta_1;
    if(_S69)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S68 - int(2)) * int(5) + col_2];
    }
    nodes_6[int(2)] = theta_1;
    if(_S69)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S68 - int(2)) * int(5) + col_3];
    }
    nodes_6[int(3)] = theta_1;
    rows_1[int(2)] = DistKBPolarSpline_cubic_0(nodes_6[int(0)], nodes_6[int(1)], nodes_6[int(2)], nodes_6[int(3)], _S65);
    FixedArray<float, 4>  nodes_7;
    if(_S71)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S70 - int(2)) * int(5) + col_0];
    }
    nodes_7[int(0)] = theta_1;
    if(_S71)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S70 - int(2)) * int(5) + col_1];
    }
    nodes_7[int(1)] = theta_1;
    if(_S71)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S70 - int(2)) * int(5) + col_2];
    }
    nodes_7[int(2)] = theta_1;
    if(_S71)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S70 - int(2)) * int(5) + col_3];
    }
    nodes_7[int(3)] = theta_1;
    float _S74 = DistKBPolarSpline_cubic_0(nodes_7[int(0)], nodes_7[int(1)], nodes_7[int(2)], nodes_7[int(3)], _S65);
    rows_1[int(3)] = _S74;
    *&((&rt_0)->y) = DistKBPolarSpline_cubic_0(rows_1[int(0)], rows_1[int(1)], rows_1[int(2)], _S74, _S73);
    return kb_0 + make_float2 (rt_0.x * _S57 - rt_0.y * _S56, rt_0.x * _S56 + rt_0.y * _S57) / make_float2 (radius_0) * make_float2 ((*coeffs_0)[int(6)], (*coeffs_0)[int(7)]);
}

struct DiffPair_vectorx3Cfloatx2C2x3E_0
{
    float2  primal_0;
    float2  differential_0;
};

inline __device__ DiffPair_float_0 _d_dot_1(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_3, DiffPair_vectorx3Cfloatx2C2x3E_0 * dpy_1)
{
    DiffPair_float_0 _S75 = { *&((&dpx_3->primal_0)->x) * *&((&dpy_1->primal_0)->x) + *&((&dpx_3->primal_0)->y) * *&((&dpy_1->primal_0)->y), *&((&dpx_3->primal_0)->x) * *&((&dpy_1->differential_0)->x) + *&((&dpy_1->primal_0)->x) * *&((&dpx_3->differential_0)->x) + *&((&dpx_3->primal_0)->y) * *&((&dpy_1->differential_0)->y) + *&((&dpy_1->primal_0)->y) * *&((&dpx_3->differential_0)->y) };
    return _S75;
}

inline __device__ DiffPair_float_0 _d_sqrt_0(DiffPair_float_0 * dpx_4)
{
    DiffPair_float_0 _S76 = { (F32_sqrt((dpx_4->primal_0))), 0.5f / (F32_sqrt(((F32_max((1.00000001168609742e-07f), (dpx_4->primal_0)))))) * dpx_4->differential_0 };
    return _S76;
}

inline __device__ DiffPair_float_0 s_fwd_length_impl_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_5)
{
    float _S77 = *&((&dpx_5->differential_0)->x) * *&((&dpx_5->primal_0)->x);
    float _S78 = *&((&dpx_5->differential_0)->y) * *&((&dpx_5->primal_0)->y);
    float s_diff_len_0 = _S77 + _S77 + (_S78 + _S78);
    DiffPair_float_0 _S79;
    (&_S79)->primal_0 = *&((&dpx_5->primal_0)->x) * *&((&dpx_5->primal_0)->x) + *&((&dpx_5->primal_0)->y) * *&((&dpx_5->primal_0)->y);
    (&_S79)->differential_0 = s_diff_len_0;
    DiffPair_float_0 _S80 = _d_sqrt_0(&_S79);
    DiffPair_float_0 _S81 = { _S80.primal_0, _S80.differential_0 };
    return _S81;
}

inline __device__ DiffPair_float_0 _d_atan2_0(DiffPair_float_0 * dpy_2, DiffPair_float_0 * dpx_6)
{
    float _S82 = dpx_6->primal_0 * dpx_6->primal_0 + dpy_2->primal_0 * dpy_2->primal_0;
    DiffPair_float_0 _S83 = { (F32_atan2((dpy_2->primal_0), (dpx_6->primal_0))), - dpy_2->primal_0 / _S82 * dpx_6->differential_0 + dpx_6->primal_0 / _S82 * dpy_2->differential_0 };
    return _S83;
}

inline __device__ DiffPair_float_0 s_fwd_DistKBPolarSpline_cubic_0(DiffPair_float_0 * dpa_0, DiffPair_float_0 * dpb_0, DiffPair_float_0 * dpc_0, DiffPair_float_0 * dpd_0, DiffPair_float_0 * dpt_0)
{
    float _S84 = 0.5f * dpt_0->primal_0;
    float _S85 = 3.0f * (dpb_0->primal_0 - dpc_0->primal_0) + dpd_0->primal_0 - dpa_0->primal_0;
    float _S86 = 2.0f * dpa_0->primal_0 - 5.0f * dpb_0->primal_0 + 4.0f * dpc_0->primal_0 - dpd_0->primal_0 + dpt_0->primal_0 * _S85;
    float _S87 = dpc_0->primal_0 - dpa_0->primal_0 + dpt_0->primal_0 * _S86;
    DiffPair_float_0 _S88 = { dpb_0->primal_0 + _S84 * _S87, dpb_0->differential_0 + (dpt_0->differential_0 * 0.5f * _S87 + (dpc_0->differential_0 - dpa_0->differential_0 + (dpt_0->differential_0 * _S86 + (dpa_0->differential_0 * 2.0f - dpb_0->differential_0 * 5.0f + dpc_0->differential_0 * 4.0f - dpd_0->differential_0 + (dpt_0->differential_0 * _S85 + ((dpb_0->differential_0 - dpc_0->differential_0) * 3.0f + dpd_0->differential_0 - dpa_0->differential_0) * dpt_0->primal_0)) * dpt_0->primal_0)) * _S84) };
    return _S88;
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistKBPolarSpline_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_0, FixedArray<float, 58>  * coeffs_1)
{
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S89;
    (&_S89)->primal_0 = dpuv_0->primal_0;
    (&_S89)->differential_0 = dpuv_0->differential_0;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S90;
    (&_S90)->primal_0 = dpuv_0->primal_0;
    (&_S90)->differential_0 = dpuv_0->differential_0;
    DiffPair_float_0 _S91 = _d_dot_1(&_S89, &_S90);
    float _S92 = (*coeffs_1)[int(2)] + _S91.primal_0 * (*coeffs_1)[int(3)];
    float _S93 = (*coeffs_1)[int(1)] + _S91.primal_0 * _S92;
    float _S94 = (*coeffs_1)[int(0)] + _S91.primal_0 * _S93;
    float radial_0 = 1.0f + _S91.primal_0 * _S94;
    float2  kb_1 = dpuv_0->primal_0 * make_float2 (radial_0);
    float2  s_diff_kb_0 = dpuv_0->differential_0 * make_float2 (radial_0) + make_float2 (_S91.differential_0 * _S94 + (_S91.differential_0 * _S93 + (_S91.differential_0 * _S92 + _S91.differential_0 * (*coeffs_1)[int(3)] * _S91.primal_0) * _S91.primal_0) * _S91.primal_0) * dpuv_0->primal_0;
    float2  _S95 = make_float2 ((*coeffs_1)[int(4)], (*coeffs_1)[int(5)]);
    float2  grid_1 = kb_1 * _S95;
    float2  _S96 = s_diff_kb_0 * _S95;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S97;
    (&_S97)->primal_0 = grid_1;
    (&_S97)->differential_0 = _S96;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S98;
    (&_S98)->primal_0 = grid_1;
    (&_S98)->differential_0 = _S96;
    DiffPair_float_0 _S99 = _d_dot_1(&_S97, &_S98);
    if((_S99.primal_0) < 9.99999968265522539e-21f)
    {
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S100 = { kb_1, s_diff_kb_0 };
        return _S100;
    }
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S101;
    (&_S101)->primal_0 = grid_1;
    (&_S101)->differential_0 = _S96;
    DiffPair_float_0 _S102 = s_fwd_length_impl_0(&_S101);
    float _S103 = grid_1.y;
    float _S104 = _S96.y;
    float _S105 = grid_1.x;
    float _S106 = _S96.x;
    DiffPair_float_0 _S107;
    (&_S107)->primal_0 = _S103;
    (&_S107)->differential_0 = _S104;
    DiffPair_float_0 _S108;
    (&_S108)->primal_0 = _S105;
    (&_S108)->differential_0 = _S106;
    DiffPair_float_0 _S109 = _d_atan2_0(&_S107, &_S108);
    float theta_2 = _S109.primal_0 * 0.79577469825744629f;
    float _S110 = _S109.differential_0 * 0.79577469825744629f;
    float theta_3;
    if(theta_2 < 0.0f)
    {
        theta_3 = theta_2 + 5.0f;
    }
    else
    {
        theta_3 = theta_2;
    }
    int _S111 = int((F32_floor((_S102.primal_0))));
    int _S112 = int((F32_floor((theta_3))));
    int2  _S113 = make_int2 (int(0));
    float2  rt_1 = make_float2 ((float)_S113.x, (float)_S113.y);
    int _S114 = clamp_0(_S111 - int(1), int(0), int(6));
    int col_4 = (_S112 + int(4)) % int(5);
    bool _S115 = _S114 < int(2);
    int _S116 = (_S114 - int(2)) * int(5);
    int _S117 = int(8) + _S116;
    float _S118 = (*coeffs_1)[_S117 + col_4];
    int col_5 = (_S112 + int(1) + int(4)) % int(5);
    float _S119 = (*coeffs_1)[_S117 + col_5];
    int col_6 = (_S112 + int(2) + int(4)) % int(5);
    float _S120 = (*coeffs_1)[_S117 + col_6];
    int col_7 = (_S112 + int(3) + int(4)) % int(5);
    float _S121 = (*coeffs_1)[_S117 + col_7];
    float _S122 = theta_3 - float(_S112);
    int _S123 = clamp_0(_S111 + int(1) - int(1), int(0), int(6));
    bool _S124 = _S123 < int(2);
    int _S125 = (_S123 - int(2)) * int(5);
    int _S126 = int(8) + _S125;
    float _S127 = (*coeffs_1)[_S126 + col_4];
    float _S128 = (*coeffs_1)[_S126 + col_5];
    float _S129 = (*coeffs_1)[_S126 + col_6];
    float _S130 = (*coeffs_1)[_S126 + col_7];
    int _S131 = clamp_0(_S111 + int(2) - int(1), int(0), int(6));
    bool _S132 = _S131 < int(2);
    int _S133 = (_S131 - int(2)) * int(5);
    int _S134 = int(8) + _S133;
    float _S135 = (*coeffs_1)[_S134 + col_4];
    float _S136 = (*coeffs_1)[_S134 + col_5];
    float _S137 = (*coeffs_1)[_S134 + col_6];
    float _S138 = (*coeffs_1)[_S134 + col_7];
    int _S139 = clamp_0(_S111 + int(3) - int(1), int(0), int(6));
    bool _S140 = _S139 < int(2);
    int _S141 = (_S139 - int(2)) * int(5);
    int _S142 = int(8) + _S141;
    float _S143 = (*coeffs_1)[_S142 + col_4];
    float _S144 = (*coeffs_1)[_S142 + col_5];
    float _S145 = (*coeffs_1)[_S142 + col_6];
    float _S146 = (*coeffs_1)[_S142 + col_7];
    float _S147 = _S102.primal_0 - float(_S111);
    int _S148 = int(33) + _S116;
    float _S149 = (*coeffs_1)[_S148 + col_4];
    float _S150 = (*coeffs_1)[_S148 + col_5];
    float _S151 = (*coeffs_1)[_S148 + col_6];
    float _S152 = (*coeffs_1)[_S148 + col_7];
    int _S153 = int(33) + _S125;
    float _S154 = (*coeffs_1)[_S153 + col_4];
    float _S155 = (*coeffs_1)[_S153 + col_5];
    float _S156 = (*coeffs_1)[_S153 + col_6];
    float _S157 = (*coeffs_1)[_S153 + col_7];
    int _S158 = int(33) + _S133;
    float _S159 = (*coeffs_1)[_S158 + col_4];
    float _S160 = (*coeffs_1)[_S158 + col_5];
    float _S161 = (*coeffs_1)[_S158 + col_6];
    float _S162 = (*coeffs_1)[_S158 + col_7];
    int _S163 = int(33) + _S141;
    float _S164 = (*coeffs_1)[_S163 + col_4];
    float _S165 = (*coeffs_1)[_S163 + col_5];
    float _S166 = (*coeffs_1)[_S163 + col_6];
    float _S167 = (*coeffs_1)[_S163 + col_7];
    float2  _S168 = make_float2 ((*coeffs_1)[int(6)], (*coeffs_1)[int(7)]);
    if(_S115)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S118;
    }
    float _S169;
    if(_S115)
    {
        _S169 = 0.0f;
    }
    else
    {
        _S169 = _S119;
    }
    float _S170;
    if(_S115)
    {
        _S170 = 0.0f;
    }
    else
    {
        _S170 = _S120;
    }
    float _S171;
    if(_S115)
    {
        _S171 = 0.0f;
    }
    else
    {
        _S171 = _S121;
    }
    DiffPair_float_0 _S172;
    (&_S172)->primal_0 = theta_3;
    (&_S172)->differential_0 = 0.0f;
    DiffPair_float_0 _S173;
    (&_S173)->primal_0 = _S169;
    (&_S173)->differential_0 = 0.0f;
    DiffPair_float_0 _S174;
    (&_S174)->primal_0 = _S170;
    (&_S174)->differential_0 = 0.0f;
    DiffPair_float_0 _S175;
    (&_S175)->primal_0 = _S171;
    (&_S175)->differential_0 = 0.0f;
    DiffPair_float_0 _S176;
    (&_S176)->primal_0 = _S122;
    (&_S176)->differential_0 = _S110;
    DiffPair_float_0 _S177 = s_fwd_DistKBPolarSpline_cubic_0(&_S172, &_S173, &_S174, &_S175, &_S176);
    if(_S124)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S127;
    }
    if(_S124)
    {
        _S169 = 0.0f;
    }
    else
    {
        _S169 = _S128;
    }
    if(_S124)
    {
        _S170 = 0.0f;
    }
    else
    {
        _S170 = _S129;
    }
    if(_S124)
    {
        _S171 = 0.0f;
    }
    else
    {
        _S171 = _S130;
    }
    DiffPair_float_0 _S178;
    (&_S178)->primal_0 = theta_3;
    (&_S178)->differential_0 = 0.0f;
    DiffPair_float_0 _S179;
    (&_S179)->primal_0 = _S169;
    (&_S179)->differential_0 = 0.0f;
    DiffPair_float_0 _S180;
    (&_S180)->primal_0 = _S170;
    (&_S180)->differential_0 = 0.0f;
    DiffPair_float_0 _S181;
    (&_S181)->primal_0 = _S171;
    (&_S181)->differential_0 = 0.0f;
    DiffPair_float_0 _S182;
    (&_S182)->primal_0 = _S122;
    (&_S182)->differential_0 = _S110;
    DiffPair_float_0 _S183 = s_fwd_DistKBPolarSpline_cubic_0(&_S178, &_S179, &_S180, &_S181, &_S182);
    if(_S132)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S135;
    }
    if(_S132)
    {
        _S169 = 0.0f;
    }
    else
    {
        _S169 = _S136;
    }
    if(_S132)
    {
        _S170 = 0.0f;
    }
    else
    {
        _S170 = _S137;
    }
    if(_S132)
    {
        _S171 = 0.0f;
    }
    else
    {
        _S171 = _S138;
    }
    DiffPair_float_0 _S184;
    (&_S184)->primal_0 = theta_3;
    (&_S184)->differential_0 = 0.0f;
    DiffPair_float_0 _S185;
    (&_S185)->primal_0 = _S169;
    (&_S185)->differential_0 = 0.0f;
    DiffPair_float_0 _S186;
    (&_S186)->primal_0 = _S170;
    (&_S186)->differential_0 = 0.0f;
    DiffPair_float_0 _S187;
    (&_S187)->primal_0 = _S171;
    (&_S187)->differential_0 = 0.0f;
    DiffPair_float_0 _S188;
    (&_S188)->primal_0 = _S122;
    (&_S188)->differential_0 = _S110;
    DiffPair_float_0 _S189 = s_fwd_DistKBPolarSpline_cubic_0(&_S184, &_S185, &_S186, &_S187, &_S188);
    if(_S140)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S143;
    }
    if(_S140)
    {
        _S169 = 0.0f;
    }
    else
    {
        _S169 = _S144;
    }
    if(_S140)
    {
        _S170 = 0.0f;
    }
    else
    {
        _S170 = _S145;
    }
    if(_S140)
    {
        _S171 = 0.0f;
    }
    else
    {
        _S171 = _S146;
    }
    DiffPair_float_0 _S190;
    (&_S190)->primal_0 = theta_3;
    (&_S190)->differential_0 = 0.0f;
    DiffPair_float_0 _S191;
    (&_S191)->primal_0 = _S169;
    (&_S191)->differential_0 = 0.0f;
    DiffPair_float_0 _S192;
    (&_S192)->primal_0 = _S170;
    (&_S192)->differential_0 = 0.0f;
    DiffPair_float_0 _S193;
    (&_S193)->primal_0 = _S171;
    (&_S193)->differential_0 = 0.0f;
    DiffPair_float_0 _S194;
    (&_S194)->primal_0 = _S122;
    (&_S194)->differential_0 = _S110;
    DiffPair_float_0 _S195 = s_fwd_DistKBPolarSpline_cubic_0(&_S190, &_S191, &_S192, &_S193, &_S194);
    DiffPair_float_0 _S196;
    (&_S196)->primal_0 = _S177.primal_0;
    (&_S196)->differential_0 = _S177.differential_0;
    DiffPair_float_0 _S197;
    (&_S197)->primal_0 = _S183.primal_0;
    (&_S197)->differential_0 = _S183.differential_0;
    DiffPair_float_0 _S198;
    (&_S198)->primal_0 = _S189.primal_0;
    (&_S198)->differential_0 = _S189.differential_0;
    DiffPair_float_0 _S199;
    (&_S199)->primal_0 = _S195.primal_0;
    (&_S199)->differential_0 = _S195.differential_0;
    DiffPair_float_0 _S200;
    (&_S200)->primal_0 = _S147;
    (&_S200)->differential_0 = _S102.differential_0;
    DiffPair_float_0 _S201 = s_fwd_DistKBPolarSpline_cubic_0(&_S196, &_S197, &_S198, &_S199, &_S200);
    float2  _S202 = rt_1;
    *&((&_S202)->x) = _S201.primal_0;
    float2  _S203 = make_float2 (0.0f);
    *&((&_S203)->x) = _S201.differential_0;
    if(_S115)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S149;
    }
    if(_S115)
    {
        _S169 = 0.0f;
    }
    else
    {
        _S169 = _S150;
    }
    if(_S115)
    {
        _S170 = 0.0f;
    }
    else
    {
        _S170 = _S151;
    }
    if(_S115)
    {
        _S171 = 0.0f;
    }
    else
    {
        _S171 = _S152;
    }
    DiffPair_float_0 _S204;
    (&_S204)->primal_0 = theta_3;
    (&_S204)->differential_0 = 0.0f;
    DiffPair_float_0 _S205;
    (&_S205)->primal_0 = _S169;
    (&_S205)->differential_0 = 0.0f;
    DiffPair_float_0 _S206;
    (&_S206)->primal_0 = _S170;
    (&_S206)->differential_0 = 0.0f;
    DiffPair_float_0 _S207;
    (&_S207)->primal_0 = _S171;
    (&_S207)->differential_0 = 0.0f;
    DiffPair_float_0 _S208;
    (&_S208)->primal_0 = _S122;
    (&_S208)->differential_0 = _S110;
    DiffPair_float_0 _S209 = s_fwd_DistKBPolarSpline_cubic_0(&_S204, &_S205, &_S206, &_S207, &_S208);
    if(_S124)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S154;
    }
    if(_S124)
    {
        _S169 = 0.0f;
    }
    else
    {
        _S169 = _S155;
    }
    if(_S124)
    {
        _S170 = 0.0f;
    }
    else
    {
        _S170 = _S156;
    }
    if(_S124)
    {
        _S171 = 0.0f;
    }
    else
    {
        _S171 = _S157;
    }
    DiffPair_float_0 _S210;
    (&_S210)->primal_0 = theta_3;
    (&_S210)->differential_0 = 0.0f;
    DiffPair_float_0 _S211;
    (&_S211)->primal_0 = _S169;
    (&_S211)->differential_0 = 0.0f;
    DiffPair_float_0 _S212;
    (&_S212)->primal_0 = _S170;
    (&_S212)->differential_0 = 0.0f;
    DiffPair_float_0 _S213;
    (&_S213)->primal_0 = _S171;
    (&_S213)->differential_0 = 0.0f;
    DiffPair_float_0 _S214;
    (&_S214)->primal_0 = _S122;
    (&_S214)->differential_0 = _S110;
    DiffPair_float_0 _S215 = s_fwd_DistKBPolarSpline_cubic_0(&_S210, &_S211, &_S212, &_S213, &_S214);
    if(_S132)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S159;
    }
    if(_S132)
    {
        _S169 = 0.0f;
    }
    else
    {
        _S169 = _S160;
    }
    if(_S132)
    {
        _S170 = 0.0f;
    }
    else
    {
        _S170 = _S161;
    }
    if(_S132)
    {
        _S171 = 0.0f;
    }
    else
    {
        _S171 = _S162;
    }
    DiffPair_float_0 _S216;
    (&_S216)->primal_0 = theta_3;
    (&_S216)->differential_0 = 0.0f;
    DiffPair_float_0 _S217;
    (&_S217)->primal_0 = _S169;
    (&_S217)->differential_0 = 0.0f;
    DiffPair_float_0 _S218;
    (&_S218)->primal_0 = _S170;
    (&_S218)->differential_0 = 0.0f;
    DiffPair_float_0 _S219;
    (&_S219)->primal_0 = _S171;
    (&_S219)->differential_0 = 0.0f;
    DiffPair_float_0 _S220;
    (&_S220)->primal_0 = _S122;
    (&_S220)->differential_0 = _S110;
    DiffPair_float_0 _S221 = s_fwd_DistKBPolarSpline_cubic_0(&_S216, &_S217, &_S218, &_S219, &_S220);
    if(_S140)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S164;
    }
    if(_S140)
    {
        _S169 = 0.0f;
    }
    else
    {
        _S169 = _S165;
    }
    if(_S140)
    {
        _S170 = 0.0f;
    }
    else
    {
        _S170 = _S166;
    }
    if(_S140)
    {
        _S171 = 0.0f;
    }
    else
    {
        _S171 = _S167;
    }
    DiffPair_float_0 _S222;
    (&_S222)->primal_0 = theta_3;
    (&_S222)->differential_0 = 0.0f;
    DiffPair_float_0 _S223;
    (&_S223)->primal_0 = _S169;
    (&_S223)->differential_0 = 0.0f;
    DiffPair_float_0 _S224;
    (&_S224)->primal_0 = _S170;
    (&_S224)->differential_0 = 0.0f;
    DiffPair_float_0 _S225;
    (&_S225)->primal_0 = _S171;
    (&_S225)->differential_0 = 0.0f;
    DiffPair_float_0 _S226;
    (&_S226)->primal_0 = _S122;
    (&_S226)->differential_0 = _S110;
    DiffPair_float_0 _S227 = s_fwd_DistKBPolarSpline_cubic_0(&_S222, &_S223, &_S224, &_S225, &_S226);
    DiffPair_float_0 _S228;
    (&_S228)->primal_0 = _S209.primal_0;
    (&_S228)->differential_0 = _S209.differential_0;
    DiffPair_float_0 _S229;
    (&_S229)->primal_0 = _S215.primal_0;
    (&_S229)->differential_0 = _S215.differential_0;
    DiffPair_float_0 _S230;
    (&_S230)->primal_0 = _S221.primal_0;
    (&_S230)->differential_0 = _S221.differential_0;
    DiffPair_float_0 _S231;
    (&_S231)->primal_0 = _S227.primal_0;
    (&_S231)->differential_0 = _S227.differential_0;
    DiffPair_float_0 _S232;
    (&_S232)->primal_0 = _S147;
    (&_S232)->differential_0 = _S102.differential_0;
    DiffPair_float_0 _S233 = s_fwd_DistKBPolarSpline_cubic_0(&_S228, &_S229, &_S230, &_S231, &_S232);
    *&((&_S202)->y) = _S233.primal_0;
    *&((&_S203)->y) = _S233.differential_0;
    float _S234 = _S202.x;
    float _S235 = _S203.x;
    float _S236 = _S202.y;
    float _S237 = _S203.y;
    float2  _S238 = make_float2 (_S234 * _S105 - _S236 * _S103, _S234 * _S103 + _S236 * _S105);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S239 = { kb_1 + _S238 / make_float2 (_S102.primal_0) * _S168, s_diff_kb_0 + (make_float2 (_S235 * _S105 + _S106 * _S234 - (_S237 * _S103 + _S104 * _S236), _S235 * _S103 + _S104 * _S234 + (_S237 * _S105 + _S106 * _S236)) * make_float2 (_S102.primal_0) - _S238 * make_float2 (_S102.differential_0)) / make_float2 (_S102.primal_0 * _S102.primal_0) * _S168 };
    return _S239;
}

inline __device__ Matrix<float, 2, 2>  transpose_1(Matrix<float, 2, 2>  x_10)
{
    Matrix<float, 2, 2>  result_7;
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
        int c_2 = int(0);
        for(;;)
        {
            if(c_2 < int(2))
            {
            }
            else
            {
                break;
            }
            *_slang_vector_get_element_ptr(((&result_7)->rows + (r_1)), c_2) = _slang_vector_get_element(x_10.rows[c_2], r_1);
            c_2 = c_2 + int(1);
        }
        r_1 = r_1 + int(1);
    }
    return result_7;
}

inline __device__ float determinant_0(Matrix<float, 2, 2>  m_0)
{
    return m_0.rows[int(0)].x * m_0.rows[int(1)].y - m_0.rows[int(0)].y * m_0.rows[int(1)].x;
}

inline __device__ bool undistort_point_0(float2  uv_1, FixedArray<float, 58>  * dist_coeffs_0, int maxiter_0, float2  * uv_undist_0)
{
    int i_4 = int(0);
    float2  q_0 = uv_1;
    for(;;)
    {
        if(i_4 < maxiter_0)
        {
        }
        else
        {
            break;
        }
        float2  _S240 = DistKBPolarSpline_distort_0(q_0, dist_coeffs_0);
        float2  r_2 = _S240 - uv_1;
        float2  _S241 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S242;
        (&_S242)->primal_0 = q_0;
        (&_S242)->differential_0 = _S241;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S243 = s_fwd_DistKBPolarSpline_distort_0(&_S242, dist_coeffs_0);
        float2  _S244 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S245;
        (&_S245)->primal_0 = q_0;
        (&_S245)->differential_0 = _S244;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S246 = s_fwd_DistKBPolarSpline_distort_0(&_S245, dist_coeffs_0);
        Matrix<float, 2, 2>  _S247 = transpose_1(makeMatrix<float, 2, 2> (_S243.differential_0, _S246.differential_0));
        float inv_det_0 = 1.0f / (_S247.rows[int(0)].x * _S247.rows[int(1)].y - _S247.rows[int(0)].y * _S247.rows[int(1)].x);
        float _S248 = r_2.x;
        float _S249 = r_2.y;
        float2  q_1 = q_0 - make_float2 ((_S248 * _S247.rows[int(1)].y - _S249 * _S247.rows[int(0)].y) * inv_det_0, (- _S248 * _S247.rows[int(1)].x + _S249 * _S247.rows[int(0)].x) * inv_det_0);
        i_4 = i_4 + int(1);
        q_0 = q_1;
    }
    *uv_undist_0 = q_0;
    float2  _S250 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S251;
    (&_S251)->primal_0 = q_0;
    (&_S251)->differential_0 = _S250;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S252 = s_fwd_DistKBPolarSpline_distort_0(&_S251, dist_coeffs_0);
    float2  _S253 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S254;
    (&_S254)->primal_0 = q_0;
    (&_S254)->differential_0 = _S253;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S255 = s_fwd_DistKBPolarSpline_distort_0(&_S254, dist_coeffs_0);
    Matrix<float, 2, 2>  _S256 = transpose_1(makeMatrix<float, 2, 2> (_S252.differential_0, _S255.differential_0));
    float _S257 = (F32_min((determinant_0(_S256)), ((F32_min((_S256.rows[int(0)].x), (_S256.rows[int(1)].y))))));
    bool _S258;
    if(_S257 > 0.25f)
    {
        _S258 = _S257 < 4.0f;
    }
    else
    {
        _S258 = false;
    }
    if(_S258)
    {
        float2  _S259 = DistKBPolarSpline_distort_0(q_0, dist_coeffs_0);
        _S258 = (dot_1(q_0, _S259)) >= 0.0f;
    }
    else
    {
        _S258 = false;
    }
    if(_S258)
    {
        float2  _S260 = DistKBPolarSpline_distort_0(*uv_undist_0, dist_coeffs_0);
        _S258 = (length_0(_S260 - uv_1)) < 0.00999999977648258f;
    }
    else
    {
        _S258 = false;
    }
    return _S258;
}

inline __device__ float2  DistThinPrism_distort_0(float2  uv_2, FixedArray<float, 8>  * coeffs_2)
{
    float u_0 = uv_2.x;
    float v_0 = uv_2.y;
    float r2_1 = u_0 * u_0 + v_0 * v_0;
    return uv_2 * make_float2 (1.0f + r2_1 * ((*coeffs_2)[int(0)] + r2_1 * ((*coeffs_2)[int(1)] + r2_1 * ((*coeffs_2)[int(2)] + r2_1 * (*coeffs_2)[int(3)])))) + make_float2 (2.0f * (*coeffs_2)[int(4)] * u_0 * v_0 + (*coeffs_2)[int(5)] * (r2_1 + 2.0f * u_0 * u_0) + (*coeffs_2)[int(6)] * r2_1, 2.0f * (*coeffs_2)[int(5)] * u_0 * v_0 + (*coeffs_2)[int(4)] * (r2_1 + 2.0f * v_0 * v_0) + (*coeffs_2)[int(7)] * r2_1);
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistThinPrism_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_1, FixedArray<float, 8>  * coeffs_3)
{
    float u_1 = dpuv_1->primal_0.x;
    float s_diff_u_0 = dpuv_1->differential_0.x;
    float v_1 = dpuv_1->primal_0.y;
    float s_diff_v_0 = dpuv_1->differential_0.y;
    float _S261 = s_diff_u_0 * u_1;
    float _S262 = s_diff_v_0 * v_1;
    float r2_2 = u_1 * u_1 + v_1 * v_1;
    float s_diff_r2_0 = _S261 + _S261 + (_S262 + _S262);
    float _S263 = (*coeffs_3)[int(2)] + r2_2 * (*coeffs_3)[int(3)];
    float _S264 = (*coeffs_3)[int(1)] + r2_2 * _S263;
    float _S265 = (*coeffs_3)[int(0)] + r2_2 * _S264;
    float radial_1 = 1.0f + r2_2 * _S265;
    float _S266 = 2.0f * (*coeffs_3)[int(4)];
    float _S267 = _S266 * u_1;
    float _S268 = 2.0f * u_1;
    float _S269 = 2.0f * (*coeffs_3)[int(5)];
    float _S270 = _S269 * u_1;
    float _S271 = 2.0f * v_1;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S272 = { dpuv_1->primal_0 * make_float2 (radial_1) + make_float2 (_S267 * v_1 + (*coeffs_3)[int(5)] * (r2_2 + _S268 * u_1) + (*coeffs_3)[int(6)] * r2_2, _S270 * v_1 + (*coeffs_3)[int(4)] * (r2_2 + _S271 * v_1) + (*coeffs_3)[int(7)] * r2_2), dpuv_1->differential_0 * make_float2 (radial_1) + make_float2 (s_diff_r2_0 * _S265 + (s_diff_r2_0 * _S264 + (s_diff_r2_0 * _S263 + s_diff_r2_0 * (*coeffs_3)[int(3)] * r2_2) * r2_2) * r2_2) * dpuv_1->primal_0 + make_float2 (s_diff_u_0 * _S266 * v_1 + s_diff_v_0 * _S267 + (s_diff_r2_0 + (s_diff_u_0 * 2.0f * u_1 + s_diff_u_0 * _S268)) * (*coeffs_3)[int(5)] + s_diff_r2_0 * (*coeffs_3)[int(6)], s_diff_u_0 * _S269 * v_1 + s_diff_v_0 * _S270 + (s_diff_r2_0 + (s_diff_v_0 * 2.0f * v_1 + s_diff_v_0 * _S271)) * (*coeffs_3)[int(4)] + s_diff_r2_0 * (*coeffs_3)[int(7)]) };
    return _S272;
}

inline __device__ bool undistort_point_1(float2  uv_3, FixedArray<float, 8>  * dist_coeffs_1, int maxiter_1, float2  * uv_undist_1)
{
    int i_5 = int(0);
    float2  q_2 = uv_3;
    for(;;)
    {
        if(i_5 < maxiter_1)
        {
        }
        else
        {
            break;
        }
        float2  _S273 = DistThinPrism_distort_0(q_2, dist_coeffs_1);
        float2  r_3 = _S273 - uv_3;
        float2  _S274 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S275;
        (&_S275)->primal_0 = q_2;
        (&_S275)->differential_0 = _S274;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S276 = s_fwd_DistThinPrism_distort_0(&_S275, dist_coeffs_1);
        float2  _S277 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S278;
        (&_S278)->primal_0 = q_2;
        (&_S278)->differential_0 = _S277;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S279 = s_fwd_DistThinPrism_distort_0(&_S278, dist_coeffs_1);
        Matrix<float, 2, 2>  _S280 = transpose_1(makeMatrix<float, 2, 2> (_S276.differential_0, _S279.differential_0));
        float inv_det_1 = 1.0f / (_S280.rows[int(0)].x * _S280.rows[int(1)].y - _S280.rows[int(0)].y * _S280.rows[int(1)].x);
        float _S281 = r_3.x;
        float _S282 = r_3.y;
        float2  q_3 = q_2 - make_float2 ((_S281 * _S280.rows[int(1)].y - _S282 * _S280.rows[int(0)].y) * inv_det_1, (- _S281 * _S280.rows[int(1)].x + _S282 * _S280.rows[int(0)].x) * inv_det_1);
        i_5 = i_5 + int(1);
        q_2 = q_3;
    }
    *uv_undist_1 = q_2;
    float2  _S283 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S284;
    (&_S284)->primal_0 = q_2;
    (&_S284)->differential_0 = _S283;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S285 = s_fwd_DistThinPrism_distort_0(&_S284, dist_coeffs_1);
    float2  _S286 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S287;
    (&_S287)->primal_0 = q_2;
    (&_S287)->differential_0 = _S286;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S288 = s_fwd_DistThinPrism_distort_0(&_S287, dist_coeffs_1);
    Matrix<float, 2, 2>  _S289 = transpose_1(makeMatrix<float, 2, 2> (_S285.differential_0, _S288.differential_0));
    float _S290 = (F32_min((determinant_0(_S289)), ((F32_min((_S289.rows[int(0)].x), (_S289.rows[int(1)].y))))));
    bool _S291;
    if(_S290 > 0.25f)
    {
        _S291 = _S290 < 4.0f;
    }
    else
    {
        _S291 = false;
    }
    if(_S291)
    {
        float2  _S292 = DistThinPrism_distort_0(q_2, dist_coeffs_1);
        _S291 = (dot_1(q_2, _S292)) >= 0.0f;
    }
    else
    {
        _S291 = false;
    }
    if(_S291)
    {
        float2  _S293 = DistThinPrism_distort_0(*uv_undist_1, dist_coeffs_1);
        _S291 = (length_0(_S293 - uv_3)) < 0.00999999977648258f;
    }
    else
    {
        _S291 = false;
    }
    return _S291;
}

inline __device__ float2  DistOpenCV_distort_0(float2  uv_4, FixedArray<float, 4>  * coeffs_4)
{
    float u_2 = uv_4.x;
    float v_2 = uv_4.y;
    float r2_3 = u_2 * u_2 + v_2 * v_2;
    return uv_4 * make_float2 (1.0f + r2_3 * ((*coeffs_4)[int(0)] + r2_3 * (*coeffs_4)[int(1)])) + make_float2 (2.0f * (*coeffs_4)[int(2)] * u_2 * v_2 + (*coeffs_4)[int(3)] * (r2_3 + 2.0f * u_2 * u_2), 2.0f * (*coeffs_4)[int(3)] * u_2 * v_2 + (*coeffs_4)[int(2)] * (r2_3 + 2.0f * v_2 * v_2));
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistOpenCV_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_2, FixedArray<float, 4>  * coeffs_5)
{
    float u_3 = dpuv_2->primal_0.x;
    float s_diff_u_1 = dpuv_2->differential_0.x;
    float v_3 = dpuv_2->primal_0.y;
    float s_diff_v_1 = dpuv_2->differential_0.y;
    float _S294 = s_diff_u_1 * u_3;
    float _S295 = s_diff_v_1 * v_3;
    float r2_4 = u_3 * u_3 + v_3 * v_3;
    float s_diff_r2_1 = _S294 + _S294 + (_S295 + _S295);
    float _S296 = (*coeffs_5)[int(0)] + r2_4 * (*coeffs_5)[int(1)];
    float radial_2 = 1.0f + r2_4 * _S296;
    float _S297 = 2.0f * (*coeffs_5)[int(2)];
    float _S298 = _S297 * u_3;
    float _S299 = 2.0f * u_3;
    float _S300 = 2.0f * (*coeffs_5)[int(3)];
    float _S301 = _S300 * u_3;
    float _S302 = 2.0f * v_3;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S303 = { dpuv_2->primal_0 * make_float2 (radial_2) + make_float2 (_S298 * v_3 + (*coeffs_5)[int(3)] * (r2_4 + _S299 * u_3), _S301 * v_3 + (*coeffs_5)[int(2)] * (r2_4 + _S302 * v_3)), dpuv_2->differential_0 * make_float2 (radial_2) + make_float2 (s_diff_r2_1 * _S296 + s_diff_r2_1 * (*coeffs_5)[int(1)] * r2_4) * dpuv_2->primal_0 + make_float2 (s_diff_u_1 * _S297 * v_3 + s_diff_v_1 * _S298 + (s_diff_r2_1 + (s_diff_u_1 * 2.0f * u_3 + s_diff_u_1 * _S299)) * (*coeffs_5)[int(3)], s_diff_u_1 * _S300 * v_3 + s_diff_v_1 * _S301 + (s_diff_r2_1 + (s_diff_v_1 * 2.0f * v_3 + s_diff_v_1 * _S302)) * (*coeffs_5)[int(2)]) };
    return _S303;
}

inline __device__ bool undistort_point_2(float2  uv_5, FixedArray<float, 4>  * dist_coeffs_2, int maxiter_2, float2  * uv_undist_2)
{
    int i_6 = int(0);
    float2  q_4 = uv_5;
    for(;;)
    {
        if(i_6 < maxiter_2)
        {
        }
        else
        {
            break;
        }
        float2  _S304 = DistOpenCV_distort_0(q_4, dist_coeffs_2);
        float2  r_4 = _S304 - uv_5;
        float2  _S305 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S306;
        (&_S306)->primal_0 = q_4;
        (&_S306)->differential_0 = _S305;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S307 = s_fwd_DistOpenCV_distort_0(&_S306, dist_coeffs_2);
        float2  _S308 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S309;
        (&_S309)->primal_0 = q_4;
        (&_S309)->differential_0 = _S308;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S310 = s_fwd_DistOpenCV_distort_0(&_S309, dist_coeffs_2);
        Matrix<float, 2, 2>  _S311 = transpose_1(makeMatrix<float, 2, 2> (_S307.differential_0, _S310.differential_0));
        float inv_det_2 = 1.0f / (_S311.rows[int(0)].x * _S311.rows[int(1)].y - _S311.rows[int(0)].y * _S311.rows[int(1)].x);
        float _S312 = r_4.x;
        float _S313 = r_4.y;
        float2  q_5 = q_4 - make_float2 ((_S312 * _S311.rows[int(1)].y - _S313 * _S311.rows[int(0)].y) * inv_det_2, (- _S312 * _S311.rows[int(1)].x + _S313 * _S311.rows[int(0)].x) * inv_det_2);
        i_6 = i_6 + int(1);
        q_4 = q_5;
    }
    *uv_undist_2 = q_4;
    float2  _S314 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S315;
    (&_S315)->primal_0 = q_4;
    (&_S315)->differential_0 = _S314;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S316 = s_fwd_DistOpenCV_distort_0(&_S315, dist_coeffs_2);
    float2  _S317 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S318;
    (&_S318)->primal_0 = q_4;
    (&_S318)->differential_0 = _S317;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S319 = s_fwd_DistOpenCV_distort_0(&_S318, dist_coeffs_2);
    Matrix<float, 2, 2>  _S320 = transpose_1(makeMatrix<float, 2, 2> (_S316.differential_0, _S319.differential_0));
    float _S321 = (F32_min((determinant_0(_S320)), ((F32_min((_S320.rows[int(0)].x), (_S320.rows[int(1)].y))))));
    bool _S322;
    if(_S321 > 0.25f)
    {
        _S322 = _S321 < 4.0f;
    }
    else
    {
        _S322 = false;
    }
    if(_S322)
    {
        float2  _S323 = DistOpenCV_distort_0(q_4, dist_coeffs_2);
        _S322 = (dot_1(q_4, _S323)) >= 0.0f;
    }
    else
    {
        _S322 = false;
    }
    if(_S322)
    {
        float2  _S324 = DistOpenCV_distort_0(*uv_undist_2, dist_coeffs_2);
        _S322 = (length_0(_S324 - uv_5)) < 0.00999999977648258f;
    }
    else
    {
        _S322 = false;
    }
    return _S322;
}

inline __device__ bool undistort_point_3(float2  uv_6, FixedArray<float, 1>  * dist_coeffs_3, int maxiter_3, float2  * uv_undist_3)
{
    *uv_undist_3 = uv_6;
    return true;
}

inline __device__ float length_1(float3  x_11)
{
    return (F32_sqrt((dot_0(x_11, x_11))));
}

struct s_paramCtx_s_bwdCallableCtx_evaluate_color_3dgs_0
{
    float3  value0_6;
    Matrix<float, 3, 3>  value1_0;
    float3  value2_0;
    float3  value3_0;
};

struct s_bwdCallableCtx_evaluate_color_3dgs_0
{
    s_paramCtx_s_bwdCallableCtx_evaluate_color_3dgs_0 value0_7;
};

inline __device__ void s_bwdProp_evaluate_color_3dgs_0(s_bwdCallableCtx_evaluate_color_3dgs_0 * _S325, float3  * _S326, Matrix<float, 3, 3>  * _S327, float * _S328, float3  * _S329, float3  * _S330, float3  * _S331, float3  _S332, float _S333)
{
    float3  _S334 = (&_S325->value0_7)->value2_0 - (&_S325->value0_7)->value0_6;
    Tuple_3 _S335 = s_apply_mul_0((&_S325->value0_7)->value1_0, _S334);
    s_bwdCallableCtx_mul_0 _S336;
    (&_S336)->_S30 = (&_S325->value0_7)->value1_0;
    (&_S336)->_S31 = _S334;
    Tuple_3 _S337 = s_apply_mul_0((&_S325->value0_7)->value1_0, (&_S325->value0_7)->value3_0);
    s_bwdCallableCtx_mul_0 _S338;
    (&_S338)->_S30 = (&_S325->value0_7)->value1_0;
    (&_S338)->_S31 = (&_S325->value0_7)->value3_0;
    Tuple_1 _S339 = s_apply_dot_0(_S335.value0_3, _S337.value0_3);
    s_bwdCallableCtx_dot_0 _S340;
    (&_S340)->_S6 = _S335.value0_3;
    (&_S340)->_S7 = _S337.value0_3;
    float _S341 = - _S339.value0_1;
    Tuple_1 _S342 = s_apply_dot_0(_S337.value0_3, _S337.value0_3);
    s_bwdCallableCtx_dot_0 _S343;
    (&_S343)->_S6 = _S337.value0_3;
    (&_S343)->_S7 = _S337.value0_3;
    float _S344 = _S333 / (_S342.value0_1 * _S342.value0_1);
    float _S345 = _S341 * - _S344;
    float _S346 = _S342.value0_1 * _S344;
    float3  _S347 = make_float3 (0.0f);
    float3  _S348 = _S347;
    float3  _S349 = _S347;
    s_bwdCallableCtx_dot_0 _S350 = _S343;
    s_bwdProp_dot_0(&_S350, &_S348, &_S349, _S345);
    float _S351 = - _S346;
    float3  _S352 = _S347;
    float3  _S353 = _S347;
    s_bwdCallableCtx_dot_0 _S354 = _S340;
    s_bwdProp_dot_0(&_S354, &_S352, &_S353, _S351);
    float3  _S355 = _S348 + _S349 + _S353;
    Matrix<float, 3, 3>  _S356 = makeMatrix<float, 3, 3> (0.0f);
    Matrix<float, 3, 3>  _S357 = _S356;
    float3  _S358 = _S347;
    s_bwdCallableCtx_mul_0 _S359 = _S338;
    s_bwdProp_mul_0(&_S359, &_S357, &_S358, _S355);
    Matrix<float, 3, 3>  _S360 = _S356;
    float3  _S361 = _S347;
    s_bwdCallableCtx_mul_0 _S362 = _S336;
    s_bwdProp_mul_0(&_S362, &_S360, &_S361, _S352);
    Matrix<float, 3, 3>  _S363 = _S357 + _S360;
    *_S326 = - _S361;
    *_S327 = _S363;
    *_S328 = 0.0f;
    *_S329 = _S332;
    *_S330 = _S361;
    *_S331 = _S358;
    return;
}

inline __device__ void _S364(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S365, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S366, DiffPair_float_0 * _S367, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S368, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S369, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S370, float3  _S371, float _S372)
{
    s_paramCtx_s_bwdCallableCtx_evaluate_color_3dgs_0 _S373;
    (&_S373)->value0_6 = _S365->primal_0;
    (&_S373)->value1_0 = _S366->primal_0;
    (&_S373)->value2_0 = _S369->primal_0;
    (&_S373)->value3_0 = _S370->primal_0;
    s_bwdCallableCtx_evaluate_color_3dgs_0 _S374;
    (&_S374)->value0_7 = _S373;
    s_bwdProp_evaluate_color_3dgs_0(&_S374, &_S365->differential_0, &_S366->differential_0, &_S367->differential_0, &_S368->differential_0, &_S369->differential_0, &_S370->differential_0, _S371, _S372);
    return;
}

struct s_paramCtx_s_bwdCallableCtx_evaluate_alpha_3dgs_0
{
    float3  value0_8;
    Matrix<float, 3, 3>  value1_1;
    float value2_1;
    float3  value3_1;
    float3  value4_0;
};

struct s_bwdCallableCtx_evaluate_alpha_3dgs_0
{
    s_paramCtx_s_bwdCallableCtx_evaluate_alpha_3dgs_0 value0_9;
};

inline __device__ void s_bwdProp_evaluate_alpha_3dgs_0(s_bwdCallableCtx_evaluate_alpha_3dgs_0 * _S375, float3  * _S376, Matrix<float, 3, 3>  * _S377, float * _S378, float3  * _S379, float3  * _S380, float _S381)
{
    float3  _S382 = (&_S375->value0_9)->value3_1 - (&_S375->value0_9)->value0_8;
    Tuple_3 _S383 = s_apply_mul_0((&_S375->value0_9)->value1_1, _S382);
    s_bwdCallableCtx_mul_0 _S384;
    (&_S384)->_S30 = (&_S375->value0_9)->value1_1;
    (&_S384)->_S31 = _S382;
    Tuple_3 _S385 = s_apply_mul_0((&_S375->value0_9)->value1_1, (&_S375->value0_9)->value4_0);
    s_bwdCallableCtx_mul_0 _S386;
    (&_S386)->_S30 = (&_S375->value0_9)->value1_1;
    (&_S386)->_S31 = (&_S375->value0_9)->value4_0;
    Tuple_2 _S387 = s_apply_cross_0(_S385.value0_3, _S383.value0_3);
    s_bwdCallableCtx_cross_0 _S388;
    (&_S388)->_S17 = _S385.value0_3;
    (&_S388)->_S18 = _S383.value0_3;
    Tuple_1 _S389 = s_apply_dot_0(_S387.value0_2, _S387.value0_2);
    s_bwdCallableCtx_dot_0 _S390;
    (&_S390)->_S6 = _S387.value0_2;
    (&_S390)->_S7 = _S387.value0_2;
    float _S391 = -0.5f * _S389.value0_1;
    Tuple_1 _S392 = s_apply_dot_0(_S385.value0_3, _S385.value0_3);
    s_bwdCallableCtx_dot_0 _S393;
    (&_S393)->_S6 = _S385.value0_3;
    (&_S393)->_S7 = _S385.value0_3;
    float _S394 = _S391 / _S392.value0_1;
    float _S395 = _S392.value0_1 * _S392.value0_1;
    Tuple_0 _S396 = s_apply_exp_0(_S394);
    s_bwdCallableCtx_exp_0 _S397;
    (&_S397)->_S2 = _S394;
    float _S398 = (&_S375->value0_9)->value2_1 * _S381;
    float _S399 = _S396.value0_0 * _S381;
    float _S400 = 0.0f;
    s_bwdCallableCtx_exp_0 _S401 = _S397;
    s_bwdProp_exp_0(&_S401, &_S400, _S398);
    float _S402 = _S400 / _S395;
    float _S403 = _S391 * - _S402;
    float _S404 = _S392.value0_1 * _S402;
    float3  _S405 = make_float3 (0.0f);
    float3  _S406 = _S405;
    float3  _S407 = _S405;
    s_bwdCallableCtx_dot_0 _S408 = _S393;
    s_bwdProp_dot_0(&_S408, &_S406, &_S407, _S403);
    float _S409 = -0.5f * _S404;
    float3  _S410 = _S405;
    float3  _S411 = _S405;
    s_bwdCallableCtx_dot_0 _S412 = _S390;
    s_bwdProp_dot_0(&_S412, &_S410, &_S411, _S409);
    float3  _S413 = _S410 + _S411;
    float3  _S414 = _S405;
    float3  _S415 = _S405;
    s_bwdCallableCtx_cross_0 _S416 = _S388;
    s_bwdProp_cross_0(&_S416, &_S414, &_S415, _S413);
    float3  _S417 = _S406 + _S407 + _S414;
    Matrix<float, 3, 3>  _S418 = makeMatrix<float, 3, 3> (0.0f);
    Matrix<float, 3, 3>  _S419 = _S418;
    float3  _S420 = _S405;
    s_bwdCallableCtx_mul_0 _S421 = _S386;
    s_bwdProp_mul_0(&_S421, &_S419, &_S420, _S417);
    Matrix<float, 3, 3>  _S422 = _S418;
    float3  _S423 = _S405;
    s_bwdCallableCtx_mul_0 _S424 = _S384;
    s_bwdProp_mul_0(&_S424, &_S422, &_S423, _S415);
    Matrix<float, 3, 3>  _S425 = _S419 + _S422;
    *_S376 = - _S423;
    *_S377 = _S425;
    *_S378 = _S399;
    *_S379 = _S423;
    *_S380 = _S420;
    return;
}

inline __device__ void _S426(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S427, DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S428, DiffPair_float_0 * _S429, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S430, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S431, float _S432)
{
    s_paramCtx_s_bwdCallableCtx_evaluate_alpha_3dgs_0 _S433;
    (&_S433)->value0_8 = _S427->primal_0;
    (&_S433)->value1_1 = _S428->primal_0;
    (&_S433)->value2_1 = _S429->primal_0;
    (&_S433)->value3_1 = _S430->primal_0;
    (&_S433)->value4_0 = _S431->primal_0;
    s_bwdCallableCtx_evaluate_alpha_3dgs_0 _S434;
    (&_S434)->value0_9 = _S433;
    s_bwdProp_evaluate_alpha_3dgs_0(&_S434, &_S427->differential_0, &_S428->differential_0, &_S429->differential_0, &_S430->differential_0, &_S431->differential_0, _S432);
    return;
}

struct DiffPair_vectorx3Cfloatx2C4x3E_0
{
    float4  primal_0;
    float4  differential_0;
};

struct s_paramCtx_s_bwdCallableCtx_compute_3dgut_iscl_rot_0
{
    float4  value0_10;
    float3  value1_2;
};

struct s_bwdCallableCtx_compute_3dgut_iscl_rot_0
{
    s_paramCtx_s_bwdCallableCtx_compute_3dgut_iscl_rot_0 value0_11;
};

struct Tuple_6
{
    Matrix<float, 3, 3>  value0_12;
};

inline __device__ Tuple_6 s_apply_normalized_quat_to_rotmat_0(float4  _S435)
{
    float _S436 = _S435.y;
    float x2_0 = _S436 * _S436;
    float y2_0 = _S435.z * _S435.z;
    float z2_0 = _S435.w * _S435.w;
    float xy_0 = _S435.y * _S435.z;
    float xz_0 = _S435.y * _S435.w;
    float yz_0 = _S435.z * _S435.w;
    float wx_0 = _S435.x * _S435.y;
    float wy_0 = _S435.x * _S435.z;
    float wz_0 = _S435.x * _S435.w;
    Tuple_6 _S437;
    (&_S437)->value0_12 = s_apply_transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_0 + z2_0), 2.0f * (xy_0 + wz_0), 2.0f * (xz_0 - wy_0), 2.0f * (xy_0 - wz_0), 1.0f - 2.0f * (x2_0 + z2_0), 2.0f * (yz_0 + wx_0), 2.0f * (xz_0 + wy_0), 2.0f * (yz_0 - wx_0), 1.0f - 2.0f * (x2_0 + y2_0))).value0_4;
    return _S437;
}

struct s_paramCtx_s_bwdCallableCtx_normalized_quat_to_rotmat_0
{
    float4  value0_13;
};

struct s_bwdCallableCtx_normalized_quat_to_rotmat_0
{
    s_paramCtx_s_bwdCallableCtx_normalized_quat_to_rotmat_0 value0_14;
};

inline __device__ void s_bwdProp_normalized_quat_to_rotmat_0(s_bwdCallableCtx_normalized_quat_to_rotmat_0 * _S438, float4  * _S439, Matrix<float, 3, 3>  _S440)
{
    float x2_1 = *&((&(&_S438->value0_14)->value0_13)->y) * *&((&(&_S438->value0_14)->value0_13)->y);
    float y2_1 = *&((&(&_S438->value0_14)->value0_13)->z) * *&((&(&_S438->value0_14)->value0_13)->z);
    float z2_1 = *&((&(&_S438->value0_14)->value0_13)->w) * *&((&(&_S438->value0_14)->value0_13)->w);
    float xy_1 = *&((&(&_S438->value0_14)->value0_13)->y) * *&((&(&_S438->value0_14)->value0_13)->z);
    float xz_1 = *&((&(&_S438->value0_14)->value0_13)->y) * *&((&(&_S438->value0_14)->value0_13)->w);
    float yz_1 = *&((&(&_S438->value0_14)->value0_13)->z) * *&((&(&_S438->value0_14)->value0_13)->w);
    float wx_1 = *&((&(&_S438->value0_14)->value0_13)->x) * *&((&(&_S438->value0_14)->value0_13)->y);
    float wy_1 = *&((&(&_S438->value0_14)->value0_13)->x) * *&((&(&_S438->value0_14)->value0_13)->z);
    float wz_1 = *&((&(&_S438->value0_14)->value0_13)->x) * *&((&(&_S438->value0_14)->value0_13)->w);
    s_bwdCallableCtx_transpose_0 _S441;
    (&_S441)->_S42 = makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_1 + z2_1), 2.0f * (xy_1 + wz_1), 2.0f * (xz_1 - wy_1), 2.0f * (xy_1 - wz_1), 1.0f - 2.0f * (x2_1 + z2_1), 2.0f * (yz_1 + wx_1), 2.0f * (xz_1 + wy_1), 2.0f * (yz_1 - wx_1), 1.0f - 2.0f * (x2_1 + y2_1));
    Matrix<float, 3, 3>  _S442 = makeMatrix<float, 3, 3> (0.0f);
    s_bwdCallableCtx_transpose_0 _S443 = _S441;
    s_bwdProp_transpose_0(&_S443, &_S442, _S440);
    float _S444 = 2.0f * - _S442.rows[int(2)].z;
    float _S445 = 2.0f * _S442.rows[int(2)].y;
    float _S446 = 2.0f * _S442.rows[int(2)].x;
    float _S447 = 2.0f * _S442.rows[int(1)].z;
    float _S448 = 2.0f * - _S442.rows[int(1)].y;
    float _S449 = 2.0f * _S442.rows[int(1)].x;
    float _S450 = 2.0f * _S442.rows[int(0)].z;
    float _S451 = 2.0f * _S442.rows[int(0)].y;
    float _S452 = 2.0f * - _S442.rows[int(0)].x;
    float _S453 = - _S449 + _S451;
    float _S454 = _S446 + - _S450;
    float _S455 = - _S445 + _S447;
    float _S456 = _S445 + _S447;
    float _S457 = _S446 + _S450;
    float _S458 = _S449 + _S451;
    float _S459 = *&((&(&_S438->value0_14)->value0_13)->w) * (_S448 + _S452);
    float _S460 = *&((&(&_S438->value0_14)->value0_13)->z) * (_S444 + _S452);
    float _S461 = *&((&(&_S438->value0_14)->value0_13)->y) * (_S444 + _S448);
    float _S462 = *&((&(&_S438->value0_14)->value0_13)->x) * _S453 + *&((&(&_S438->value0_14)->value0_13)->z) * _S456 + *&((&(&_S438->value0_14)->value0_13)->y) * _S457 + _S459 + _S459;
    float _S463 = *&((&(&_S438->value0_14)->value0_13)->x) * _S454 + *&((&(&_S438->value0_14)->value0_13)->w) * _S456 + *&((&(&_S438->value0_14)->value0_13)->y) * _S458 + _S460 + _S460;
    float _S464 = *&((&(&_S438->value0_14)->value0_13)->x) * _S455 + *&((&(&_S438->value0_14)->value0_13)->w) * _S457 + *&((&(&_S438->value0_14)->value0_13)->z) * _S458 + _S461 + _S461;
    float _S465 = *&((&(&_S438->value0_14)->value0_13)->w) * _S453 + *&((&(&_S438->value0_14)->value0_13)->z) * _S454 + *&((&(&_S438->value0_14)->value0_13)->y) * _S455;
    float4  _S466 = make_float4 (0.0f);
    *&((&_S466)->w) = _S462;
    *&((&_S466)->z) = _S463;
    *&((&_S466)->y) = _S464;
    *&((&_S466)->x) = _S465;
    *_S439 = _S466;
    return;
}

inline __device__ void s_bwdProp_compute_3dgut_iscl_rot_0(s_bwdCallableCtx_compute_3dgut_iscl_rot_0 * _S467, float4  * _S468, float3  * _S469, Matrix<float, 3, 3>  _S470)
{
    Tuple_6 _S471 = s_apply_normalized_quat_to_rotmat_0((&_S467->value0_11)->value0_10);
    s_paramCtx_s_bwdCallableCtx_normalized_quat_to_rotmat_0 _S472;
    (&_S472)->value0_13 = (&_S467->value0_11)->value0_10;
    float3  _S473 = - (&_S467->value0_11)->value1_2;
    Tuple_5 _S474 = s_apply_exp_1(_S473);
    s_bwdCallableCtx_exp_1 _S475;
    (&_S475)->_S46 = _S473;
    Matrix<float, 3, 3>  S_0 = makeMatrix<float, 3, 3> (_S474.value0_5.x, 0.0f, 0.0f, 0.0f, _S474.value0_5.y, 0.0f, 0.0f, 0.0f, _S474.value0_5.z);
    Tuple_4 _S476 = s_apply_transpose_0(_S471.value0_12);
    s_bwdCallableCtx_transpose_0 _S477;
    (&_S477)->_S42 = _S471.value0_12;
    s_bwdCallableCtx_mul_1 _S478;
    (&_S478)->_S37 = S_0;
    (&_S478)->_S38 = _S476.value0_4;
    Matrix<float, 3, 3>  _S479 = makeMatrix<float, 3, 3> (0.0f);
    Matrix<float, 3, 3>  _S480 = _S479;
    Matrix<float, 3, 3>  _S481 = _S479;
    s_bwdCallableCtx_mul_1 _S482 = _S478;
    s_bwdProp_mul_1(&_S482, &_S480, &_S481, _S470);
    Matrix<float, 3, 3>  _S483 = _S479;
    s_bwdCallableCtx_transpose_0 _S484 = _S477;
    s_bwdProp_transpose_0(&_S484, &_S483, _S481);
    float3  _S485 = make_float3 (_S480.rows[int(0)].x, _S480.rows[int(1)].y, _S480.rows[int(2)].z);
    float3  _S486 = make_float3 (0.0f);
    s_bwdCallableCtx_exp_1 _S487 = _S475;
    s_bwdProp_exp_1(&_S487, &_S486, _S485);
    float3  _S488 = - _S486;
    float4  _S489 = make_float4 (0.0f);
    s_bwdCallableCtx_normalized_quat_to_rotmat_0 _S490;
    (&_S490)->value0_14 = _S472;
    s_bwdProp_normalized_quat_to_rotmat_0(&_S490, &_S489, _S483);
    *_S468 = _S489;
    *_S469 = _S488;
    return;
}

inline __device__ void _S491(DiffPair_vectorx3Cfloatx2C4x3E_0 * _S492, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S493, Matrix<float, 3, 3>  _S494)
{
    s_paramCtx_s_bwdCallableCtx_compute_3dgut_iscl_rot_0 _S495;
    (&_S495)->value0_10 = _S492->primal_0;
    (&_S495)->value1_2 = _S493->primal_0;
    s_bwdCallableCtx_compute_3dgut_iscl_rot_0 _S496;
    (&_S496)->value0_11 = _S495;
    s_bwdProp_compute_3dgut_iscl_rot_0(&_S496, &_S492->differential_0, &_S493->differential_0, _S494);
    return;
}

struct s_paramCtx_s_bwdCallableCtx_transform_ray_d_0
{
    Matrix<float, 3, 3>  value0_15;
    float3  value1_3;
};

struct s_bwdCallableCtx_transform_ray_d_0
{
    s_paramCtx_s_bwdCallableCtx_transform_ray_d_0 value0_16;
};

inline __device__ void s_bwdProp_transform_ray_d_0(s_bwdCallableCtx_transform_ray_d_0 * _S497, Matrix<float, 3, 3>  * _S498, float3  * _S499, float3  _S500)
{
    s_bwdCallableCtx_mul_2 _S501;
    (&_S501)->_S49 = (&_S497->value0_16)->value1_3;
    (&_S501)->_S50 = (&_S497->value0_16)->value0_15;
    float3  _S502 = make_float3 (0.0f);
    Matrix<float, 3, 3>  _S503 = makeMatrix<float, 3, 3> (0.0f);
    s_bwdCallableCtx_mul_2 _S504 = _S501;
    s_bwdProp_mul_2(&_S504, &_S502, &_S503, _S500);
    *_S498 = _S503;
    *_S499 = _S502;
    return;
}

inline __device__ void _S505(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S506, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S507, float3  _S508)
{
    s_paramCtx_s_bwdCallableCtx_transform_ray_d_0 _S509;
    (&_S509)->value0_15 = _S506->primal_0;
    (&_S509)->value1_3 = _S507->primal_0;
    s_bwdCallableCtx_transform_ray_d_0 _S510;
    (&_S510)->value0_16 = _S509;
    s_bwdProp_transform_ray_d_0(&_S510, &_S506->differential_0, &_S507->differential_0, _S508);
    return;
}

struct s_paramCtx_s_bwdCallableCtx_transform_ray_o_0
{
    Matrix<float, 3, 3>  value0_17;
    float3  value1_4;
};

struct s_bwdCallableCtx_transform_ray_o_0
{
    s_paramCtx_s_bwdCallableCtx_transform_ray_o_0 value0_18;
};

inline __device__ void s_bwdProp_transform_ray_o_0(s_bwdCallableCtx_transform_ray_o_0 * _S511, Matrix<float, 3, 3>  * _S512, float3  * _S513, float3  _S514)
{
    s_bwdCallableCtx_mul_2 _S515;
    (&_S515)->_S49 = (&_S511->value0_18)->value1_4;
    (&_S515)->_S50 = (&_S511->value0_18)->value0_17;
    float3  _S516 = - _S514;
    float3  _S517 = make_float3 (0.0f);
    Matrix<float, 3, 3>  _S518 = makeMatrix<float, 3, 3> (0.0f);
    s_bwdCallableCtx_mul_2 _S519 = _S515;
    s_bwdProp_mul_2(&_S519, &_S517, &_S518, _S516);
    *_S512 = _S518;
    *_S513 = _S517;
    return;
}

inline __device__ void _S520(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * _S521, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S522, float3  _S523)
{
    s_paramCtx_s_bwdCallableCtx_transform_ray_o_0 _S524;
    (&_S524)->value0_17 = _S521->primal_0;
    (&_S524)->value1_4 = _S522->primal_0;
    s_bwdCallableCtx_transform_ray_o_0 _S525;
    (&_S525)->value0_18 = _S524;
    s_bwdProp_transform_ray_o_0(&_S525, &_S521->differential_0, &_S522->differential_0, _S523);
    return;
}

inline __device__ float3  mul_2(float3  left_7, Matrix<float, 3, 3>  right_7)
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
        float sum_14 = 0.0f;
        for(;;)
        {
            if(i_7 < int(3))
            {
            }
            else
            {
                break;
            }
            float sum_15 = sum_14 + _slang_vector_get_element(left_7, i_7) * _slang_vector_get_element(right_7.rows[i_7], j_1);
            i_7 = i_7 + int(1);
            sum_14 = sum_15;
        }
        *_slang_vector_get_element_ptr(&result_8, j_1) = sum_14;
        j_1 = j_1 + int(1);
    }
    return result_8;
}

inline __device__ float3  normalize_0(float3  x_12)
{
    return x_12 / make_float3 (length_1(x_12));
}

inline __device__ DiffPair_float_0 _d_sin_0(DiffPair_float_0 * dpx_7)
{
    DiffPair_float_0 _S526 = { (F32_sin((dpx_7->primal_0))), (F32_cos((dpx_7->primal_0))) * dpx_7->differential_0 };
    return _S526;
}

inline __device__ Matrix<float, 3, 3>  mul_3(Matrix<float, 3, 3>  left_8, Matrix<float, 3, 3>  right_8)
{
    Matrix<float, 3, 3>  result_9;
    int r_5 = int(0);
    for(;;)
    {
        if(r_5 < int(3))
        {
        }
        else
        {
            break;
        }
        int c_3 = int(0);
        for(;;)
        {
            if(c_3 < int(3))
            {
            }
            else
            {
                break;
            }
            int i_8 = int(0);
            float sum_16 = 0.0f;
            for(;;)
            {
                if(i_8 < int(3))
                {
                }
                else
                {
                    break;
                }
                float sum_17 = sum_16 + _slang_vector_get_element(left_8.rows[r_5], i_8) * _slang_vector_get_element(right_8.rows[i_8], c_3);
                i_8 = i_8 + int(1);
                sum_16 = sum_17;
            }
            *_slang_vector_get_element_ptr(((&result_9)->rows + (r_5)), c_3) = sum_16;
            c_3 = c_3 + int(1);
        }
        r_5 = r_5 + int(1);
    }
    return result_9;
}

inline __device__ Matrix<float, 3, 3>  normalized_quat_to_rotmat(float4  quat_0)
{
    float x_13 = quat_0.y;
    float x2_2 = x_13 * x_13;
    float y2_2 = quat_0.z * quat_0.z;
    float z2_2 = quat_0.w * quat_0.w;
    float xy_2 = quat_0.y * quat_0.z;
    float xz_2 = quat_0.y * quat_0.w;
    float yz_2 = quat_0.z * quat_0.w;
    float wx_2 = quat_0.x * quat_0.y;
    float wy_2 = quat_0.x * quat_0.z;
    float wz_2 = quat_0.x * quat_0.w;
    return transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_2 + z2_2), 2.0f * (xy_2 + wz_2), 2.0f * (xz_2 - wy_2), 2.0f * (xy_2 - wz_2), 1.0f - 2.0f * (x2_2 + z2_2), 2.0f * (yz_2 + wx_2), 2.0f * (xz_2 + wy_2), 2.0f * (yz_2 - wx_2), 1.0f - 2.0f * (x2_2 + y2_2)));
}

inline __device__ void quat_scale_to_covar(float4  quat_1, float3  scale_0, Matrix<float, 3, 3>  * covar_0)
{
    float x_14 = quat_1.y;
    float x2_3 = x_14 * x_14;
    float y2_3 = quat_1.z * quat_1.z;
    float z2_3 = quat_1.w * quat_1.w;
    float xy_3 = quat_1.y * quat_1.z;
    float xz_3 = quat_1.y * quat_1.w;
    float yz_3 = quat_1.z * quat_1.w;
    float wx_3 = quat_1.x * quat_1.y;
    float wy_3 = quat_1.x * quat_1.z;
    float wz_3 = quat_1.x * quat_1.w;
    Matrix<float, 3, 3>  M_0 = mul_3(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_3 + z2_3), 2.0f * (xy_3 + wz_3), 2.0f * (xz_3 - wy_3), 2.0f * (xy_3 - wz_3), 1.0f - 2.0f * (x2_3 + z2_3), 2.0f * (yz_3 + wx_3), 2.0f * (xz_3 + wy_3), 2.0f * (yz_3 - wx_3), 1.0f - 2.0f * (x2_3 + y2_3))), makeMatrix<float, 3, 3> (scale_0.x, 0.0f, 0.0f, 0.0f, scale_0.y, 0.0f, 0.0f, 0.0f, scale_0.z));
    *covar_0 = mul_3(M_0, transpose_0(M_0));
    return;
}

inline __device__ void quat_scale_to_sqrt_covar(float4  quat_2, float3  scale_1, Matrix<float, 3, 3>  * M_1)
{
    float x_15 = quat_2.y;
    float x2_4 = x_15 * x_15;
    float y2_4 = quat_2.z * quat_2.z;
    float z2_4 = quat_2.w * quat_2.w;
    float xy_4 = quat_2.y * quat_2.z;
    float xz_4 = quat_2.y * quat_2.w;
    float yz_4 = quat_2.z * quat_2.w;
    float wx_4 = quat_2.x * quat_2.y;
    float wy_4 = quat_2.x * quat_2.z;
    float wz_4 = quat_2.x * quat_2.w;
    *M_1 = mul_3(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_4 + z2_4), 2.0f * (xy_4 + wz_4), 2.0f * (xz_4 - wy_4), 2.0f * (xy_4 - wz_4), 1.0f - 2.0f * (x2_4 + z2_4), 2.0f * (yz_4 + wx_4), 2.0f * (xz_4 + wy_4), 2.0f * (yz_4 - wx_4), 1.0f - 2.0f * (x2_4 + y2_4))), makeMatrix<float, 3, 3> (scale_1.x, 0.0f, 0.0f, 0.0f, scale_1.y, 0.0f, 0.0f, 0.0f, scale_1.z));
    return;
}

inline __device__ float3  apply_sqrt_covar_to_vec(float4  quat_3, float3  scale_2, float3  vec_0)
{
    float x_16 = quat_3.y;
    float x2_5 = x_16 * x_16;
    float y2_5 = quat_3.z * quat_3.z;
    float z2_5 = quat_3.w * quat_3.w;
    float xy_5 = quat_3.y * quat_3.z;
    float xz_5 = quat_3.y * quat_3.w;
    float yz_5 = quat_3.z * quat_3.w;
    float wx_5 = quat_3.x * quat_3.y;
    float wy_5 = quat_3.x * quat_3.z;
    float wz_5 = quat_3.x * quat_3.w;
    return mul_0(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_5 + z2_5), 2.0f * (xy_5 + wz_5), 2.0f * (xz_5 - wy_5), 2.0f * (xy_5 - wz_5), 1.0f - 2.0f * (x2_5 + z2_5), 2.0f * (yz_5 + wx_5), 2.0f * (xz_5 + wy_5), 2.0f * (yz_5 - wx_5), 1.0f - 2.0f * (x2_5 + y2_5))), scale_2 * vec_0);
}

inline __device__ float3  apply_covar_to_vec(float4  quat_4, float3  scale_3, float3  vec_1)
{
    float x_17 = quat_4.y;
    float x2_6 = x_17 * x_17;
    float y2_6 = quat_4.z * quat_4.z;
    float z2_6 = quat_4.w * quat_4.w;
    float xy_6 = quat_4.y * quat_4.z;
    float xz_6 = quat_4.y * quat_4.w;
    float yz_6 = quat_4.z * quat_4.w;
    float wx_6 = quat_4.x * quat_4.y;
    float wy_6 = quat_4.x * quat_4.z;
    float wz_6 = quat_4.x * quat_4.w;
    Matrix<float, 3, 3>  M_2 = mul_3(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_6 + z2_6), 2.0f * (xy_6 + wz_6), 2.0f * (xz_6 - wy_6), 2.0f * (xy_6 - wz_6), 1.0f - 2.0f * (x2_6 + z2_6), 2.0f * (yz_6 + wx_6), 2.0f * (xz_6 + wy_6), 2.0f * (yz_6 - wx_6), 1.0f - 2.0f * (x2_6 + y2_6))), makeMatrix<float, 3, 3> (scale_3.x, 0.0f, 0.0f, 0.0f, scale_3.y, 0.0f, 0.0f, 0.0f, scale_3.z));
    return mul_0(mul_3(M_2, transpose_0(M_2)), vec_1);
}

inline __device__ bool equirect_proj_nav(float3  p_view_0, float4  intrins_0, float2  * uv_7)
{
    *uv_7 = make_float2 (intrins_0.x * (F32_atan2((p_view_0.x), (p_view_0.z))) + intrins_0.z, intrins_0.y * (F32_atan2((p_view_0.y), (length_0(float2 {p_view_0.x, p_view_0.z})))) + intrins_0.w);
    return true;
}

inline __device__ Matrix<float, 2, 3>  equirect_proj_jac(float3  p_view_1, float4  intrins_1)
{
    float _S527 = p_view_1.x;
    float _S528 = p_view_1.z;
    DiffPair_float_0 _S529;
    (&_S529)->primal_0 = _S527;
    (&_S529)->differential_0 = 1.0f;
    DiffPair_float_0 _S530;
    (&_S530)->primal_0 = _S528;
    (&_S530)->differential_0 = 0.0f;
    DiffPair_float_0 _S531 = _d_atan2_0(&_S529, &_S530);
    float _S532 = p_view_1.y;
    float2  _S533 = float2 {p_view_1.x, p_view_1.z};
    float2  _S534 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S535;
    (&_S535)->primal_0 = _S533;
    (&_S535)->differential_0 = _S534;
    DiffPair_float_0 _S536 = s_fwd_length_impl_0(&_S535);
    DiffPair_float_0 _S537;
    (&_S537)->primal_0 = _S532;
    (&_S537)->differential_0 = 0.0f;
    DiffPair_float_0 _S538;
    (&_S538)->primal_0 = _S536.primal_0;
    (&_S538)->differential_0 = _S536.differential_0;
    DiffPair_float_0 _S539 = _d_atan2_0(&_S537, &_S538);
    float fx_0 = intrins_1.x;
    float fy_0 = intrins_1.y;
    float _S540 = _S539.differential_0 * fy_0;
    Matrix<float, 2, 3>  J_0;
    *&(((&J_0)->rows + (int(0)))->x) = _S531.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->x) = _S540;
    DiffPair_float_0 _S541;
    (&_S541)->primal_0 = _S527;
    (&_S541)->differential_0 = 0.0f;
    DiffPair_float_0 _S542;
    (&_S542)->primal_0 = _S528;
    (&_S542)->differential_0 = 0.0f;
    DiffPair_float_0 _S543 = _d_atan2_0(&_S541, &_S542);
    float2  _S544 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S545;
    (&_S545)->primal_0 = _S533;
    (&_S545)->differential_0 = _S544;
    DiffPair_float_0 _S546 = s_fwd_length_impl_0(&_S545);
    DiffPair_float_0 _S547;
    (&_S547)->primal_0 = _S532;
    (&_S547)->differential_0 = 1.0f;
    DiffPair_float_0 _S548;
    (&_S548)->primal_0 = _S546.primal_0;
    (&_S548)->differential_0 = _S546.differential_0;
    DiffPair_float_0 _S549 = _d_atan2_0(&_S547, &_S548);
    float _S550 = _S549.differential_0 * fy_0;
    *&(((&J_0)->rows + (int(0)))->y) = _S543.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->y) = _S550;
    DiffPair_float_0 _S551;
    (&_S551)->primal_0 = _S527;
    (&_S551)->differential_0 = 0.0f;
    DiffPair_float_0 _S552;
    (&_S552)->primal_0 = _S528;
    (&_S552)->differential_0 = 1.0f;
    DiffPair_float_0 _S553 = _d_atan2_0(&_S551, &_S552);
    float2  _S554 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S555;
    (&_S555)->primal_0 = _S533;
    (&_S555)->differential_0 = _S554;
    DiffPair_float_0 _S556 = s_fwd_length_impl_0(&_S555);
    DiffPair_float_0 _S557;
    (&_S557)->primal_0 = _S532;
    (&_S557)->differential_0 = 0.0f;
    DiffPair_float_0 _S558;
    (&_S558)->primal_0 = _S556.primal_0;
    (&_S558)->differential_0 = _S556.differential_0;
    DiffPair_float_0 _S559 = _d_atan2_0(&_S557, &_S558);
    float _S560 = _S559.differential_0 * fy_0;
    *&(((&J_0)->rows + (int(0)))->z) = _S553.differential_0 * fx_0;
    *&(((&J_0)->rows + (int(1)))->z) = _S560;
    return J_0;
}

inline __device__ bool is_valid_distortion_none(float2  uv_8, FixedArray<float, 1>  dist_coeffs_4)
{
    return true;
}

inline __device__ float2  DistNone_distort_0(float2  uv_9, FixedArray<float, 1>  * coeffs_6)
{
    return uv_9;
}

inline __device__ bool persp_proj_nav_none(float3  p_view_2, float4  intrins_2, FixedArray<float, 1>  dist_coeffs_5, float2  * uv_10)
{
    bool _S561;
    for(;;)
    {
        float2  _S562 = float2 {p_view_2.x, p_view_2.y};
        float _S563 = p_view_2.z;
        float2  uv0_0 = _S562 / make_float2 (_S563);
        bool _S564 = _S563 < 0.0f;
        if(_S564)
        {
            *uv_10 = uv0_0;
            _S561 = false;
            break;
        }
        float2  uv_11 = _S562 / make_float2 (_S563);
        FixedArray<float, 1>  _S565 = dist_coeffs_5;
        float2  _S566 = DistNone_distort_0(uv_11, &_S565);
        *uv_10 = make_float2 (intrins_2.x * _S566.x + intrins_2.z, intrins_2.y * _S566.y + intrins_2.w);
        _S561 = true;
        break;
    }
    return _S561;
}

inline __device__ bool fisheye_proj_nav_none(float3  p_view_3, float4  intrins_3, FixedArray<float, 1>  dist_coeffs_6, float2  * uv_12)
{
    float2  _S567 = float2 {p_view_3.x, p_view_3.y};
    float r_6 = length_0(_S567);
    float _S568 = p_view_3.z;
    float theta_4 = (F32_atan2((r_6), (_S568)));
    float k_0;
    if(theta_4 < 0.00100000004749745f)
    {
        k_0 = (1.0f - theta_4 * theta_4 / 3.0f) / _S568;
    }
    else
    {
        k_0 = theta_4 / r_6;
    }
    float2  _S569 = _S567 * make_float2 (k_0);
    FixedArray<float, 1>  _S570 = dist_coeffs_6;
    float2  _S571 = DistNone_distort_0(_S569, &_S570);
    *uv_12 = make_float2 (intrins_3.x * _S571.x + intrins_3.z, intrins_3.y * _S571.y + intrins_3.w);
    return true;
}

inline __device__ bool equisolid_proj_nav_none(float3  p_view_4, float4  intrins_4, FixedArray<float, 1>  dist_coeffs_7, float2  * uv_13)
{
    float2  _S572 = float2 {p_view_4.x, p_view_4.y};
    float r_7 = length_0(_S572);
    float _S573 = p_view_4.z;
    float theta_5 = (F32_atan2((r_7), (_S573)));
    float k_1;
    if(r_7 < 9.99999997475242708e-07f)
    {
        k_1 = (1.0f - theta_5 * theta_5 / 24.0f) / _S573;
    }
    else
    {
        k_1 = 2.0f * (F32_sin((0.5f * theta_5))) / r_7;
    }
    float2  _S574 = _S572 * make_float2 (k_1);
    FixedArray<float, 1>  _S575 = dist_coeffs_7;
    float2  _S576 = DistNone_distort_0(_S574, &_S575);
    *uv_13 = make_float2 (intrins_4.x * _S576.x + intrins_4.z, intrins_4.y * _S576.y + intrins_4.w);
    return true;
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistNone_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_3, FixedArray<float, 1>  * coeffs_7)
{
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S577 = { dpuv_3->primal_0, dpuv_3->differential_0 };
    return _S577;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_none(float3  p_view_5, float4  intrins_5, FixedArray<float, 1>  dist_coeffs_8)
{
    float2  _S578 = float2 {p_view_5.x, p_view_5.y};
    float _S579 = p_view_5.z;
    float _S580 = _S579 * _S579;
    float2  s_diff_uv_0 = make_float2 (1.0f, 0.0f) * make_float2 (_S579) / make_float2 (_S580);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S581;
    (&_S581)->primal_0 = _S578 / make_float2 (_S579);
    (&_S581)->differential_0 = s_diff_uv_0;
    FixedArray<float, 1>  _S582 = dist_coeffs_8;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S583 = s_fwd_DistNone_distort_0(&_S581, &_S582);
    float fx_1 = intrins_5.x;
    float fy_1 = intrins_5.y;
    float _S584 = _S583.differential_0.y * fy_1;
    Matrix<float, 2, 3>  J_1;
    *&(((&J_1)->rows + (int(0)))->x) = _S583.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->x) = _S584;
    float2  s_diff_uv_1 = make_float2 (0.0f, 1.0f) * make_float2 (_S579) / make_float2 (_S580);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S585;
    (&_S585)->primal_0 = _S578 / make_float2 (_S579);
    (&_S585)->differential_0 = s_diff_uv_1;
    FixedArray<float, 1>  _S586 = dist_coeffs_8;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S587 = s_fwd_DistNone_distort_0(&_S585, &_S586);
    float _S588 = _S587.differential_0.y * fy_1;
    *&(((&J_1)->rows + (int(0)))->y) = _S587.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->y) = _S588;
    float2  s_diff_uv_2 = (make_float2 (0.0f, 0.0f) - _S578) / make_float2 (_S580);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S589;
    (&_S589)->primal_0 = _S578 / make_float2 (_S579);
    (&_S589)->differential_0 = s_diff_uv_2;
    FixedArray<float, 1>  _S590 = dist_coeffs_8;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S591 = s_fwd_DistNone_distort_0(&_S589, &_S590);
    float _S592 = _S591.differential_0.y * fy_1;
    *&(((&J_1)->rows + (int(0)))->z) = _S591.differential_0.x * fx_1;
    *&(((&J_1)->rows + (int(1)))->z) = _S592;
    return J_1;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_none(float3  p_view_6, float4  intrins_6, FixedArray<float, 1>  dist_coeffs_9)
{
    Matrix<float, 2, 3>  J_2;
    float2  _S593 = float2 {p_view_6.x, p_view_6.y};
    float2  _S594 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S595;
    (&_S595)->primal_0 = _S593;
    (&_S595)->differential_0 = _S594;
    DiffPair_float_0 _S596 = s_fwd_length_impl_0(&_S595);
    float _S597 = p_view_6.z;
    DiffPair_float_0 _S598;
    (&_S598)->primal_0 = _S596.primal_0;
    (&_S598)->differential_0 = _S596.differential_0;
    DiffPair_float_0 _S599;
    (&_S599)->primal_0 = _S597;
    (&_S599)->differential_0 = 0.0f;
    DiffPair_float_0 _S600 = _d_atan2_0(&_S598, &_S599);
    float k_2;
    float s_diff_k_0;
    if((_S600.primal_0) < 0.00100000004749745f)
    {
        float _S601 = _S600.differential_0 * _S600.primal_0;
        float _S602 = (0.0f - (_S601 + _S601) * 0.3333333432674408f) * _S597 / (_S597 * _S597);
        k_2 = (1.0f - _S600.primal_0 * _S600.primal_0 / 3.0f) / _S597;
        s_diff_k_0 = _S602;
    }
    else
    {
        float _S603 = (_S600.differential_0 * _S596.primal_0 - _S600.primal_0 * _S596.differential_0) / (_S596.primal_0 * _S596.primal_0);
        k_2 = _S600.primal_0 / _S596.primal_0;
        s_diff_k_0 = _S603;
    }
    float2  _S604 = _S593 * make_float2 (k_2);
    float2  _S605 = _S594 * make_float2 (k_2) + make_float2 (s_diff_k_0) * _S593;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S606;
    (&_S606)->primal_0 = _S604;
    (&_S606)->differential_0 = _S605;
    FixedArray<float, 1>  _S607 = dist_coeffs_9;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S608 = s_fwd_DistNone_distort_0(&_S606, &_S607);
    float fx_2 = intrins_6.x;
    float fy_2 = intrins_6.y;
    float _S609 = _S608.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->x) = _S608.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->x) = _S609;
    float2  _S610 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S611;
    (&_S611)->primal_0 = _S593;
    (&_S611)->differential_0 = _S610;
    DiffPair_float_0 _S612 = s_fwd_length_impl_0(&_S611);
    DiffPair_float_0 _S613;
    (&_S613)->primal_0 = _S612.primal_0;
    (&_S613)->differential_0 = _S612.differential_0;
    DiffPair_float_0 _S614;
    (&_S614)->primal_0 = _S597;
    (&_S614)->differential_0 = 0.0f;
    DiffPair_float_0 _S615 = _d_atan2_0(&_S613, &_S614);
    if((_S615.primal_0) < 0.00100000004749745f)
    {
        float _S616 = _S615.differential_0 * _S615.primal_0;
        float _S617 = (0.0f - (_S616 + _S616) * 0.3333333432674408f) * _S597 / (_S597 * _S597);
        k_2 = (1.0f - _S615.primal_0 * _S615.primal_0 / 3.0f) / _S597;
        s_diff_k_0 = _S617;
    }
    else
    {
        float _S618 = (_S615.differential_0 * _S612.primal_0 - _S615.primal_0 * _S612.differential_0) / (_S612.primal_0 * _S612.primal_0);
        k_2 = _S615.primal_0 / _S612.primal_0;
        s_diff_k_0 = _S618;
    }
    float2  _S619 = _S593 * make_float2 (k_2);
    float2  _S620 = _S610 * make_float2 (k_2) + make_float2 (s_diff_k_0) * _S593;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S621;
    (&_S621)->primal_0 = _S619;
    (&_S621)->differential_0 = _S620;
    FixedArray<float, 1>  _S622 = dist_coeffs_9;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S623 = s_fwd_DistNone_distort_0(&_S621, &_S622);
    float _S624 = _S623.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->y) = _S623.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->y) = _S624;
    float2  _S625 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S626;
    (&_S626)->primal_0 = _S593;
    (&_S626)->differential_0 = _S625;
    DiffPair_float_0 _S627 = s_fwd_length_impl_0(&_S626);
    DiffPair_float_0 _S628;
    (&_S628)->primal_0 = _S627.primal_0;
    (&_S628)->differential_0 = _S627.differential_0;
    DiffPair_float_0 _S629;
    (&_S629)->primal_0 = _S597;
    (&_S629)->differential_0 = 1.0f;
    DiffPair_float_0 _S630 = _d_atan2_0(&_S628, &_S629);
    if((_S630.primal_0) < 0.00100000004749745f)
    {
        float _S631 = _S630.differential_0 * _S630.primal_0;
        float _S632 = 1.0f - _S630.primal_0 * _S630.primal_0 / 3.0f;
        float _S633 = ((0.0f - (_S631 + _S631) * 0.3333333432674408f) * _S597 - _S632) / (_S597 * _S597);
        k_2 = _S632 / _S597;
        s_diff_k_0 = _S633;
    }
    else
    {
        float _S634 = (_S630.differential_0 * _S627.primal_0 - _S630.primal_0 * _S627.differential_0) / (_S627.primal_0 * _S627.primal_0);
        k_2 = _S630.primal_0 / _S627.primal_0;
        s_diff_k_0 = _S634;
    }
    float2  _S635 = _S593 * make_float2 (k_2);
    float2  _S636 = make_float2 (s_diff_k_0) * _S593;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S637;
    (&_S637)->primal_0 = _S635;
    (&_S637)->differential_0 = _S636;
    FixedArray<float, 1>  _S638 = dist_coeffs_9;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S639 = s_fwd_DistNone_distort_0(&_S637, &_S638);
    float _S640 = _S639.differential_0.y * fy_2;
    *&(((&J_2)->rows + (int(0)))->z) = _S639.differential_0.x * fx_2;
    *&(((&J_2)->rows + (int(1)))->z) = _S640;
    return J_2;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_none(float3  p_view_7, float4  intrins_7, FixedArray<float, 1>  dist_coeffs_10)
{
    Matrix<float, 2, 3>  J_3;
    float2  _S641 = float2 {p_view_7.x, p_view_7.y};
    float2  _S642 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S643;
    (&_S643)->primal_0 = _S641;
    (&_S643)->differential_0 = _S642;
    DiffPair_float_0 _S644 = s_fwd_length_impl_0(&_S643);
    float _S645 = p_view_7.z;
    DiffPair_float_0 _S646;
    (&_S646)->primal_0 = _S644.primal_0;
    (&_S646)->differential_0 = _S644.differential_0;
    DiffPair_float_0 _S647;
    (&_S647)->primal_0 = _S645;
    (&_S647)->differential_0 = 0.0f;
    DiffPair_float_0 _S648 = _d_atan2_0(&_S646, &_S647);
    float k_3;
    float s_diff_k_1;
    if((_S644.primal_0) < 9.99999997475242708e-07f)
    {
        float _S649 = _S648.differential_0 * _S648.primal_0;
        float _S650 = (0.0f - (_S649 + _S649) * 0.0416666679084301f) * _S645 / (_S645 * _S645);
        k_3 = (1.0f - _S648.primal_0 * _S648.primal_0 / 24.0f) / _S645;
        s_diff_k_1 = _S650;
    }
    else
    {
        float _S651 = _S648.differential_0 * 0.5f;
        DiffPair_float_0 _S652;
        (&_S652)->primal_0 = 0.5f * _S648.primal_0;
        (&_S652)->differential_0 = _S651;
        DiffPair_float_0 _S653 = _d_sin_0(&_S652);
        float _S654 = 2.0f * _S653.primal_0;
        float _S655 = (_S653.differential_0 * 2.0f * _S644.primal_0 - _S654 * _S644.differential_0) / (_S644.primal_0 * _S644.primal_0);
        k_3 = _S654 / _S644.primal_0;
        s_diff_k_1 = _S655;
    }
    float2  _S656 = _S641 * make_float2 (k_3);
    float2  _S657 = _S642 * make_float2 (k_3) + make_float2 (s_diff_k_1) * _S641;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S658;
    (&_S658)->primal_0 = _S656;
    (&_S658)->differential_0 = _S657;
    FixedArray<float, 1>  _S659 = dist_coeffs_10;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S660 = s_fwd_DistNone_distort_0(&_S658, &_S659);
    float fx_3 = intrins_7.x;
    float fy_3 = intrins_7.y;
    float _S661 = _S660.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->x) = _S660.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->x) = _S661;
    float2  _S662 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S663;
    (&_S663)->primal_0 = _S641;
    (&_S663)->differential_0 = _S662;
    DiffPair_float_0 _S664 = s_fwd_length_impl_0(&_S663);
    DiffPair_float_0 _S665;
    (&_S665)->primal_0 = _S664.primal_0;
    (&_S665)->differential_0 = _S664.differential_0;
    DiffPair_float_0 _S666;
    (&_S666)->primal_0 = _S645;
    (&_S666)->differential_0 = 0.0f;
    DiffPair_float_0 _S667 = _d_atan2_0(&_S665, &_S666);
    if((_S664.primal_0) < 9.99999997475242708e-07f)
    {
        float _S668 = _S667.differential_0 * _S667.primal_0;
        float _S669 = (0.0f - (_S668 + _S668) * 0.0416666679084301f) * _S645 / (_S645 * _S645);
        k_3 = (1.0f - _S667.primal_0 * _S667.primal_0 / 24.0f) / _S645;
        s_diff_k_1 = _S669;
    }
    else
    {
        float _S670 = _S667.differential_0 * 0.5f;
        DiffPair_float_0 _S671;
        (&_S671)->primal_0 = 0.5f * _S667.primal_0;
        (&_S671)->differential_0 = _S670;
        DiffPair_float_0 _S672 = _d_sin_0(&_S671);
        float _S673 = 2.0f * _S672.primal_0;
        float _S674 = (_S672.differential_0 * 2.0f * _S664.primal_0 - _S673 * _S664.differential_0) / (_S664.primal_0 * _S664.primal_0);
        k_3 = _S673 / _S664.primal_0;
        s_diff_k_1 = _S674;
    }
    float2  _S675 = _S641 * make_float2 (k_3);
    float2  _S676 = _S662 * make_float2 (k_3) + make_float2 (s_diff_k_1) * _S641;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S677;
    (&_S677)->primal_0 = _S675;
    (&_S677)->differential_0 = _S676;
    FixedArray<float, 1>  _S678 = dist_coeffs_10;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S679 = s_fwd_DistNone_distort_0(&_S677, &_S678);
    float _S680 = _S679.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->y) = _S679.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->y) = _S680;
    float2  _S681 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S682;
    (&_S682)->primal_0 = _S641;
    (&_S682)->differential_0 = _S681;
    DiffPair_float_0 _S683 = s_fwd_length_impl_0(&_S682);
    DiffPair_float_0 _S684;
    (&_S684)->primal_0 = _S683.primal_0;
    (&_S684)->differential_0 = _S683.differential_0;
    DiffPair_float_0 _S685;
    (&_S685)->primal_0 = _S645;
    (&_S685)->differential_0 = 1.0f;
    DiffPair_float_0 _S686 = _d_atan2_0(&_S684, &_S685);
    if((_S683.primal_0) < 9.99999997475242708e-07f)
    {
        float _S687 = _S686.differential_0 * _S686.primal_0;
        float _S688 = 1.0f - _S686.primal_0 * _S686.primal_0 / 24.0f;
        float _S689 = ((0.0f - (_S687 + _S687) * 0.0416666679084301f) * _S645 - _S688) / (_S645 * _S645);
        k_3 = _S688 / _S645;
        s_diff_k_1 = _S689;
    }
    else
    {
        float _S690 = _S686.differential_0 * 0.5f;
        DiffPair_float_0 _S691;
        (&_S691)->primal_0 = 0.5f * _S686.primal_0;
        (&_S691)->differential_0 = _S690;
        DiffPair_float_0 _S692 = _d_sin_0(&_S691);
        float _S693 = 2.0f * _S692.primal_0;
        float _S694 = (_S692.differential_0 * 2.0f * _S683.primal_0 - _S693 * _S683.differential_0) / (_S683.primal_0 * _S683.primal_0);
        k_3 = _S693 / _S683.primal_0;
        s_diff_k_1 = _S694;
    }
    float2  _S695 = _S641 * make_float2 (k_3);
    float2  _S696 = make_float2 (s_diff_k_1) * _S641;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S697;
    (&_S697)->primal_0 = _S695;
    (&_S697)->differential_0 = _S696;
    FixedArray<float, 1>  _S698 = dist_coeffs_10;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S699 = s_fwd_DistNone_distort_0(&_S697, &_S698);
    float _S700 = _S699.differential_0.y * fy_3;
    *&(((&J_3)->rows + (int(0)))->z) = _S699.differential_0.x * fx_3;
    *&(((&J_3)->rows + (int(1)))->z) = _S700;
    return J_3;
}

inline __device__ float2  distort_point_none(float2  uv_14, int camera_model_0, FixedArray<float, 1>  dist_coeffs_11)
{
    float2  _S701;
    for(;;)
    {
        if(camera_model_0 == int(3))
        {
            _S701 = uv_14;
            break;
        }
        float k_4;
        if(camera_model_0 == int(1))
        {
            float r_8 = length_0(uv_14);
            float theta_6 = (F32_atan((r_8)));
            if(r_8 < 0.00100000004749745f)
            {
                k_4 = 1.0f - theta_6 * theta_6 / 6.0f;
            }
            else
            {
                k_4 = theta_6 / r_8;
            }
            _S701 = uv_14 * make_float2 (k_4);
        }
        else
        {
            if(camera_model_0 == int(2))
            {
                float r_9 = length_0(uv_14);
                float theta_7 = (F32_atan((r_9)));
                if(r_9 < 0.00100000004749745f)
                {
                    k_4 = 1.0f - theta_7 * theta_7 / 24.0f;
                }
                else
                {
                    k_4 = 2.0f * (F32_sin((0.5f * theta_7))) / r_9;
                }
                _S701 = uv_14 * make_float2 (k_4);
            }
            else
            {
                _S701 = uv_14;
            }
        }
        FixedArray<float, 1>  _S702 = dist_coeffs_11;
        float2  _S703 = DistNone_distort_0(_S701, &_S702);
        _S701 = _S703;
        break;
    }
    return _S701;
}

inline __device__ bool undistort_point_none(float2  uv_15, int camera_model_1, FixedArray<float, 1>  dist_coeffs_12, float2  * uv_undist_4)
{
    bool _S704;
    for(;;)
    {
        *uv_undist_4 = make_float2 (0.0f);
        if(camera_model_1 == int(3))
        {
            float lon_0 = uv_15.x;
            float lat_0 = uv_15.y;
            float cl_0 = (F32_cos((lat_0)));
            *uv_undist_4 = make_float2 (cl_0 * (F32_sin((lon_0))), (F32_sin((lat_0)))) / make_float2 ((F32_max((cl_0 * (F32_cos((lon_0)))), (9.999999960041972e-13f))));
            _S704 = true;
            break;
        }
        FixedArray<float, 1>  _S705 = dist_coeffs_12;
        float2  uv_u_0;
        bool _S706 = undistort_point_3(uv_15, &_S705, int(8), &uv_u_0);
        if(!_S706)
        {
            _S704 = false;
            break;
        }
        float2  _S707 = uv_u_0;
        float3  raydir_0;
        if(camera_model_1 == int(1))
        {
            float r_10 = length_0(_S707);
            float s_0;
            if(r_10 < 0.00100000004749745f)
            {
                s_0 = 1.0f - r_10 * r_10 / 6.0f;
            }
            else
            {
                s_0 = (F32_sin((r_10))) / r_10;
            }
            raydir_0 = make_float3 ((_S707 * make_float2 (s_0)).x, (_S707 * make_float2 (s_0)).y, (F32_cos((r_10))));
        }
        else
        {
            if(camera_model_1 == int(2))
            {
                float r_11 = length_0(_S707);
                raydir_0 = make_float3 ((_S707 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_11 * r_11)))))))).x, (_S707 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_11 * r_11)))))))).y, 1.0f - 0.5f * r_11 * r_11);
            }
            else
            {
                raydir_0 = make_float3 (_S707.x, _S707.y, 1.0f);
            }
        }
        *uv_undist_4 = float2 {raydir_0.x, raydir_0.y} / make_float2 ((F32_max((raydir_0.z), (9.999999960041972e-13f))));
        _S704 = true;
        break;
    }
    return _S704;
}

inline __device__ bool unproject_point_none(float2  uv_16, int camera_model_2, FixedArray<float, 1>  dist_coeffs_13, float3  * raydir_1)
{
    bool _S708;
    for(;;)
    {
        int3  _S709 = make_int3 (int(0));
        float3  _S710 = make_float3 ((float)_S709.x, (float)_S709.y, (float)_S709.z);
        *raydir_1 = _S710;
        if(camera_model_2 == int(3))
        {
            float lon_1 = uv_16.x;
            float lat_1 = uv_16.y;
            float cl_1 = (F32_cos((lat_1)));
            *raydir_1 = make_float3 (cl_1 * (F32_sin((lon_1))), (F32_sin((lat_1))), cl_1 * (F32_cos((lon_1))));
            _S708 = true;
            break;
        }
        FixedArray<float, 1>  _S711 = dist_coeffs_13;
        float2  uv_u_1;
        bool _S712 = undistort_point_3(uv_16, &_S711, int(8), &uv_u_1);
        if(!_S712)
        {
            _S708 = false;
            break;
        }
        float2  _S713 = uv_u_1;
        if(camera_model_2 == int(1))
        {
            float r_12 = length_0(_S713);
            float s_1;
            if(r_12 < 0.00100000004749745f)
            {
                s_1 = 1.0f - r_12 * r_12 / 6.0f;
            }
            else
            {
                s_1 = (F32_sin((r_12))) / r_12;
            }
            *raydir_1 = make_float3 ((_S713 * make_float2 (s_1)).x, (_S713 * make_float2 (s_1)).y, (F32_cos((r_12))));
        }
        else
        {
            if(camera_model_2 == int(2))
            {
                float r_13 = length_0(_S713);
                *raydir_1 = make_float3 ((_S713 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_13 * r_13)))))))).x, (_S713 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_13 * r_13)))))))).y, 1.0f - 0.5f * r_13 * r_13);
            }
            else
            {
                *raydir_1 = make_float3 (_S713.x, _S713.y, 1.0f);
            }
        }
        _S708 = true;
        break;
    }
    return _S708;
}

inline __device__ bool generate_ray_none(float2  uv_17, int camera_model_3, FixedArray<float, 1>  dist_coeffs_14, float3  * raydir_2)
{
    bool _S714;
    for(;;)
    {
        if(camera_model_3 == int(3))
        {
            float _S715 = uv_17.x;
            if((F32_abs((_S715))) > 3.14159274101257324f)
            {
                _S714 = true;
            }
            else
            {
                _S714 = (F32_abs((uv_17.y))) > 1.57079637050628662f;
            }
            if(_S714)
            {
                int3  _S716 = make_int3 (int(0));
                float3  _S717 = make_float3 ((float)_S716.x, (float)_S716.y, (float)_S716.z);
                *raydir_2 = _S717;
                _S714 = false;
                break;
            }
            float lat_2 = uv_17.y;
            float cl_2 = (F32_cos((lat_2)));
            *raydir_2 = make_float3 (cl_2 * (F32_sin((_S715))), (F32_sin((lat_2))), cl_2 * (F32_cos((_S715))));
            _S714 = true;
            break;
        }
        FixedArray<float, 1>  _S718 = dist_coeffs_14;
        float2  uv_u_2;
        bool _S719 = undistort_point_3(uv_17, &_S718, int(8), &uv_u_2);
        if(!_S719)
        {
            int3  _S720 = make_int3 (int(0));
            float3  _S721 = make_float3 ((float)_S720.x, (float)_S720.y, (float)_S720.z);
            *raydir_2 = _S721;
            _S714 = false;
            break;
        }
        float2  _S722 = uv_u_2;
        if(camera_model_3 == int(1))
        {
            float r_14 = length_0(_S722);
            if(r_14 >= 3.14159274101257324f)
            {
                int3  _S723 = make_int3 (int(0));
                float3  _S724 = make_float3 ((float)_S723.x, (float)_S723.y, (float)_S723.z);
                *raydir_2 = _S724;
                _S714 = false;
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
            *raydir_2 = make_float3 ((_S722 * make_float2 (s_2)).x, (_S722 * make_float2 (s_2)).y, (F32_cos((r_14))));
        }
        else
        {
            if(camera_model_3 == int(2))
            {
                float r_15 = length_0(_S722);
                if(r_15 >= 2.0f)
                {
                    int3  _S725 = make_int3 (int(0));
                    float3  _S726 = make_float3 ((float)_S725.x, (float)_S725.y, (float)_S725.z);
                    *raydir_2 = _S726;
                    _S714 = false;
                    break;
                }
                *raydir_2 = make_float3 ((_S722 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_15 * r_15)))))))).x, (_S722 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_15 * r_15)))))))).y, 1.0f - 0.5f * r_15 * r_15);
            }
            else
            {
                *raydir_2 = make_float3 (_S722.x, _S722.y, 1.0f);
            }
        }
        *raydir_2 = normalize_0(*raydir_2);
        _S714 = true;
        break;
    }
    return _S714;
}

inline __device__ bool is_valid_distortion_opencv(float2  uv_18, FixedArray<float, 4>  dist_coeffs_15)
{
    float2  _S727 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S728;
    (&_S728)->primal_0 = uv_18;
    (&_S728)->differential_0 = _S727;
    FixedArray<float, 4>  _S729 = dist_coeffs_15;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S730 = s_fwd_DistOpenCV_distort_0(&_S728, &_S729);
    float2  _S731 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S732;
    (&_S732)->primal_0 = uv_18;
    (&_S732)->differential_0 = _S731;
    FixedArray<float, 4>  _S733 = dist_coeffs_15;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S734 = s_fwd_DistOpenCV_distort_0(&_S732, &_S733);
    Matrix<float, 2, 2>  _S735 = transpose_1(makeMatrix<float, 2, 2> (_S730.differential_0, _S734.differential_0));
    float _S736 = (F32_min((determinant_0(_S735)), ((F32_min((_S735.rows[int(0)].x), (_S735.rows[int(1)].y))))));
    bool _S737;
    if(_S736 > 0.25f)
    {
        _S737 = _S736 < 4.0f;
    }
    else
    {
        _S737 = false;
    }
    if(_S737)
    {
        FixedArray<float, 4>  _S738 = dist_coeffs_15;
        float2  _S739 = DistOpenCV_distort_0(uv_18, &_S738);
        _S737 = (dot_1(uv_18, _S739)) >= 0.0f;
    }
    else
    {
        _S737 = false;
    }
    return _S737;
}

inline __device__ bool persp_proj_nav_opencv(float3  p_view_8, float4  intrins_8, FixedArray<float, 4>  dist_coeffs_16, float2  * uv_19)
{
    bool _S740;
    for(;;)
    {
        float2  _S741 = float2 {p_view_8.x, p_view_8.y};
        float _S742 = p_view_8.z;
        float2  uv0_1 = _S741 / make_float2 (_S742);
        if(_S742 < 0.0f)
        {
            _S740 = true;
        }
        else
        {
            float2  _S743 = make_float2 (1.0f, 0.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S744;
            (&_S744)->primal_0 = uv0_1;
            (&_S744)->differential_0 = _S743;
            FixedArray<float, 4>  _S745 = dist_coeffs_16;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S746 = s_fwd_DistOpenCV_distort_0(&_S744, &_S745);
            float2  _S747 = make_float2 (0.0f, 1.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S748;
            (&_S748)->primal_0 = uv0_1;
            (&_S748)->differential_0 = _S747;
            FixedArray<float, 4>  _S749 = dist_coeffs_16;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S750 = s_fwd_DistOpenCV_distort_0(&_S748, &_S749);
            Matrix<float, 2, 2>  _S751 = transpose_1(makeMatrix<float, 2, 2> (_S746.differential_0, _S750.differential_0));
            float _S752 = (F32_min((determinant_0(_S751)), ((F32_min((_S751.rows[int(0)].x), (_S751.rows[int(1)].y))))));
            if(_S752 > 0.25f)
            {
                _S740 = _S752 < 4.0f;
            }
            else
            {
                _S740 = false;
            }
            if(_S740)
            {
                FixedArray<float, 4>  _S753 = dist_coeffs_16;
                float2  _S754 = DistOpenCV_distort_0(uv0_1, &_S753);
                _S740 = (dot_1(uv0_1, _S754)) >= 0.0f;
            }
            else
            {
                _S740 = false;
            }
            _S740 = !_S740;
        }
        if(_S740)
        {
            *uv_19 = uv0_1;
            _S740 = false;
            break;
        }
        float2  uv_20 = _S741 / make_float2 (_S742);
        FixedArray<float, 4>  _S755 = dist_coeffs_16;
        float2  _S756 = DistOpenCV_distort_0(uv_20, &_S755);
        *uv_19 = make_float2 (intrins_8.x * _S756.x + intrins_8.z, intrins_8.y * _S756.y + intrins_8.w);
        _S740 = true;
        break;
    }
    return _S740;
}

inline __device__ bool fisheye_proj_nav_opencv(float3  p_view_9, float4  intrins_9, FixedArray<float, 4>  dist_coeffs_17, float2  * uv_21)
{
    bool _S757;
    for(;;)
    {
        float2  _S758 = float2 {p_view_9.x, p_view_9.y};
        float r_16 = length_0(_S758);
        float _S759 = p_view_9.z;
        float theta_8 = (F32_atan2((r_16), (_S759)));
        bool _S760 = theta_8 < 0.00100000004749745f;
        float k_5;
        if(_S760)
        {
            k_5 = (1.0f - theta_8 * theta_8 / 3.0f) / _S759;
        }
        else
        {
            k_5 = theta_8 / r_16;
        }
        float2  _S761 = _S758 * make_float2 (k_5);
        float2  _S762 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S763;
        (&_S763)->primal_0 = _S761;
        (&_S763)->differential_0 = _S762;
        FixedArray<float, 4>  _S764 = dist_coeffs_17;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S765 = s_fwd_DistOpenCV_distort_0(&_S763, &_S764);
        float2  _S766 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S767;
        (&_S767)->primal_0 = _S761;
        (&_S767)->differential_0 = _S766;
        FixedArray<float, 4>  _S768 = dist_coeffs_17;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S769 = s_fwd_DistOpenCV_distort_0(&_S767, &_S768);
        Matrix<float, 2, 2>  _S770 = transpose_1(makeMatrix<float, 2, 2> (_S765.differential_0, _S769.differential_0));
        float _S771 = (F32_min((determinant_0(_S770)), ((F32_min((_S770.rows[int(0)].x), (_S770.rows[int(1)].y))))));
        if(_S771 > 0.25f)
        {
            _S757 = _S771 < 4.0f;
        }
        else
        {
            _S757 = false;
        }
        if(_S757)
        {
            FixedArray<float, 4>  _S772 = dist_coeffs_17;
            float2  _S773 = DistOpenCV_distort_0(_S761, &_S772);
            _S757 = (dot_1(_S761, _S773)) >= 0.0f;
        }
        else
        {
            _S757 = false;
        }
        if(!_S757)
        {
            *uv_21 = _S761;
            _S757 = false;
            break;
        }
        if(_S760)
        {
            k_5 = (1.0f - theta_8 * theta_8 / 3.0f) / _S759;
        }
        else
        {
            k_5 = theta_8 / r_16;
        }
        float2  _S774 = _S758 * make_float2 (k_5);
        FixedArray<float, 4>  _S775 = dist_coeffs_17;
        float2  _S776 = DistOpenCV_distort_0(_S774, &_S775);
        *uv_21 = make_float2 (intrins_9.x * _S776.x + intrins_9.z, intrins_9.y * _S776.y + intrins_9.w);
        _S757 = true;
        break;
    }
    return _S757;
}

inline __device__ bool equisolid_proj_nav_opencv(float3  p_view_10, float4  intrins_10, FixedArray<float, 4>  dist_coeffs_18, float2  * uv_22)
{
    bool _S777;
    for(;;)
    {
        float2  _S778 = float2 {p_view_10.x, p_view_10.y};
        float r_17 = length_0(_S778);
        float _S779 = p_view_10.z;
        float theta_9 = (F32_atan2((r_17), (_S779)));
        bool _S780 = r_17 < 9.99999997475242708e-07f;
        float k_6;
        if(_S780)
        {
            k_6 = (1.0f - theta_9 * theta_9 / 24.0f) / _S779;
        }
        else
        {
            k_6 = 2.0f * (F32_sin((0.5f * theta_9))) / r_17;
        }
        float2  _S781 = _S778 * make_float2 (k_6);
        float2  _S782 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S783;
        (&_S783)->primal_0 = _S781;
        (&_S783)->differential_0 = _S782;
        FixedArray<float, 4>  _S784 = dist_coeffs_18;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S785 = s_fwd_DistOpenCV_distort_0(&_S783, &_S784);
        float2  _S786 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S787;
        (&_S787)->primal_0 = _S781;
        (&_S787)->differential_0 = _S786;
        FixedArray<float, 4>  _S788 = dist_coeffs_18;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S789 = s_fwd_DistOpenCV_distort_0(&_S787, &_S788);
        Matrix<float, 2, 2>  _S790 = transpose_1(makeMatrix<float, 2, 2> (_S785.differential_0, _S789.differential_0));
        float _S791 = (F32_min((determinant_0(_S790)), ((F32_min((_S790.rows[int(0)].x), (_S790.rows[int(1)].y))))));
        if(_S791 > 0.25f)
        {
            _S777 = _S791 < 4.0f;
        }
        else
        {
            _S777 = false;
        }
        if(_S777)
        {
            FixedArray<float, 4>  _S792 = dist_coeffs_18;
            float2  _S793 = DistOpenCV_distort_0(_S781, &_S792);
            _S777 = (dot_1(_S781, _S793)) >= 0.0f;
        }
        else
        {
            _S777 = false;
        }
        if(!_S777)
        {
            *uv_22 = _S781;
            _S777 = false;
            break;
        }
        if(_S780)
        {
            k_6 = (1.0f - theta_9 * theta_9 / 24.0f) / _S779;
        }
        else
        {
            k_6 = 2.0f * (F32_sin((0.5f * theta_9))) / r_17;
        }
        float2  _S794 = _S778 * make_float2 (k_6);
        FixedArray<float, 4>  _S795 = dist_coeffs_18;
        float2  _S796 = DistOpenCV_distort_0(_S794, &_S795);
        *uv_22 = make_float2 (intrins_10.x * _S796.x + intrins_10.z, intrins_10.y * _S796.y + intrins_10.w);
        _S777 = true;
        break;
    }
    return _S777;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_opencv(float3  p_view_11, float4  intrins_11, FixedArray<float, 4>  dist_coeffs_19)
{
    float2  _S797 = float2 {p_view_11.x, p_view_11.y};
    float _S798 = p_view_11.z;
    float _S799 = _S798 * _S798;
    float2  s_diff_uv_3 = make_float2 (1.0f, 0.0f) * make_float2 (_S798) / make_float2 (_S799);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S800;
    (&_S800)->primal_0 = _S797 / make_float2 (_S798);
    (&_S800)->differential_0 = s_diff_uv_3;
    FixedArray<float, 4>  _S801 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S802 = s_fwd_DistOpenCV_distort_0(&_S800, &_S801);
    float fx_4 = intrins_11.x;
    float fy_4 = intrins_11.y;
    float _S803 = _S802.differential_0.y * fy_4;
    Matrix<float, 2, 3>  J_4;
    *&(((&J_4)->rows + (int(0)))->x) = _S802.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->x) = _S803;
    float2  s_diff_uv_4 = make_float2 (0.0f, 1.0f) * make_float2 (_S798) / make_float2 (_S799);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S804;
    (&_S804)->primal_0 = _S797 / make_float2 (_S798);
    (&_S804)->differential_0 = s_diff_uv_4;
    FixedArray<float, 4>  _S805 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S806 = s_fwd_DistOpenCV_distort_0(&_S804, &_S805);
    float _S807 = _S806.differential_0.y * fy_4;
    *&(((&J_4)->rows + (int(0)))->y) = _S806.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->y) = _S807;
    float2  s_diff_uv_5 = (make_float2 (0.0f, 0.0f) - _S797) / make_float2 (_S799);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S808;
    (&_S808)->primal_0 = _S797 / make_float2 (_S798);
    (&_S808)->differential_0 = s_diff_uv_5;
    FixedArray<float, 4>  _S809 = dist_coeffs_19;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S810 = s_fwd_DistOpenCV_distort_0(&_S808, &_S809);
    float _S811 = _S810.differential_0.y * fy_4;
    *&(((&J_4)->rows + (int(0)))->z) = _S810.differential_0.x * fx_4;
    *&(((&J_4)->rows + (int(1)))->z) = _S811;
    return J_4;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_opencv(float3  p_view_12, float4  intrins_12, FixedArray<float, 4>  dist_coeffs_20)
{
    Matrix<float, 2, 3>  J_5;
    float2  _S812 = float2 {p_view_12.x, p_view_12.y};
    float2  _S813 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S814;
    (&_S814)->primal_0 = _S812;
    (&_S814)->differential_0 = _S813;
    DiffPair_float_0 _S815 = s_fwd_length_impl_0(&_S814);
    float _S816 = p_view_12.z;
    DiffPair_float_0 _S817;
    (&_S817)->primal_0 = _S815.primal_0;
    (&_S817)->differential_0 = _S815.differential_0;
    DiffPair_float_0 _S818;
    (&_S818)->primal_0 = _S816;
    (&_S818)->differential_0 = 0.0f;
    DiffPair_float_0 _S819 = _d_atan2_0(&_S817, &_S818);
    float k_7;
    float s_diff_k_2;
    if((_S819.primal_0) < 0.00100000004749745f)
    {
        float _S820 = _S819.differential_0 * _S819.primal_0;
        float _S821 = (0.0f - (_S820 + _S820) * 0.3333333432674408f) * _S816 / (_S816 * _S816);
        k_7 = (1.0f - _S819.primal_0 * _S819.primal_0 / 3.0f) / _S816;
        s_diff_k_2 = _S821;
    }
    else
    {
        float _S822 = (_S819.differential_0 * _S815.primal_0 - _S819.primal_0 * _S815.differential_0) / (_S815.primal_0 * _S815.primal_0);
        k_7 = _S819.primal_0 / _S815.primal_0;
        s_diff_k_2 = _S822;
    }
    float2  _S823 = _S812 * make_float2 (k_7);
    float2  _S824 = _S813 * make_float2 (k_7) + make_float2 (s_diff_k_2) * _S812;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S825;
    (&_S825)->primal_0 = _S823;
    (&_S825)->differential_0 = _S824;
    FixedArray<float, 4>  _S826 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S827 = s_fwd_DistOpenCV_distort_0(&_S825, &_S826);
    float fx_5 = intrins_12.x;
    float fy_5 = intrins_12.y;
    float _S828 = _S827.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->x) = _S827.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->x) = _S828;
    float2  _S829 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S830;
    (&_S830)->primal_0 = _S812;
    (&_S830)->differential_0 = _S829;
    DiffPair_float_0 _S831 = s_fwd_length_impl_0(&_S830);
    DiffPair_float_0 _S832;
    (&_S832)->primal_0 = _S831.primal_0;
    (&_S832)->differential_0 = _S831.differential_0;
    DiffPair_float_0 _S833;
    (&_S833)->primal_0 = _S816;
    (&_S833)->differential_0 = 0.0f;
    DiffPair_float_0 _S834 = _d_atan2_0(&_S832, &_S833);
    if((_S834.primal_0) < 0.00100000004749745f)
    {
        float _S835 = _S834.differential_0 * _S834.primal_0;
        float _S836 = (0.0f - (_S835 + _S835) * 0.3333333432674408f) * _S816 / (_S816 * _S816);
        k_7 = (1.0f - _S834.primal_0 * _S834.primal_0 / 3.0f) / _S816;
        s_diff_k_2 = _S836;
    }
    else
    {
        float _S837 = (_S834.differential_0 * _S831.primal_0 - _S834.primal_0 * _S831.differential_0) / (_S831.primal_0 * _S831.primal_0);
        k_7 = _S834.primal_0 / _S831.primal_0;
        s_diff_k_2 = _S837;
    }
    float2  _S838 = _S812 * make_float2 (k_7);
    float2  _S839 = _S829 * make_float2 (k_7) + make_float2 (s_diff_k_2) * _S812;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S840;
    (&_S840)->primal_0 = _S838;
    (&_S840)->differential_0 = _S839;
    FixedArray<float, 4>  _S841 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S842 = s_fwd_DistOpenCV_distort_0(&_S840, &_S841);
    float _S843 = _S842.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->y) = _S842.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->y) = _S843;
    float2  _S844 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S845;
    (&_S845)->primal_0 = _S812;
    (&_S845)->differential_0 = _S844;
    DiffPair_float_0 _S846 = s_fwd_length_impl_0(&_S845);
    DiffPair_float_0 _S847;
    (&_S847)->primal_0 = _S846.primal_0;
    (&_S847)->differential_0 = _S846.differential_0;
    DiffPair_float_0 _S848;
    (&_S848)->primal_0 = _S816;
    (&_S848)->differential_0 = 1.0f;
    DiffPair_float_0 _S849 = _d_atan2_0(&_S847, &_S848);
    if((_S849.primal_0) < 0.00100000004749745f)
    {
        float _S850 = _S849.differential_0 * _S849.primal_0;
        float _S851 = 1.0f - _S849.primal_0 * _S849.primal_0 / 3.0f;
        float _S852 = ((0.0f - (_S850 + _S850) * 0.3333333432674408f) * _S816 - _S851) / (_S816 * _S816);
        k_7 = _S851 / _S816;
        s_diff_k_2 = _S852;
    }
    else
    {
        float _S853 = (_S849.differential_0 * _S846.primal_0 - _S849.primal_0 * _S846.differential_0) / (_S846.primal_0 * _S846.primal_0);
        k_7 = _S849.primal_0 / _S846.primal_0;
        s_diff_k_2 = _S853;
    }
    float2  _S854 = _S812 * make_float2 (k_7);
    float2  _S855 = make_float2 (s_diff_k_2) * _S812;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S856;
    (&_S856)->primal_0 = _S854;
    (&_S856)->differential_0 = _S855;
    FixedArray<float, 4>  _S857 = dist_coeffs_20;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S858 = s_fwd_DistOpenCV_distort_0(&_S856, &_S857);
    float _S859 = _S858.differential_0.y * fy_5;
    *&(((&J_5)->rows + (int(0)))->z) = _S858.differential_0.x * fx_5;
    *&(((&J_5)->rows + (int(1)))->z) = _S859;
    return J_5;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_opencv(float3  p_view_13, float4  intrins_13, FixedArray<float, 4>  dist_coeffs_21)
{
    Matrix<float, 2, 3>  J_6;
    float2  _S860 = float2 {p_view_13.x, p_view_13.y};
    float2  _S861 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S862;
    (&_S862)->primal_0 = _S860;
    (&_S862)->differential_0 = _S861;
    DiffPair_float_0 _S863 = s_fwd_length_impl_0(&_S862);
    float _S864 = p_view_13.z;
    DiffPair_float_0 _S865;
    (&_S865)->primal_0 = _S863.primal_0;
    (&_S865)->differential_0 = _S863.differential_0;
    DiffPair_float_0 _S866;
    (&_S866)->primal_0 = _S864;
    (&_S866)->differential_0 = 0.0f;
    DiffPair_float_0 _S867 = _d_atan2_0(&_S865, &_S866);
    float k_8;
    float s_diff_k_3;
    if((_S863.primal_0) < 9.99999997475242708e-07f)
    {
        float _S868 = _S867.differential_0 * _S867.primal_0;
        float _S869 = (0.0f - (_S868 + _S868) * 0.0416666679084301f) * _S864 / (_S864 * _S864);
        k_8 = (1.0f - _S867.primal_0 * _S867.primal_0 / 24.0f) / _S864;
        s_diff_k_3 = _S869;
    }
    else
    {
        float _S870 = _S867.differential_0 * 0.5f;
        DiffPair_float_0 _S871;
        (&_S871)->primal_0 = 0.5f * _S867.primal_0;
        (&_S871)->differential_0 = _S870;
        DiffPair_float_0 _S872 = _d_sin_0(&_S871);
        float _S873 = 2.0f * _S872.primal_0;
        float _S874 = (_S872.differential_0 * 2.0f * _S863.primal_0 - _S873 * _S863.differential_0) / (_S863.primal_0 * _S863.primal_0);
        k_8 = _S873 / _S863.primal_0;
        s_diff_k_3 = _S874;
    }
    float2  _S875 = _S860 * make_float2 (k_8);
    float2  _S876 = _S861 * make_float2 (k_8) + make_float2 (s_diff_k_3) * _S860;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S877;
    (&_S877)->primal_0 = _S875;
    (&_S877)->differential_0 = _S876;
    FixedArray<float, 4>  _S878 = dist_coeffs_21;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S879 = s_fwd_DistOpenCV_distort_0(&_S877, &_S878);
    float fx_6 = intrins_13.x;
    float fy_6 = intrins_13.y;
    float _S880 = _S879.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->x) = _S879.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->x) = _S880;
    float2  _S881 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S882;
    (&_S882)->primal_0 = _S860;
    (&_S882)->differential_0 = _S881;
    DiffPair_float_0 _S883 = s_fwd_length_impl_0(&_S882);
    DiffPair_float_0 _S884;
    (&_S884)->primal_0 = _S883.primal_0;
    (&_S884)->differential_0 = _S883.differential_0;
    DiffPair_float_0 _S885;
    (&_S885)->primal_0 = _S864;
    (&_S885)->differential_0 = 0.0f;
    DiffPair_float_0 _S886 = _d_atan2_0(&_S884, &_S885);
    if((_S883.primal_0) < 9.99999997475242708e-07f)
    {
        float _S887 = _S886.differential_0 * _S886.primal_0;
        float _S888 = (0.0f - (_S887 + _S887) * 0.0416666679084301f) * _S864 / (_S864 * _S864);
        k_8 = (1.0f - _S886.primal_0 * _S886.primal_0 / 24.0f) / _S864;
        s_diff_k_3 = _S888;
    }
    else
    {
        float _S889 = _S886.differential_0 * 0.5f;
        DiffPair_float_0 _S890;
        (&_S890)->primal_0 = 0.5f * _S886.primal_0;
        (&_S890)->differential_0 = _S889;
        DiffPair_float_0 _S891 = _d_sin_0(&_S890);
        float _S892 = 2.0f * _S891.primal_0;
        float _S893 = (_S891.differential_0 * 2.0f * _S883.primal_0 - _S892 * _S883.differential_0) / (_S883.primal_0 * _S883.primal_0);
        k_8 = _S892 / _S883.primal_0;
        s_diff_k_3 = _S893;
    }
    float2  _S894 = _S860 * make_float2 (k_8);
    float2  _S895 = _S881 * make_float2 (k_8) + make_float2 (s_diff_k_3) * _S860;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S896;
    (&_S896)->primal_0 = _S894;
    (&_S896)->differential_0 = _S895;
    FixedArray<float, 4>  _S897 = dist_coeffs_21;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S898 = s_fwd_DistOpenCV_distort_0(&_S896, &_S897);
    float _S899 = _S898.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->y) = _S898.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->y) = _S899;
    float2  _S900 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S901;
    (&_S901)->primal_0 = _S860;
    (&_S901)->differential_0 = _S900;
    DiffPair_float_0 _S902 = s_fwd_length_impl_0(&_S901);
    DiffPair_float_0 _S903;
    (&_S903)->primal_0 = _S902.primal_0;
    (&_S903)->differential_0 = _S902.differential_0;
    DiffPair_float_0 _S904;
    (&_S904)->primal_0 = _S864;
    (&_S904)->differential_0 = 1.0f;
    DiffPair_float_0 _S905 = _d_atan2_0(&_S903, &_S904);
    if((_S902.primal_0) < 9.99999997475242708e-07f)
    {
        float _S906 = _S905.differential_0 * _S905.primal_0;
        float _S907 = 1.0f - _S905.primal_0 * _S905.primal_0 / 24.0f;
        float _S908 = ((0.0f - (_S906 + _S906) * 0.0416666679084301f) * _S864 - _S907) / (_S864 * _S864);
        k_8 = _S907 / _S864;
        s_diff_k_3 = _S908;
    }
    else
    {
        float _S909 = _S905.differential_0 * 0.5f;
        DiffPair_float_0 _S910;
        (&_S910)->primal_0 = 0.5f * _S905.primal_0;
        (&_S910)->differential_0 = _S909;
        DiffPair_float_0 _S911 = _d_sin_0(&_S910);
        float _S912 = 2.0f * _S911.primal_0;
        float _S913 = (_S911.differential_0 * 2.0f * _S902.primal_0 - _S912 * _S902.differential_0) / (_S902.primal_0 * _S902.primal_0);
        k_8 = _S912 / _S902.primal_0;
        s_diff_k_3 = _S913;
    }
    float2  _S914 = _S860 * make_float2 (k_8);
    float2  _S915 = make_float2 (s_diff_k_3) * _S860;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S916;
    (&_S916)->primal_0 = _S914;
    (&_S916)->differential_0 = _S915;
    FixedArray<float, 4>  _S917 = dist_coeffs_21;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S918 = s_fwd_DistOpenCV_distort_0(&_S916, &_S917);
    float _S919 = _S918.differential_0.y * fy_6;
    *&(((&J_6)->rows + (int(0)))->z) = _S918.differential_0.x * fx_6;
    *&(((&J_6)->rows + (int(1)))->z) = _S919;
    return J_6;
}

inline __device__ float2  distort_point_opencv(float2  uv_23, int camera_model_4, FixedArray<float, 4>  dist_coeffs_22)
{
    float2  _S920;
    for(;;)
    {
        if(camera_model_4 == int(3))
        {
            _S920 = uv_23;
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
            _S920 = uv_23 * make_float2 (k_9);
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
                _S920 = uv_23 * make_float2 (k_9);
            }
            else
            {
                _S920 = uv_23;
            }
        }
        FixedArray<float, 4>  _S921 = dist_coeffs_22;
        float2  _S922 = DistOpenCV_distort_0(_S920, &_S921);
        _S920 = _S922;
        break;
    }
    return _S920;
}

inline __device__ bool undistort_point_opencv(float2  uv_24, int camera_model_5, FixedArray<float, 4>  dist_coeffs_23, float2  * uv_undist_5)
{
    bool _S923;
    for(;;)
    {
        *uv_undist_5 = make_float2 (0.0f);
        if(camera_model_5 == int(3))
        {
            float lon_2 = uv_24.x;
            float lat_3 = uv_24.y;
            float cl_3 = (F32_cos((lat_3)));
            *uv_undist_5 = make_float2 (cl_3 * (F32_sin((lon_2))), (F32_sin((lat_3)))) / make_float2 ((F32_max((cl_3 * (F32_cos((lon_2)))), (9.999999960041972e-13f))));
            _S923 = true;
            break;
        }
        FixedArray<float, 4>  _S924 = dist_coeffs_23;
        float2  uv_u_3;
        bool _S925 = undistort_point_2(uv_24, &_S924, int(8), &uv_u_3);
        if(!_S925)
        {
            _S923 = false;
            break;
        }
        float2  _S926 = uv_u_3;
        float3  raydir_3;
        if(camera_model_5 == int(1))
        {
            float r_20 = length_0(_S926);
            float s_3;
            if(r_20 < 0.00100000004749745f)
            {
                s_3 = 1.0f - r_20 * r_20 / 6.0f;
            }
            else
            {
                s_3 = (F32_sin((r_20))) / r_20;
            }
            raydir_3 = make_float3 ((_S926 * make_float2 (s_3)).x, (_S926 * make_float2 (s_3)).y, (F32_cos((r_20))));
        }
        else
        {
            if(camera_model_5 == int(2))
            {
                float r_21 = length_0(_S926);
                raydir_3 = make_float3 ((_S926 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_21 * r_21)))))))).x, (_S926 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_21 * r_21)))))))).y, 1.0f - 0.5f * r_21 * r_21);
            }
            else
            {
                raydir_3 = make_float3 (_S926.x, _S926.y, 1.0f);
            }
        }
        *uv_undist_5 = float2 {raydir_3.x, raydir_3.y} / make_float2 ((F32_max((raydir_3.z), (9.999999960041972e-13f))));
        _S923 = true;
        break;
    }
    return _S923;
}

inline __device__ bool unproject_point_opencv(float2  uv_25, int camera_model_6, FixedArray<float, 4>  dist_coeffs_24, float3  * raydir_4)
{
    bool _S927;
    for(;;)
    {
        int3  _S928 = make_int3 (int(0));
        float3  _S929 = make_float3 ((float)_S928.x, (float)_S928.y, (float)_S928.z);
        *raydir_4 = _S929;
        if(camera_model_6 == int(3))
        {
            float lon_3 = uv_25.x;
            float lat_4 = uv_25.y;
            float cl_4 = (F32_cos((lat_4)));
            *raydir_4 = make_float3 (cl_4 * (F32_sin((lon_3))), (F32_sin((lat_4))), cl_4 * (F32_cos((lon_3))));
            _S927 = true;
            break;
        }
        FixedArray<float, 4>  _S930 = dist_coeffs_24;
        float2  uv_u_4;
        bool _S931 = undistort_point_2(uv_25, &_S930, int(8), &uv_u_4);
        if(!_S931)
        {
            _S927 = false;
            break;
        }
        float2  _S932 = uv_u_4;
        if(camera_model_6 == int(1))
        {
            float r_22 = length_0(_S932);
            float s_4;
            if(r_22 < 0.00100000004749745f)
            {
                s_4 = 1.0f - r_22 * r_22 / 6.0f;
            }
            else
            {
                s_4 = (F32_sin((r_22))) / r_22;
            }
            *raydir_4 = make_float3 ((_S932 * make_float2 (s_4)).x, (_S932 * make_float2 (s_4)).y, (F32_cos((r_22))));
        }
        else
        {
            if(camera_model_6 == int(2))
            {
                float r_23 = length_0(_S932);
                *raydir_4 = make_float3 ((_S932 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_23 * r_23)))))))).x, (_S932 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_23 * r_23)))))))).y, 1.0f - 0.5f * r_23 * r_23);
            }
            else
            {
                *raydir_4 = make_float3 (_S932.x, _S932.y, 1.0f);
            }
        }
        _S927 = true;
        break;
    }
    return _S927;
}

inline __device__ bool generate_ray_opencv(float2  uv_26, int camera_model_7, FixedArray<float, 4>  dist_coeffs_25, float3  * raydir_5)
{
    bool _S933;
    for(;;)
    {
        if(camera_model_7 == int(3))
        {
            float _S934 = uv_26.x;
            if((F32_abs((_S934))) > 3.14159274101257324f)
            {
                _S933 = true;
            }
            else
            {
                _S933 = (F32_abs((uv_26.y))) > 1.57079637050628662f;
            }
            if(_S933)
            {
                int3  _S935 = make_int3 (int(0));
                float3  _S936 = make_float3 ((float)_S935.x, (float)_S935.y, (float)_S935.z);
                *raydir_5 = _S936;
                _S933 = false;
                break;
            }
            float lat_5 = uv_26.y;
            float cl_5 = (F32_cos((lat_5)));
            *raydir_5 = make_float3 (cl_5 * (F32_sin((_S934))), (F32_sin((lat_5))), cl_5 * (F32_cos((_S934))));
            _S933 = true;
            break;
        }
        FixedArray<float, 4>  _S937 = dist_coeffs_25;
        float2  uv_u_5;
        bool _S938 = undistort_point_2(uv_26, &_S937, int(8), &uv_u_5);
        if(!_S938)
        {
            int3  _S939 = make_int3 (int(0));
            float3  _S940 = make_float3 ((float)_S939.x, (float)_S939.y, (float)_S939.z);
            *raydir_5 = _S940;
            _S933 = false;
            break;
        }
        float2  _S941 = uv_u_5;
        if(camera_model_7 == int(1))
        {
            float r_24 = length_0(_S941);
            if(r_24 >= 3.14159274101257324f)
            {
                int3  _S942 = make_int3 (int(0));
                float3  _S943 = make_float3 ((float)_S942.x, (float)_S942.y, (float)_S942.z);
                *raydir_5 = _S943;
                _S933 = false;
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
            *raydir_5 = make_float3 ((_S941 * make_float2 (s_5)).x, (_S941 * make_float2 (s_5)).y, (F32_cos((r_24))));
        }
        else
        {
            if(camera_model_7 == int(2))
            {
                float r_25 = length_0(_S941);
                if(r_25 >= 2.0f)
                {
                    int3  _S944 = make_int3 (int(0));
                    float3  _S945 = make_float3 ((float)_S944.x, (float)_S944.y, (float)_S944.z);
                    *raydir_5 = _S945;
                    _S933 = false;
                    break;
                }
                *raydir_5 = make_float3 ((_S941 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_25 * r_25)))))))).x, (_S941 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_25 * r_25)))))))).y, 1.0f - 0.5f * r_25 * r_25);
            }
            else
            {
                *raydir_5 = make_float3 (_S941.x, _S941.y, 1.0f);
            }
        }
        *raydir_5 = normalize_0(*raydir_5);
        _S933 = true;
        break;
    }
    return _S933;
}

inline __device__ bool is_valid_distortion_prism(float2  uv_27, FixedArray<float, 8>  dist_coeffs_26)
{
    float2  _S946 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S947;
    (&_S947)->primal_0 = uv_27;
    (&_S947)->differential_0 = _S946;
    FixedArray<float, 8>  _S948 = dist_coeffs_26;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S949 = s_fwd_DistThinPrism_distort_0(&_S947, &_S948);
    float2  _S950 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S951;
    (&_S951)->primal_0 = uv_27;
    (&_S951)->differential_0 = _S950;
    FixedArray<float, 8>  _S952 = dist_coeffs_26;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S953 = s_fwd_DistThinPrism_distort_0(&_S951, &_S952);
    Matrix<float, 2, 2>  _S954 = transpose_1(makeMatrix<float, 2, 2> (_S949.differential_0, _S953.differential_0));
    float _S955 = (F32_min((determinant_0(_S954)), ((F32_min((_S954.rows[int(0)].x), (_S954.rows[int(1)].y))))));
    bool _S956;
    if(_S955 > 0.25f)
    {
        _S956 = _S955 < 4.0f;
    }
    else
    {
        _S956 = false;
    }
    if(_S956)
    {
        FixedArray<float, 8>  _S957 = dist_coeffs_26;
        float2  _S958 = DistThinPrism_distort_0(uv_27, &_S957);
        _S956 = (dot_1(uv_27, _S958)) >= 0.0f;
    }
    else
    {
        _S956 = false;
    }
    return _S956;
}

inline __device__ bool persp_proj_nav_prism(float3  p_view_14, float4  intrins_14, FixedArray<float, 8>  dist_coeffs_27, float2  * uv_28)
{
    bool _S959;
    for(;;)
    {
        float2  _S960 = float2 {p_view_14.x, p_view_14.y};
        float _S961 = p_view_14.z;
        float2  uv0_2 = _S960 / make_float2 (_S961);
        if(_S961 < 0.0f)
        {
            _S959 = true;
        }
        else
        {
            float2  _S962 = make_float2 (1.0f, 0.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S963;
            (&_S963)->primal_0 = uv0_2;
            (&_S963)->differential_0 = _S962;
            FixedArray<float, 8>  _S964 = dist_coeffs_27;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S965 = s_fwd_DistThinPrism_distort_0(&_S963, &_S964);
            float2  _S966 = make_float2 (0.0f, 1.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S967;
            (&_S967)->primal_0 = uv0_2;
            (&_S967)->differential_0 = _S966;
            FixedArray<float, 8>  _S968 = dist_coeffs_27;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S969 = s_fwd_DistThinPrism_distort_0(&_S967, &_S968);
            Matrix<float, 2, 2>  _S970 = transpose_1(makeMatrix<float, 2, 2> (_S965.differential_0, _S969.differential_0));
            float _S971 = (F32_min((determinant_0(_S970)), ((F32_min((_S970.rows[int(0)].x), (_S970.rows[int(1)].y))))));
            if(_S971 > 0.25f)
            {
                _S959 = _S971 < 4.0f;
            }
            else
            {
                _S959 = false;
            }
            if(_S959)
            {
                FixedArray<float, 8>  _S972 = dist_coeffs_27;
                float2  _S973 = DistThinPrism_distort_0(uv0_2, &_S972);
                _S959 = (dot_1(uv0_2, _S973)) >= 0.0f;
            }
            else
            {
                _S959 = false;
            }
            _S959 = !_S959;
        }
        if(_S959)
        {
            *uv_28 = uv0_2;
            _S959 = false;
            break;
        }
        float2  uv_29 = _S960 / make_float2 (_S961);
        FixedArray<float, 8>  _S974 = dist_coeffs_27;
        float2  _S975 = DistThinPrism_distort_0(uv_29, &_S974);
        *uv_28 = make_float2 (intrins_14.x * _S975.x + intrins_14.z, intrins_14.y * _S975.y + intrins_14.w);
        _S959 = true;
        break;
    }
    return _S959;
}

inline __device__ bool fisheye_proj_nav_prism(float3  p_view_15, float4  intrins_15, FixedArray<float, 8>  dist_coeffs_28, float2  * uv_30)
{
    bool _S976;
    for(;;)
    {
        float2  _S977 = float2 {p_view_15.x, p_view_15.y};
        float r_26 = length_0(_S977);
        float _S978 = p_view_15.z;
        float theta_12 = (F32_atan2((r_26), (_S978)));
        bool _S979 = theta_12 < 0.00100000004749745f;
        float k_10;
        if(_S979)
        {
            k_10 = (1.0f - theta_12 * theta_12 / 3.0f) / _S978;
        }
        else
        {
            k_10 = theta_12 / r_26;
        }
        float2  _S980 = _S977 * make_float2 (k_10);
        float2  _S981 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S982;
        (&_S982)->primal_0 = _S980;
        (&_S982)->differential_0 = _S981;
        FixedArray<float, 8>  _S983 = dist_coeffs_28;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S984 = s_fwd_DistThinPrism_distort_0(&_S982, &_S983);
        float2  _S985 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S986;
        (&_S986)->primal_0 = _S980;
        (&_S986)->differential_0 = _S985;
        FixedArray<float, 8>  _S987 = dist_coeffs_28;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S988 = s_fwd_DistThinPrism_distort_0(&_S986, &_S987);
        Matrix<float, 2, 2>  _S989 = transpose_1(makeMatrix<float, 2, 2> (_S984.differential_0, _S988.differential_0));
        float _S990 = (F32_min((determinant_0(_S989)), ((F32_min((_S989.rows[int(0)].x), (_S989.rows[int(1)].y))))));
        if(_S990 > 0.25f)
        {
            _S976 = _S990 < 4.0f;
        }
        else
        {
            _S976 = false;
        }
        if(_S976)
        {
            FixedArray<float, 8>  _S991 = dist_coeffs_28;
            float2  _S992 = DistThinPrism_distort_0(_S980, &_S991);
            _S976 = (dot_1(_S980, _S992)) >= 0.0f;
        }
        else
        {
            _S976 = false;
        }
        if(!_S976)
        {
            *uv_30 = _S980;
            _S976 = false;
            break;
        }
        if(_S979)
        {
            k_10 = (1.0f - theta_12 * theta_12 / 3.0f) / _S978;
        }
        else
        {
            k_10 = theta_12 / r_26;
        }
        float2  _S993 = _S977 * make_float2 (k_10);
        FixedArray<float, 8>  _S994 = dist_coeffs_28;
        float2  _S995 = DistThinPrism_distort_0(_S993, &_S994);
        *uv_30 = make_float2 (intrins_15.x * _S995.x + intrins_15.z, intrins_15.y * _S995.y + intrins_15.w);
        _S976 = true;
        break;
    }
    return _S976;
}

inline __device__ bool equisolid_proj_nav_prism(float3  p_view_16, float4  intrins_16, FixedArray<float, 8>  dist_coeffs_29, float2  * uv_31)
{
    bool _S996;
    for(;;)
    {
        float2  _S997 = float2 {p_view_16.x, p_view_16.y};
        float r_27 = length_0(_S997);
        float _S998 = p_view_16.z;
        float theta_13 = (F32_atan2((r_27), (_S998)));
        bool _S999 = r_27 < 9.99999997475242708e-07f;
        float k_11;
        if(_S999)
        {
            k_11 = (1.0f - theta_13 * theta_13 / 24.0f) / _S998;
        }
        else
        {
            k_11 = 2.0f * (F32_sin((0.5f * theta_13))) / r_27;
        }
        float2  _S1000 = _S997 * make_float2 (k_11);
        float2  _S1001 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1002;
        (&_S1002)->primal_0 = _S1000;
        (&_S1002)->differential_0 = _S1001;
        FixedArray<float, 8>  _S1003 = dist_coeffs_29;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1004 = s_fwd_DistThinPrism_distort_0(&_S1002, &_S1003);
        float2  _S1005 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1006;
        (&_S1006)->primal_0 = _S1000;
        (&_S1006)->differential_0 = _S1005;
        FixedArray<float, 8>  _S1007 = dist_coeffs_29;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1008 = s_fwd_DistThinPrism_distort_0(&_S1006, &_S1007);
        Matrix<float, 2, 2>  _S1009 = transpose_1(makeMatrix<float, 2, 2> (_S1004.differential_0, _S1008.differential_0));
        float _S1010 = (F32_min((determinant_0(_S1009)), ((F32_min((_S1009.rows[int(0)].x), (_S1009.rows[int(1)].y))))));
        if(_S1010 > 0.25f)
        {
            _S996 = _S1010 < 4.0f;
        }
        else
        {
            _S996 = false;
        }
        if(_S996)
        {
            FixedArray<float, 8>  _S1011 = dist_coeffs_29;
            float2  _S1012 = DistThinPrism_distort_0(_S1000, &_S1011);
            _S996 = (dot_1(_S1000, _S1012)) >= 0.0f;
        }
        else
        {
            _S996 = false;
        }
        if(!_S996)
        {
            *uv_31 = _S1000;
            _S996 = false;
            break;
        }
        if(_S999)
        {
            k_11 = (1.0f - theta_13 * theta_13 / 24.0f) / _S998;
        }
        else
        {
            k_11 = 2.0f * (F32_sin((0.5f * theta_13))) / r_27;
        }
        float2  _S1013 = _S997 * make_float2 (k_11);
        FixedArray<float, 8>  _S1014 = dist_coeffs_29;
        float2  _S1015 = DistThinPrism_distort_0(_S1013, &_S1014);
        *uv_31 = make_float2 (intrins_16.x * _S1015.x + intrins_16.z, intrins_16.y * _S1015.y + intrins_16.w);
        _S996 = true;
        break;
    }
    return _S996;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_prism(float3  p_view_17, float4  intrins_17, FixedArray<float, 8>  dist_coeffs_30)
{
    float2  _S1016 = float2 {p_view_17.x, p_view_17.y};
    float _S1017 = p_view_17.z;
    float _S1018 = _S1017 * _S1017;
    float2  s_diff_uv_6 = make_float2 (1.0f, 0.0f) * make_float2 (_S1017) / make_float2 (_S1018);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1019;
    (&_S1019)->primal_0 = _S1016 / make_float2 (_S1017);
    (&_S1019)->differential_0 = s_diff_uv_6;
    FixedArray<float, 8>  _S1020 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1021 = s_fwd_DistThinPrism_distort_0(&_S1019, &_S1020);
    float fx_7 = intrins_17.x;
    float fy_7 = intrins_17.y;
    float _S1022 = _S1021.differential_0.y * fy_7;
    Matrix<float, 2, 3>  J_7;
    *&(((&J_7)->rows + (int(0)))->x) = _S1021.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->x) = _S1022;
    float2  s_diff_uv_7 = make_float2 (0.0f, 1.0f) * make_float2 (_S1017) / make_float2 (_S1018);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1023;
    (&_S1023)->primal_0 = _S1016 / make_float2 (_S1017);
    (&_S1023)->differential_0 = s_diff_uv_7;
    FixedArray<float, 8>  _S1024 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1025 = s_fwd_DistThinPrism_distort_0(&_S1023, &_S1024);
    float _S1026 = _S1025.differential_0.y * fy_7;
    *&(((&J_7)->rows + (int(0)))->y) = _S1025.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->y) = _S1026;
    float2  s_diff_uv_8 = (make_float2 (0.0f, 0.0f) - _S1016) / make_float2 (_S1018);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1027;
    (&_S1027)->primal_0 = _S1016 / make_float2 (_S1017);
    (&_S1027)->differential_0 = s_diff_uv_8;
    FixedArray<float, 8>  _S1028 = dist_coeffs_30;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1029 = s_fwd_DistThinPrism_distort_0(&_S1027, &_S1028);
    float _S1030 = _S1029.differential_0.y * fy_7;
    *&(((&J_7)->rows + (int(0)))->z) = _S1029.differential_0.x * fx_7;
    *&(((&J_7)->rows + (int(1)))->z) = _S1030;
    return J_7;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_prism(float3  p_view_18, float4  intrins_18, FixedArray<float, 8>  dist_coeffs_31)
{
    Matrix<float, 2, 3>  J_8;
    float2  _S1031 = float2 {p_view_18.x, p_view_18.y};
    float2  _S1032 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1033;
    (&_S1033)->primal_0 = _S1031;
    (&_S1033)->differential_0 = _S1032;
    DiffPair_float_0 _S1034 = s_fwd_length_impl_0(&_S1033);
    float _S1035 = p_view_18.z;
    DiffPair_float_0 _S1036;
    (&_S1036)->primal_0 = _S1034.primal_0;
    (&_S1036)->differential_0 = _S1034.differential_0;
    DiffPair_float_0 _S1037;
    (&_S1037)->primal_0 = _S1035;
    (&_S1037)->differential_0 = 0.0f;
    DiffPair_float_0 _S1038 = _d_atan2_0(&_S1036, &_S1037);
    float k_12;
    float s_diff_k_4;
    if((_S1038.primal_0) < 0.00100000004749745f)
    {
        float _S1039 = _S1038.differential_0 * _S1038.primal_0;
        float _S1040 = (0.0f - (_S1039 + _S1039) * 0.3333333432674408f) * _S1035 / (_S1035 * _S1035);
        k_12 = (1.0f - _S1038.primal_0 * _S1038.primal_0 / 3.0f) / _S1035;
        s_diff_k_4 = _S1040;
    }
    else
    {
        float _S1041 = (_S1038.differential_0 * _S1034.primal_0 - _S1038.primal_0 * _S1034.differential_0) / (_S1034.primal_0 * _S1034.primal_0);
        k_12 = _S1038.primal_0 / _S1034.primal_0;
        s_diff_k_4 = _S1041;
    }
    float2  _S1042 = _S1031 * make_float2 (k_12);
    float2  _S1043 = _S1032 * make_float2 (k_12) + make_float2 (s_diff_k_4) * _S1031;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1044;
    (&_S1044)->primal_0 = _S1042;
    (&_S1044)->differential_0 = _S1043;
    FixedArray<float, 8>  _S1045 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1046 = s_fwd_DistThinPrism_distort_0(&_S1044, &_S1045);
    float fx_8 = intrins_18.x;
    float fy_8 = intrins_18.y;
    float _S1047 = _S1046.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->x) = _S1046.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->x) = _S1047;
    float2  _S1048 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1049;
    (&_S1049)->primal_0 = _S1031;
    (&_S1049)->differential_0 = _S1048;
    DiffPair_float_0 _S1050 = s_fwd_length_impl_0(&_S1049);
    DiffPair_float_0 _S1051;
    (&_S1051)->primal_0 = _S1050.primal_0;
    (&_S1051)->differential_0 = _S1050.differential_0;
    DiffPair_float_0 _S1052;
    (&_S1052)->primal_0 = _S1035;
    (&_S1052)->differential_0 = 0.0f;
    DiffPair_float_0 _S1053 = _d_atan2_0(&_S1051, &_S1052);
    if((_S1053.primal_0) < 0.00100000004749745f)
    {
        float _S1054 = _S1053.differential_0 * _S1053.primal_0;
        float _S1055 = (0.0f - (_S1054 + _S1054) * 0.3333333432674408f) * _S1035 / (_S1035 * _S1035);
        k_12 = (1.0f - _S1053.primal_0 * _S1053.primal_0 / 3.0f) / _S1035;
        s_diff_k_4 = _S1055;
    }
    else
    {
        float _S1056 = (_S1053.differential_0 * _S1050.primal_0 - _S1053.primal_0 * _S1050.differential_0) / (_S1050.primal_0 * _S1050.primal_0);
        k_12 = _S1053.primal_0 / _S1050.primal_0;
        s_diff_k_4 = _S1056;
    }
    float2  _S1057 = _S1031 * make_float2 (k_12);
    float2  _S1058 = _S1048 * make_float2 (k_12) + make_float2 (s_diff_k_4) * _S1031;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1059;
    (&_S1059)->primal_0 = _S1057;
    (&_S1059)->differential_0 = _S1058;
    FixedArray<float, 8>  _S1060 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1061 = s_fwd_DistThinPrism_distort_0(&_S1059, &_S1060);
    float _S1062 = _S1061.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->y) = _S1061.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->y) = _S1062;
    float2  _S1063 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1064;
    (&_S1064)->primal_0 = _S1031;
    (&_S1064)->differential_0 = _S1063;
    DiffPair_float_0 _S1065 = s_fwd_length_impl_0(&_S1064);
    DiffPair_float_0 _S1066;
    (&_S1066)->primal_0 = _S1065.primal_0;
    (&_S1066)->differential_0 = _S1065.differential_0;
    DiffPair_float_0 _S1067;
    (&_S1067)->primal_0 = _S1035;
    (&_S1067)->differential_0 = 1.0f;
    DiffPair_float_0 _S1068 = _d_atan2_0(&_S1066, &_S1067);
    if((_S1068.primal_0) < 0.00100000004749745f)
    {
        float _S1069 = _S1068.differential_0 * _S1068.primal_0;
        float _S1070 = 1.0f - _S1068.primal_0 * _S1068.primal_0 / 3.0f;
        float _S1071 = ((0.0f - (_S1069 + _S1069) * 0.3333333432674408f) * _S1035 - _S1070) / (_S1035 * _S1035);
        k_12 = _S1070 / _S1035;
        s_diff_k_4 = _S1071;
    }
    else
    {
        float _S1072 = (_S1068.differential_0 * _S1065.primal_0 - _S1068.primal_0 * _S1065.differential_0) / (_S1065.primal_0 * _S1065.primal_0);
        k_12 = _S1068.primal_0 / _S1065.primal_0;
        s_diff_k_4 = _S1072;
    }
    float2  _S1073 = _S1031 * make_float2 (k_12);
    float2  _S1074 = make_float2 (s_diff_k_4) * _S1031;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1075;
    (&_S1075)->primal_0 = _S1073;
    (&_S1075)->differential_0 = _S1074;
    FixedArray<float, 8>  _S1076 = dist_coeffs_31;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1077 = s_fwd_DistThinPrism_distort_0(&_S1075, &_S1076);
    float _S1078 = _S1077.differential_0.y * fy_8;
    *&(((&J_8)->rows + (int(0)))->z) = _S1077.differential_0.x * fx_8;
    *&(((&J_8)->rows + (int(1)))->z) = _S1078;
    return J_8;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_prism(float3  p_view_19, float4  intrins_19, FixedArray<float, 8>  dist_coeffs_32)
{
    Matrix<float, 2, 3>  J_9;
    float2  _S1079 = float2 {p_view_19.x, p_view_19.y};
    float2  _S1080 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1081;
    (&_S1081)->primal_0 = _S1079;
    (&_S1081)->differential_0 = _S1080;
    DiffPair_float_0 _S1082 = s_fwd_length_impl_0(&_S1081);
    float _S1083 = p_view_19.z;
    DiffPair_float_0 _S1084;
    (&_S1084)->primal_0 = _S1082.primal_0;
    (&_S1084)->differential_0 = _S1082.differential_0;
    DiffPair_float_0 _S1085;
    (&_S1085)->primal_0 = _S1083;
    (&_S1085)->differential_0 = 0.0f;
    DiffPair_float_0 _S1086 = _d_atan2_0(&_S1084, &_S1085);
    float k_13;
    float s_diff_k_5;
    if((_S1082.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1087 = _S1086.differential_0 * _S1086.primal_0;
        float _S1088 = (0.0f - (_S1087 + _S1087) * 0.0416666679084301f) * _S1083 / (_S1083 * _S1083);
        k_13 = (1.0f - _S1086.primal_0 * _S1086.primal_0 / 24.0f) / _S1083;
        s_diff_k_5 = _S1088;
    }
    else
    {
        float _S1089 = _S1086.differential_0 * 0.5f;
        DiffPair_float_0 _S1090;
        (&_S1090)->primal_0 = 0.5f * _S1086.primal_0;
        (&_S1090)->differential_0 = _S1089;
        DiffPair_float_0 _S1091 = _d_sin_0(&_S1090);
        float _S1092 = 2.0f * _S1091.primal_0;
        float _S1093 = (_S1091.differential_0 * 2.0f * _S1082.primal_0 - _S1092 * _S1082.differential_0) / (_S1082.primal_0 * _S1082.primal_0);
        k_13 = _S1092 / _S1082.primal_0;
        s_diff_k_5 = _S1093;
    }
    float2  _S1094 = _S1079 * make_float2 (k_13);
    float2  _S1095 = _S1080 * make_float2 (k_13) + make_float2 (s_diff_k_5) * _S1079;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1096;
    (&_S1096)->primal_0 = _S1094;
    (&_S1096)->differential_0 = _S1095;
    FixedArray<float, 8>  _S1097 = dist_coeffs_32;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1098 = s_fwd_DistThinPrism_distort_0(&_S1096, &_S1097);
    float fx_9 = intrins_19.x;
    float fy_9 = intrins_19.y;
    float _S1099 = _S1098.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->x) = _S1098.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->x) = _S1099;
    float2  _S1100 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1101;
    (&_S1101)->primal_0 = _S1079;
    (&_S1101)->differential_0 = _S1100;
    DiffPair_float_0 _S1102 = s_fwd_length_impl_0(&_S1101);
    DiffPair_float_0 _S1103;
    (&_S1103)->primal_0 = _S1102.primal_0;
    (&_S1103)->differential_0 = _S1102.differential_0;
    DiffPair_float_0 _S1104;
    (&_S1104)->primal_0 = _S1083;
    (&_S1104)->differential_0 = 0.0f;
    DiffPair_float_0 _S1105 = _d_atan2_0(&_S1103, &_S1104);
    if((_S1102.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1106 = _S1105.differential_0 * _S1105.primal_0;
        float _S1107 = (0.0f - (_S1106 + _S1106) * 0.0416666679084301f) * _S1083 / (_S1083 * _S1083);
        k_13 = (1.0f - _S1105.primal_0 * _S1105.primal_0 / 24.0f) / _S1083;
        s_diff_k_5 = _S1107;
    }
    else
    {
        float _S1108 = _S1105.differential_0 * 0.5f;
        DiffPair_float_0 _S1109;
        (&_S1109)->primal_0 = 0.5f * _S1105.primal_0;
        (&_S1109)->differential_0 = _S1108;
        DiffPair_float_0 _S1110 = _d_sin_0(&_S1109);
        float _S1111 = 2.0f * _S1110.primal_0;
        float _S1112 = (_S1110.differential_0 * 2.0f * _S1102.primal_0 - _S1111 * _S1102.differential_0) / (_S1102.primal_0 * _S1102.primal_0);
        k_13 = _S1111 / _S1102.primal_0;
        s_diff_k_5 = _S1112;
    }
    float2  _S1113 = _S1079 * make_float2 (k_13);
    float2  _S1114 = _S1100 * make_float2 (k_13) + make_float2 (s_diff_k_5) * _S1079;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1115;
    (&_S1115)->primal_0 = _S1113;
    (&_S1115)->differential_0 = _S1114;
    FixedArray<float, 8>  _S1116 = dist_coeffs_32;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1117 = s_fwd_DistThinPrism_distort_0(&_S1115, &_S1116);
    float _S1118 = _S1117.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->y) = _S1117.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->y) = _S1118;
    float2  _S1119 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1120;
    (&_S1120)->primal_0 = _S1079;
    (&_S1120)->differential_0 = _S1119;
    DiffPair_float_0 _S1121 = s_fwd_length_impl_0(&_S1120);
    DiffPair_float_0 _S1122;
    (&_S1122)->primal_0 = _S1121.primal_0;
    (&_S1122)->differential_0 = _S1121.differential_0;
    DiffPair_float_0 _S1123;
    (&_S1123)->primal_0 = _S1083;
    (&_S1123)->differential_0 = 1.0f;
    DiffPair_float_0 _S1124 = _d_atan2_0(&_S1122, &_S1123);
    if((_S1121.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1125 = _S1124.differential_0 * _S1124.primal_0;
        float _S1126 = 1.0f - _S1124.primal_0 * _S1124.primal_0 / 24.0f;
        float _S1127 = ((0.0f - (_S1125 + _S1125) * 0.0416666679084301f) * _S1083 - _S1126) / (_S1083 * _S1083);
        k_13 = _S1126 / _S1083;
        s_diff_k_5 = _S1127;
    }
    else
    {
        float _S1128 = _S1124.differential_0 * 0.5f;
        DiffPair_float_0 _S1129;
        (&_S1129)->primal_0 = 0.5f * _S1124.primal_0;
        (&_S1129)->differential_0 = _S1128;
        DiffPair_float_0 _S1130 = _d_sin_0(&_S1129);
        float _S1131 = 2.0f * _S1130.primal_0;
        float _S1132 = (_S1130.differential_0 * 2.0f * _S1121.primal_0 - _S1131 * _S1121.differential_0) / (_S1121.primal_0 * _S1121.primal_0);
        k_13 = _S1131 / _S1121.primal_0;
        s_diff_k_5 = _S1132;
    }
    float2  _S1133 = _S1079 * make_float2 (k_13);
    float2  _S1134 = make_float2 (s_diff_k_5) * _S1079;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1135;
    (&_S1135)->primal_0 = _S1133;
    (&_S1135)->differential_0 = _S1134;
    FixedArray<float, 8>  _S1136 = dist_coeffs_32;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1137 = s_fwd_DistThinPrism_distort_0(&_S1135, &_S1136);
    float _S1138 = _S1137.differential_0.y * fy_9;
    *&(((&J_9)->rows + (int(0)))->z) = _S1137.differential_0.x * fx_9;
    *&(((&J_9)->rows + (int(1)))->z) = _S1138;
    return J_9;
}

inline __device__ float2  distort_point_prism(float2  uv_32, int camera_model_8, FixedArray<float, 8>  dist_coeffs_33)
{
    float2  _S1139;
    for(;;)
    {
        if(camera_model_8 == int(3))
        {
            _S1139 = uv_32;
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
            _S1139 = uv_32 * make_float2 (k_14);
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
                _S1139 = uv_32 * make_float2 (k_14);
            }
            else
            {
                _S1139 = uv_32;
            }
        }
        FixedArray<float, 8>  _S1140 = dist_coeffs_33;
        float2  _S1141 = DistThinPrism_distort_0(_S1139, &_S1140);
        _S1139 = _S1141;
        break;
    }
    return _S1139;
}

inline __device__ bool undistort_point_prism(float2  uv_33, int camera_model_9, FixedArray<float, 8>  dist_coeffs_34, float2  * uv_undist_6)
{
    bool _S1142;
    for(;;)
    {
        *uv_undist_6 = make_float2 (0.0f);
        if(camera_model_9 == int(3))
        {
            float lon_4 = uv_33.x;
            float lat_6 = uv_33.y;
            float cl_6 = (F32_cos((lat_6)));
            *uv_undist_6 = make_float2 (cl_6 * (F32_sin((lon_4))), (F32_sin((lat_6)))) / make_float2 ((F32_max((cl_6 * (F32_cos((lon_4)))), (9.999999960041972e-13f))));
            _S1142 = true;
            break;
        }
        FixedArray<float, 8>  _S1143 = dist_coeffs_34;
        float2  uv_u_6;
        bool _S1144 = undistort_point_1(uv_33, &_S1143, int(8), &uv_u_6);
        if(!_S1144)
        {
            _S1142 = false;
            break;
        }
        float2  _S1145 = uv_u_6;
        float3  raydir_6;
        if(camera_model_9 == int(1))
        {
            float r_30 = length_0(_S1145);
            float s_6;
            if(r_30 < 0.00100000004749745f)
            {
                s_6 = 1.0f - r_30 * r_30 / 6.0f;
            }
            else
            {
                s_6 = (F32_sin((r_30))) / r_30;
            }
            raydir_6 = make_float3 ((_S1145 * make_float2 (s_6)).x, (_S1145 * make_float2 (s_6)).y, (F32_cos((r_30))));
        }
        else
        {
            if(camera_model_9 == int(2))
            {
                float r_31 = length_0(_S1145);
                raydir_6 = make_float3 ((_S1145 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_31 * r_31)))))))).x, (_S1145 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_31 * r_31)))))))).y, 1.0f - 0.5f * r_31 * r_31);
            }
            else
            {
                raydir_6 = make_float3 (_S1145.x, _S1145.y, 1.0f);
            }
        }
        *uv_undist_6 = float2 {raydir_6.x, raydir_6.y} / make_float2 ((F32_max((raydir_6.z), (9.999999960041972e-13f))));
        _S1142 = true;
        break;
    }
    return _S1142;
}

inline __device__ bool unproject_point_prism(float2  uv_34, int camera_model_10, FixedArray<float, 8>  dist_coeffs_35, float3  * raydir_7)
{
    bool _S1146;
    for(;;)
    {
        int3  _S1147 = make_int3 (int(0));
        float3  _S1148 = make_float3 ((float)_S1147.x, (float)_S1147.y, (float)_S1147.z);
        *raydir_7 = _S1148;
        if(camera_model_10 == int(3))
        {
            float lon_5 = uv_34.x;
            float lat_7 = uv_34.y;
            float cl_7 = (F32_cos((lat_7)));
            *raydir_7 = make_float3 (cl_7 * (F32_sin((lon_5))), (F32_sin((lat_7))), cl_7 * (F32_cos((lon_5))));
            _S1146 = true;
            break;
        }
        FixedArray<float, 8>  _S1149 = dist_coeffs_35;
        float2  uv_u_7;
        bool _S1150 = undistort_point_1(uv_34, &_S1149, int(8), &uv_u_7);
        if(!_S1150)
        {
            _S1146 = false;
            break;
        }
        float2  _S1151 = uv_u_7;
        if(camera_model_10 == int(1))
        {
            float r_32 = length_0(_S1151);
            float s_7;
            if(r_32 < 0.00100000004749745f)
            {
                s_7 = 1.0f - r_32 * r_32 / 6.0f;
            }
            else
            {
                s_7 = (F32_sin((r_32))) / r_32;
            }
            *raydir_7 = make_float3 ((_S1151 * make_float2 (s_7)).x, (_S1151 * make_float2 (s_7)).y, (F32_cos((r_32))));
        }
        else
        {
            if(camera_model_10 == int(2))
            {
                float r_33 = length_0(_S1151);
                *raydir_7 = make_float3 ((_S1151 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_33 * r_33)))))))).x, (_S1151 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_33 * r_33)))))))).y, 1.0f - 0.5f * r_33 * r_33);
            }
            else
            {
                *raydir_7 = make_float3 (_S1151.x, _S1151.y, 1.0f);
            }
        }
        _S1146 = true;
        break;
    }
    return _S1146;
}

inline __device__ bool generate_ray_prism(float2  uv_35, int camera_model_11, FixedArray<float, 8>  dist_coeffs_36, float3  * raydir_8)
{
    bool _S1152;
    for(;;)
    {
        if(camera_model_11 == int(3))
        {
            float _S1153 = uv_35.x;
            if((F32_abs((_S1153))) > 3.14159274101257324f)
            {
                _S1152 = true;
            }
            else
            {
                _S1152 = (F32_abs((uv_35.y))) > 1.57079637050628662f;
            }
            if(_S1152)
            {
                int3  _S1154 = make_int3 (int(0));
                float3  _S1155 = make_float3 ((float)_S1154.x, (float)_S1154.y, (float)_S1154.z);
                *raydir_8 = _S1155;
                _S1152 = false;
                break;
            }
            float lat_8 = uv_35.y;
            float cl_8 = (F32_cos((lat_8)));
            *raydir_8 = make_float3 (cl_8 * (F32_sin((_S1153))), (F32_sin((lat_8))), cl_8 * (F32_cos((_S1153))));
            _S1152 = true;
            break;
        }
        FixedArray<float, 8>  _S1156 = dist_coeffs_36;
        float2  uv_u_8;
        bool _S1157 = undistort_point_1(uv_35, &_S1156, int(8), &uv_u_8);
        if(!_S1157)
        {
            int3  _S1158 = make_int3 (int(0));
            float3  _S1159 = make_float3 ((float)_S1158.x, (float)_S1158.y, (float)_S1158.z);
            *raydir_8 = _S1159;
            _S1152 = false;
            break;
        }
        float2  _S1160 = uv_u_8;
        if(camera_model_11 == int(1))
        {
            float r_34 = length_0(_S1160);
            if(r_34 >= 3.14159274101257324f)
            {
                int3  _S1161 = make_int3 (int(0));
                float3  _S1162 = make_float3 ((float)_S1161.x, (float)_S1161.y, (float)_S1161.z);
                *raydir_8 = _S1162;
                _S1152 = false;
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
            *raydir_8 = make_float3 ((_S1160 * make_float2 (s_8)).x, (_S1160 * make_float2 (s_8)).y, (F32_cos((r_34))));
        }
        else
        {
            if(camera_model_11 == int(2))
            {
                float r_35 = length_0(_S1160);
                if(r_35 >= 2.0f)
                {
                    int3  _S1163 = make_int3 (int(0));
                    float3  _S1164 = make_float3 ((float)_S1163.x, (float)_S1163.y, (float)_S1163.z);
                    *raydir_8 = _S1164;
                    _S1152 = false;
                    break;
                }
                *raydir_8 = make_float3 ((_S1160 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_35 * r_35)))))))).x, (_S1160 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_35 * r_35)))))))).y, 1.0f - 0.5f * r_35 * r_35);
            }
            else
            {
                *raydir_8 = make_float3 (_S1160.x, _S1160.y, 1.0f);
            }
        }
        *raydir_8 = normalize_0(*raydir_8);
        _S1152 = true;
        break;
    }
    return _S1152;
}

inline __device__ bool is_valid_distortion_polar(float2  uv_36, FixedArray<float, 58>  dist_coeffs_37)
{
    float2  _S1165 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1166;
    (&_S1166)->primal_0 = uv_36;
    (&_S1166)->differential_0 = _S1165;
    FixedArray<float, 58>  _S1167 = dist_coeffs_37;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1168 = s_fwd_DistKBPolarSpline_distort_0(&_S1166, &_S1167);
    float2  _S1169 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1170;
    (&_S1170)->primal_0 = uv_36;
    (&_S1170)->differential_0 = _S1169;
    FixedArray<float, 58>  _S1171 = dist_coeffs_37;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1172 = s_fwd_DistKBPolarSpline_distort_0(&_S1170, &_S1171);
    Matrix<float, 2, 2>  _S1173 = transpose_1(makeMatrix<float, 2, 2> (_S1168.differential_0, _S1172.differential_0));
    float _S1174 = (F32_min((determinant_0(_S1173)), ((F32_min((_S1173.rows[int(0)].x), (_S1173.rows[int(1)].y))))));
    bool _S1175;
    if(_S1174 > 0.25f)
    {
        _S1175 = _S1174 < 4.0f;
    }
    else
    {
        _S1175 = false;
    }
    if(_S1175)
    {
        FixedArray<float, 58>  _S1176 = dist_coeffs_37;
        float2  _S1177 = DistKBPolarSpline_distort_0(uv_36, &_S1176);
        _S1175 = (dot_1(uv_36, _S1177)) >= 0.0f;
    }
    else
    {
        _S1175 = false;
    }
    return _S1175;
}

inline __device__ bool persp_proj_nav_polar(float3  p_view_20, float4  intrins_20, FixedArray<float, 58>  dist_coeffs_38, float2  * uv_37)
{
    bool _S1178;
    for(;;)
    {
        float2  _S1179 = float2 {p_view_20.x, p_view_20.y};
        float _S1180 = p_view_20.z;
        float2  uv0_3 = _S1179 / make_float2 (_S1180);
        if(_S1180 < 0.0f)
        {
            _S1178 = true;
        }
        else
        {
            float2  _S1181 = make_float2 (1.0f, 0.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S1182;
            (&_S1182)->primal_0 = uv0_3;
            (&_S1182)->differential_0 = _S1181;
            FixedArray<float, 58>  _S1183 = dist_coeffs_38;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S1184 = s_fwd_DistKBPolarSpline_distort_0(&_S1182, &_S1183);
            float2  _S1185 = make_float2 (0.0f, 1.0f);
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S1186;
            (&_S1186)->primal_0 = uv0_3;
            (&_S1186)->differential_0 = _S1185;
            FixedArray<float, 58>  _S1187 = dist_coeffs_38;
            DiffPair_vectorx3Cfloatx2C2x3E_0 _S1188 = s_fwd_DistKBPolarSpline_distort_0(&_S1186, &_S1187);
            Matrix<float, 2, 2>  _S1189 = transpose_1(makeMatrix<float, 2, 2> (_S1184.differential_0, _S1188.differential_0));
            float _S1190 = (F32_min((determinant_0(_S1189)), ((F32_min((_S1189.rows[int(0)].x), (_S1189.rows[int(1)].y))))));
            if(_S1190 > 0.25f)
            {
                _S1178 = _S1190 < 4.0f;
            }
            else
            {
                _S1178 = false;
            }
            if(_S1178)
            {
                FixedArray<float, 58>  _S1191 = dist_coeffs_38;
                float2  _S1192 = DistKBPolarSpline_distort_0(uv0_3, &_S1191);
                _S1178 = (dot_1(uv0_3, _S1192)) >= 0.0f;
            }
            else
            {
                _S1178 = false;
            }
            _S1178 = !_S1178;
        }
        if(_S1178)
        {
            *uv_37 = uv0_3;
            _S1178 = false;
            break;
        }
        float2  uv_38 = _S1179 / make_float2 (_S1180);
        FixedArray<float, 58>  _S1193 = dist_coeffs_38;
        float2  _S1194 = DistKBPolarSpline_distort_0(uv_38, &_S1193);
        *uv_37 = make_float2 (intrins_20.x * _S1194.x + intrins_20.z, intrins_20.y * _S1194.y + intrins_20.w);
        _S1178 = true;
        break;
    }
    return _S1178;
}

inline __device__ bool fisheye_proj_nav_polar(float3  p_view_21, float4  intrins_21, FixedArray<float, 58>  dist_coeffs_39, float2  * uv_39)
{
    bool _S1195;
    for(;;)
    {
        float2  _S1196 = float2 {p_view_21.x, p_view_21.y};
        float r_36 = length_0(_S1196);
        float _S1197 = p_view_21.z;
        float theta_16 = (F32_atan2((r_36), (_S1197)));
        bool _S1198 = theta_16 < 0.00100000004749745f;
        float k_15;
        if(_S1198)
        {
            k_15 = (1.0f - theta_16 * theta_16 / 3.0f) / _S1197;
        }
        else
        {
            k_15 = theta_16 / r_36;
        }
        float2  _S1199 = _S1196 * make_float2 (k_15);
        float2  _S1200 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1201;
        (&_S1201)->primal_0 = _S1199;
        (&_S1201)->differential_0 = _S1200;
        FixedArray<float, 58>  _S1202 = dist_coeffs_39;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1203 = s_fwd_DistKBPolarSpline_distort_0(&_S1201, &_S1202);
        float2  _S1204 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1205;
        (&_S1205)->primal_0 = _S1199;
        (&_S1205)->differential_0 = _S1204;
        FixedArray<float, 58>  _S1206 = dist_coeffs_39;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1207 = s_fwd_DistKBPolarSpline_distort_0(&_S1205, &_S1206);
        Matrix<float, 2, 2>  _S1208 = transpose_1(makeMatrix<float, 2, 2> (_S1203.differential_0, _S1207.differential_0));
        float _S1209 = (F32_min((determinant_0(_S1208)), ((F32_min((_S1208.rows[int(0)].x), (_S1208.rows[int(1)].y))))));
        if(_S1209 > 0.25f)
        {
            _S1195 = _S1209 < 4.0f;
        }
        else
        {
            _S1195 = false;
        }
        if(_S1195)
        {
            FixedArray<float, 58>  _S1210 = dist_coeffs_39;
            float2  _S1211 = DistKBPolarSpline_distort_0(_S1199, &_S1210);
            _S1195 = (dot_1(_S1199, _S1211)) >= 0.0f;
        }
        else
        {
            _S1195 = false;
        }
        if(!_S1195)
        {
            *uv_39 = _S1199;
            _S1195 = false;
            break;
        }
        if(_S1198)
        {
            k_15 = (1.0f - theta_16 * theta_16 / 3.0f) / _S1197;
        }
        else
        {
            k_15 = theta_16 / r_36;
        }
        float2  _S1212 = _S1196 * make_float2 (k_15);
        FixedArray<float, 58>  _S1213 = dist_coeffs_39;
        float2  _S1214 = DistKBPolarSpline_distort_0(_S1212, &_S1213);
        *uv_39 = make_float2 (intrins_21.x * _S1214.x + intrins_21.z, intrins_21.y * _S1214.y + intrins_21.w);
        _S1195 = true;
        break;
    }
    return _S1195;
}

inline __device__ bool equisolid_proj_nav_polar(float3  p_view_22, float4  intrins_22, FixedArray<float, 58>  dist_coeffs_40, float2  * uv_40)
{
    bool _S1215;
    for(;;)
    {
        float2  _S1216 = float2 {p_view_22.x, p_view_22.y};
        float r_37 = length_0(_S1216);
        float _S1217 = p_view_22.z;
        float theta_17 = (F32_atan2((r_37), (_S1217)));
        bool _S1218 = r_37 < 9.99999997475242708e-07f;
        float k_16;
        if(_S1218)
        {
            k_16 = (1.0f - theta_17 * theta_17 / 24.0f) / _S1217;
        }
        else
        {
            k_16 = 2.0f * (F32_sin((0.5f * theta_17))) / r_37;
        }
        float2  _S1219 = _S1216 * make_float2 (k_16);
        float2  _S1220 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1221;
        (&_S1221)->primal_0 = _S1219;
        (&_S1221)->differential_0 = _S1220;
        FixedArray<float, 58>  _S1222 = dist_coeffs_40;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1223 = s_fwd_DistKBPolarSpline_distort_0(&_S1221, &_S1222);
        float2  _S1224 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1225;
        (&_S1225)->primal_0 = _S1219;
        (&_S1225)->differential_0 = _S1224;
        FixedArray<float, 58>  _S1226 = dist_coeffs_40;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1227 = s_fwd_DistKBPolarSpline_distort_0(&_S1225, &_S1226);
        Matrix<float, 2, 2>  _S1228 = transpose_1(makeMatrix<float, 2, 2> (_S1223.differential_0, _S1227.differential_0));
        float _S1229 = (F32_min((determinant_0(_S1228)), ((F32_min((_S1228.rows[int(0)].x), (_S1228.rows[int(1)].y))))));
        if(_S1229 > 0.25f)
        {
            _S1215 = _S1229 < 4.0f;
        }
        else
        {
            _S1215 = false;
        }
        if(_S1215)
        {
            FixedArray<float, 58>  _S1230 = dist_coeffs_40;
            float2  _S1231 = DistKBPolarSpline_distort_0(_S1219, &_S1230);
            _S1215 = (dot_1(_S1219, _S1231)) >= 0.0f;
        }
        else
        {
            _S1215 = false;
        }
        if(!_S1215)
        {
            *uv_40 = _S1219;
            _S1215 = false;
            break;
        }
        if(_S1218)
        {
            k_16 = (1.0f - theta_17 * theta_17 / 24.0f) / _S1217;
        }
        else
        {
            k_16 = 2.0f * (F32_sin((0.5f * theta_17))) / r_37;
        }
        float2  _S1232 = _S1216 * make_float2 (k_16);
        FixedArray<float, 58>  _S1233 = dist_coeffs_40;
        float2  _S1234 = DistKBPolarSpline_distort_0(_S1232, &_S1233);
        *uv_40 = make_float2 (intrins_22.x * _S1234.x + intrins_22.z, intrins_22.y * _S1234.y + intrins_22.w);
        _S1215 = true;
        break;
    }
    return _S1215;
}

inline __device__ Matrix<float, 2, 3>  persp_proj_jac_polar(float3  p_view_23, float4  intrins_23, FixedArray<float, 58>  dist_coeffs_41)
{
    float2  _S1235 = float2 {p_view_23.x, p_view_23.y};
    float _S1236 = p_view_23.z;
    float _S1237 = _S1236 * _S1236;
    float2  s_diff_uv_9 = make_float2 (1.0f, 0.0f) * make_float2 (_S1236) / make_float2 (_S1237);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1238;
    (&_S1238)->primal_0 = _S1235 / make_float2 (_S1236);
    (&_S1238)->differential_0 = s_diff_uv_9;
    FixedArray<float, 58>  _S1239 = dist_coeffs_41;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1240 = s_fwd_DistKBPolarSpline_distort_0(&_S1238, &_S1239);
    float fx_10 = intrins_23.x;
    float fy_10 = intrins_23.y;
    float _S1241 = _S1240.differential_0.y * fy_10;
    Matrix<float, 2, 3>  J_10;
    *&(((&J_10)->rows + (int(0)))->x) = _S1240.differential_0.x * fx_10;
    *&(((&J_10)->rows + (int(1)))->x) = _S1241;
    float2  s_diff_uv_10 = make_float2 (0.0f, 1.0f) * make_float2 (_S1236) / make_float2 (_S1237);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1242;
    (&_S1242)->primal_0 = _S1235 / make_float2 (_S1236);
    (&_S1242)->differential_0 = s_diff_uv_10;
    FixedArray<float, 58>  _S1243 = dist_coeffs_41;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1244 = s_fwd_DistKBPolarSpline_distort_0(&_S1242, &_S1243);
    float _S1245 = _S1244.differential_0.y * fy_10;
    *&(((&J_10)->rows + (int(0)))->y) = _S1244.differential_0.x * fx_10;
    *&(((&J_10)->rows + (int(1)))->y) = _S1245;
    float2  s_diff_uv_11 = (make_float2 (0.0f, 0.0f) - _S1235) / make_float2 (_S1237);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1246;
    (&_S1246)->primal_0 = _S1235 / make_float2 (_S1236);
    (&_S1246)->differential_0 = s_diff_uv_11;
    FixedArray<float, 58>  _S1247 = dist_coeffs_41;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1248 = s_fwd_DistKBPolarSpline_distort_0(&_S1246, &_S1247);
    float _S1249 = _S1248.differential_0.y * fy_10;
    *&(((&J_10)->rows + (int(0)))->z) = _S1248.differential_0.x * fx_10;
    *&(((&J_10)->rows + (int(1)))->z) = _S1249;
    return J_10;
}

inline __device__ Matrix<float, 2, 3>  fisheye_proj_jac_polar(float3  p_view_24, float4  intrins_24, FixedArray<float, 58>  dist_coeffs_42)
{
    Matrix<float, 2, 3>  J_11;
    float2  _S1250 = float2 {p_view_24.x, p_view_24.y};
    float2  _S1251 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1252;
    (&_S1252)->primal_0 = _S1250;
    (&_S1252)->differential_0 = _S1251;
    DiffPair_float_0 _S1253 = s_fwd_length_impl_0(&_S1252);
    float _S1254 = p_view_24.z;
    DiffPair_float_0 _S1255;
    (&_S1255)->primal_0 = _S1253.primal_0;
    (&_S1255)->differential_0 = _S1253.differential_0;
    DiffPair_float_0 _S1256;
    (&_S1256)->primal_0 = _S1254;
    (&_S1256)->differential_0 = 0.0f;
    DiffPair_float_0 _S1257 = _d_atan2_0(&_S1255, &_S1256);
    float k_17;
    float s_diff_k_6;
    if((_S1257.primal_0) < 0.00100000004749745f)
    {
        float _S1258 = _S1257.differential_0 * _S1257.primal_0;
        float _S1259 = (0.0f - (_S1258 + _S1258) * 0.3333333432674408f) * _S1254 / (_S1254 * _S1254);
        k_17 = (1.0f - _S1257.primal_0 * _S1257.primal_0 / 3.0f) / _S1254;
        s_diff_k_6 = _S1259;
    }
    else
    {
        float _S1260 = (_S1257.differential_0 * _S1253.primal_0 - _S1257.primal_0 * _S1253.differential_0) / (_S1253.primal_0 * _S1253.primal_0);
        k_17 = _S1257.primal_0 / _S1253.primal_0;
        s_diff_k_6 = _S1260;
    }
    float2  _S1261 = _S1250 * make_float2 (k_17);
    float2  _S1262 = _S1251 * make_float2 (k_17) + make_float2 (s_diff_k_6) * _S1250;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1263;
    (&_S1263)->primal_0 = _S1261;
    (&_S1263)->differential_0 = _S1262;
    FixedArray<float, 58>  _S1264 = dist_coeffs_42;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1265 = s_fwd_DistKBPolarSpline_distort_0(&_S1263, &_S1264);
    float fx_11 = intrins_24.x;
    float fy_11 = intrins_24.y;
    float _S1266 = _S1265.differential_0.y * fy_11;
    *&(((&J_11)->rows + (int(0)))->x) = _S1265.differential_0.x * fx_11;
    *&(((&J_11)->rows + (int(1)))->x) = _S1266;
    float2  _S1267 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1268;
    (&_S1268)->primal_0 = _S1250;
    (&_S1268)->differential_0 = _S1267;
    DiffPair_float_0 _S1269 = s_fwd_length_impl_0(&_S1268);
    DiffPair_float_0 _S1270;
    (&_S1270)->primal_0 = _S1269.primal_0;
    (&_S1270)->differential_0 = _S1269.differential_0;
    DiffPair_float_0 _S1271;
    (&_S1271)->primal_0 = _S1254;
    (&_S1271)->differential_0 = 0.0f;
    DiffPair_float_0 _S1272 = _d_atan2_0(&_S1270, &_S1271);
    if((_S1272.primal_0) < 0.00100000004749745f)
    {
        float _S1273 = _S1272.differential_0 * _S1272.primal_0;
        float _S1274 = (0.0f - (_S1273 + _S1273) * 0.3333333432674408f) * _S1254 / (_S1254 * _S1254);
        k_17 = (1.0f - _S1272.primal_0 * _S1272.primal_0 / 3.0f) / _S1254;
        s_diff_k_6 = _S1274;
    }
    else
    {
        float _S1275 = (_S1272.differential_0 * _S1269.primal_0 - _S1272.primal_0 * _S1269.differential_0) / (_S1269.primal_0 * _S1269.primal_0);
        k_17 = _S1272.primal_0 / _S1269.primal_0;
        s_diff_k_6 = _S1275;
    }
    float2  _S1276 = _S1250 * make_float2 (k_17);
    float2  _S1277 = _S1267 * make_float2 (k_17) + make_float2 (s_diff_k_6) * _S1250;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1278;
    (&_S1278)->primal_0 = _S1276;
    (&_S1278)->differential_0 = _S1277;
    FixedArray<float, 58>  _S1279 = dist_coeffs_42;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1280 = s_fwd_DistKBPolarSpline_distort_0(&_S1278, &_S1279);
    float _S1281 = _S1280.differential_0.y * fy_11;
    *&(((&J_11)->rows + (int(0)))->y) = _S1280.differential_0.x * fx_11;
    *&(((&J_11)->rows + (int(1)))->y) = _S1281;
    float2  _S1282 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1283;
    (&_S1283)->primal_0 = _S1250;
    (&_S1283)->differential_0 = _S1282;
    DiffPair_float_0 _S1284 = s_fwd_length_impl_0(&_S1283);
    DiffPair_float_0 _S1285;
    (&_S1285)->primal_0 = _S1284.primal_0;
    (&_S1285)->differential_0 = _S1284.differential_0;
    DiffPair_float_0 _S1286;
    (&_S1286)->primal_0 = _S1254;
    (&_S1286)->differential_0 = 1.0f;
    DiffPair_float_0 _S1287 = _d_atan2_0(&_S1285, &_S1286);
    if((_S1287.primal_0) < 0.00100000004749745f)
    {
        float _S1288 = _S1287.differential_0 * _S1287.primal_0;
        float _S1289 = 1.0f - _S1287.primal_0 * _S1287.primal_0 / 3.0f;
        float _S1290 = ((0.0f - (_S1288 + _S1288) * 0.3333333432674408f) * _S1254 - _S1289) / (_S1254 * _S1254);
        k_17 = _S1289 / _S1254;
        s_diff_k_6 = _S1290;
    }
    else
    {
        float _S1291 = (_S1287.differential_0 * _S1284.primal_0 - _S1287.primal_0 * _S1284.differential_0) / (_S1284.primal_0 * _S1284.primal_0);
        k_17 = _S1287.primal_0 / _S1284.primal_0;
        s_diff_k_6 = _S1291;
    }
    float2  _S1292 = _S1250 * make_float2 (k_17);
    float2  _S1293 = make_float2 (s_diff_k_6) * _S1250;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1294;
    (&_S1294)->primal_0 = _S1292;
    (&_S1294)->differential_0 = _S1293;
    FixedArray<float, 58>  _S1295 = dist_coeffs_42;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1296 = s_fwd_DistKBPolarSpline_distort_0(&_S1294, &_S1295);
    float _S1297 = _S1296.differential_0.y * fy_11;
    *&(((&J_11)->rows + (int(0)))->z) = _S1296.differential_0.x * fx_11;
    *&(((&J_11)->rows + (int(1)))->z) = _S1297;
    return J_11;
}

inline __device__ Matrix<float, 2, 3>  equisolid_proj_jac_polar(float3  p_view_25, float4  intrins_25, FixedArray<float, 58>  dist_coeffs_43)
{
    Matrix<float, 2, 3>  J_12;
    float2  _S1298 = float2 {p_view_25.x, p_view_25.y};
    float2  _S1299 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1300;
    (&_S1300)->primal_0 = _S1298;
    (&_S1300)->differential_0 = _S1299;
    DiffPair_float_0 _S1301 = s_fwd_length_impl_0(&_S1300);
    float _S1302 = p_view_25.z;
    DiffPair_float_0 _S1303;
    (&_S1303)->primal_0 = _S1301.primal_0;
    (&_S1303)->differential_0 = _S1301.differential_0;
    DiffPair_float_0 _S1304;
    (&_S1304)->primal_0 = _S1302;
    (&_S1304)->differential_0 = 0.0f;
    DiffPair_float_0 _S1305 = _d_atan2_0(&_S1303, &_S1304);
    float k_18;
    float s_diff_k_7;
    if((_S1301.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1306 = _S1305.differential_0 * _S1305.primal_0;
        float _S1307 = (0.0f - (_S1306 + _S1306) * 0.0416666679084301f) * _S1302 / (_S1302 * _S1302);
        k_18 = (1.0f - _S1305.primal_0 * _S1305.primal_0 / 24.0f) / _S1302;
        s_diff_k_7 = _S1307;
    }
    else
    {
        float _S1308 = _S1305.differential_0 * 0.5f;
        DiffPair_float_0 _S1309;
        (&_S1309)->primal_0 = 0.5f * _S1305.primal_0;
        (&_S1309)->differential_0 = _S1308;
        DiffPair_float_0 _S1310 = _d_sin_0(&_S1309);
        float _S1311 = 2.0f * _S1310.primal_0;
        float _S1312 = (_S1310.differential_0 * 2.0f * _S1301.primal_0 - _S1311 * _S1301.differential_0) / (_S1301.primal_0 * _S1301.primal_0);
        k_18 = _S1311 / _S1301.primal_0;
        s_diff_k_7 = _S1312;
    }
    float2  _S1313 = _S1298 * make_float2 (k_18);
    float2  _S1314 = _S1299 * make_float2 (k_18) + make_float2 (s_diff_k_7) * _S1298;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1315;
    (&_S1315)->primal_0 = _S1313;
    (&_S1315)->differential_0 = _S1314;
    FixedArray<float, 58>  _S1316 = dist_coeffs_43;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1317 = s_fwd_DistKBPolarSpline_distort_0(&_S1315, &_S1316);
    float fx_12 = intrins_25.x;
    float fy_12 = intrins_25.y;
    float _S1318 = _S1317.differential_0.y * fy_12;
    *&(((&J_12)->rows + (int(0)))->x) = _S1317.differential_0.x * fx_12;
    *&(((&J_12)->rows + (int(1)))->x) = _S1318;
    float2  _S1319 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1320;
    (&_S1320)->primal_0 = _S1298;
    (&_S1320)->differential_0 = _S1319;
    DiffPair_float_0 _S1321 = s_fwd_length_impl_0(&_S1320);
    DiffPair_float_0 _S1322;
    (&_S1322)->primal_0 = _S1321.primal_0;
    (&_S1322)->differential_0 = _S1321.differential_0;
    DiffPair_float_0 _S1323;
    (&_S1323)->primal_0 = _S1302;
    (&_S1323)->differential_0 = 0.0f;
    DiffPair_float_0 _S1324 = _d_atan2_0(&_S1322, &_S1323);
    if((_S1321.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1325 = _S1324.differential_0 * _S1324.primal_0;
        float _S1326 = (0.0f - (_S1325 + _S1325) * 0.0416666679084301f) * _S1302 / (_S1302 * _S1302);
        k_18 = (1.0f - _S1324.primal_0 * _S1324.primal_0 / 24.0f) / _S1302;
        s_diff_k_7 = _S1326;
    }
    else
    {
        float _S1327 = _S1324.differential_0 * 0.5f;
        DiffPair_float_0 _S1328;
        (&_S1328)->primal_0 = 0.5f * _S1324.primal_0;
        (&_S1328)->differential_0 = _S1327;
        DiffPair_float_0 _S1329 = _d_sin_0(&_S1328);
        float _S1330 = 2.0f * _S1329.primal_0;
        float _S1331 = (_S1329.differential_0 * 2.0f * _S1321.primal_0 - _S1330 * _S1321.differential_0) / (_S1321.primal_0 * _S1321.primal_0);
        k_18 = _S1330 / _S1321.primal_0;
        s_diff_k_7 = _S1331;
    }
    float2  _S1332 = _S1298 * make_float2 (k_18);
    float2  _S1333 = _S1319 * make_float2 (k_18) + make_float2 (s_diff_k_7) * _S1298;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1334;
    (&_S1334)->primal_0 = _S1332;
    (&_S1334)->differential_0 = _S1333;
    FixedArray<float, 58>  _S1335 = dist_coeffs_43;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1336 = s_fwd_DistKBPolarSpline_distort_0(&_S1334, &_S1335);
    float _S1337 = _S1336.differential_0.y * fy_12;
    *&(((&J_12)->rows + (int(0)))->y) = _S1336.differential_0.x * fx_12;
    *&(((&J_12)->rows + (int(1)))->y) = _S1337;
    float2  _S1338 = make_float2 (0.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1339;
    (&_S1339)->primal_0 = _S1298;
    (&_S1339)->differential_0 = _S1338;
    DiffPair_float_0 _S1340 = s_fwd_length_impl_0(&_S1339);
    DiffPair_float_0 _S1341;
    (&_S1341)->primal_0 = _S1340.primal_0;
    (&_S1341)->differential_0 = _S1340.differential_0;
    DiffPair_float_0 _S1342;
    (&_S1342)->primal_0 = _S1302;
    (&_S1342)->differential_0 = 1.0f;
    DiffPair_float_0 _S1343 = _d_atan2_0(&_S1341, &_S1342);
    if((_S1340.primal_0) < 9.99999997475242708e-07f)
    {
        float _S1344 = _S1343.differential_0 * _S1343.primal_0;
        float _S1345 = 1.0f - _S1343.primal_0 * _S1343.primal_0 / 24.0f;
        float _S1346 = ((0.0f - (_S1344 + _S1344) * 0.0416666679084301f) * _S1302 - _S1345) / (_S1302 * _S1302);
        k_18 = _S1345 / _S1302;
        s_diff_k_7 = _S1346;
    }
    else
    {
        float _S1347 = _S1343.differential_0 * 0.5f;
        DiffPair_float_0 _S1348;
        (&_S1348)->primal_0 = 0.5f * _S1343.primal_0;
        (&_S1348)->differential_0 = _S1347;
        DiffPair_float_0 _S1349 = _d_sin_0(&_S1348);
        float _S1350 = 2.0f * _S1349.primal_0;
        float _S1351 = (_S1349.differential_0 * 2.0f * _S1340.primal_0 - _S1350 * _S1340.differential_0) / (_S1340.primal_0 * _S1340.primal_0);
        k_18 = _S1350 / _S1340.primal_0;
        s_diff_k_7 = _S1351;
    }
    float2  _S1352 = _S1298 * make_float2 (k_18);
    float2  _S1353 = make_float2 (s_diff_k_7) * _S1298;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1354;
    (&_S1354)->primal_0 = _S1352;
    (&_S1354)->differential_0 = _S1353;
    FixedArray<float, 58>  _S1355 = dist_coeffs_43;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1356 = s_fwd_DistKBPolarSpline_distort_0(&_S1354, &_S1355);
    float _S1357 = _S1356.differential_0.y * fy_12;
    *&(((&J_12)->rows + (int(0)))->z) = _S1356.differential_0.x * fx_12;
    *&(((&J_12)->rows + (int(1)))->z) = _S1357;
    return J_12;
}

inline __device__ float2  distort_point_polar(float2  uv_41, int camera_model_12, FixedArray<float, 58>  dist_coeffs_44)
{
    float2  _S1358;
    for(;;)
    {
        if(camera_model_12 == int(3))
        {
            _S1358 = uv_41;
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
            _S1358 = uv_41 * make_float2 (k_19);
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
                _S1358 = uv_41 * make_float2 (k_19);
            }
            else
            {
                _S1358 = uv_41;
            }
        }
        FixedArray<float, 58>  _S1359 = dist_coeffs_44;
        float2  _S1360 = DistKBPolarSpline_distort_0(_S1358, &_S1359);
        _S1358 = _S1360;
        break;
    }
    return _S1358;
}

inline __device__ bool undistort_point_polar(float2  uv_42, int camera_model_13, FixedArray<float, 58>  dist_coeffs_45, float2  * uv_undist_7)
{
    bool _S1361;
    for(;;)
    {
        *uv_undist_7 = make_float2 (0.0f);
        if(camera_model_13 == int(3))
        {
            float lon_6 = uv_42.x;
            float lat_9 = uv_42.y;
            float cl_9 = (F32_cos((lat_9)));
            *uv_undist_7 = make_float2 (cl_9 * (F32_sin((lon_6))), (F32_sin((lat_9)))) / make_float2 ((F32_max((cl_9 * (F32_cos((lon_6)))), (9.999999960041972e-13f))));
            _S1361 = true;
            break;
        }
        FixedArray<float, 58>  _S1362 = dist_coeffs_45;
        float2  uv_u_9;
        bool _S1363 = undistort_point_0(uv_42, &_S1362, int(8), &uv_u_9);
        if(!_S1363)
        {
            _S1361 = false;
            break;
        }
        float2  _S1364 = uv_u_9;
        float3  raydir_9;
        if(camera_model_13 == int(1))
        {
            float r_40 = length_0(_S1364);
            float s_9;
            if(r_40 < 0.00100000004749745f)
            {
                s_9 = 1.0f - r_40 * r_40 / 6.0f;
            }
            else
            {
                s_9 = (F32_sin((r_40))) / r_40;
            }
            raydir_9 = make_float3 ((_S1364 * make_float2 (s_9)).x, (_S1364 * make_float2 (s_9)).y, (F32_cos((r_40))));
        }
        else
        {
            if(camera_model_13 == int(2))
            {
                float r_41 = length_0(_S1364);
                raydir_9 = make_float3 ((_S1364 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_41 * r_41)))))))).x, (_S1364 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_41 * r_41)))))))).y, 1.0f - 0.5f * r_41 * r_41);
            }
            else
            {
                raydir_9 = make_float3 (_S1364.x, _S1364.y, 1.0f);
            }
        }
        *uv_undist_7 = float2 {raydir_9.x, raydir_9.y} / make_float2 ((F32_max((raydir_9.z), (9.999999960041972e-13f))));
        _S1361 = true;
        break;
    }
    return _S1361;
}

inline __device__ bool unproject_point_polar(float2  uv_43, int camera_model_14, FixedArray<float, 58>  dist_coeffs_46, float3  * raydir_10)
{
    bool _S1365;
    for(;;)
    {
        int3  _S1366 = make_int3 (int(0));
        float3  _S1367 = make_float3 ((float)_S1366.x, (float)_S1366.y, (float)_S1366.z);
        *raydir_10 = _S1367;
        if(camera_model_14 == int(3))
        {
            float lon_7 = uv_43.x;
            float lat_10 = uv_43.y;
            float cl_10 = (F32_cos((lat_10)));
            *raydir_10 = make_float3 (cl_10 * (F32_sin((lon_7))), (F32_sin((lat_10))), cl_10 * (F32_cos((lon_7))));
            _S1365 = true;
            break;
        }
        FixedArray<float, 58>  _S1368 = dist_coeffs_46;
        float2  uv_u_10;
        bool _S1369 = undistort_point_0(uv_43, &_S1368, int(8), &uv_u_10);
        if(!_S1369)
        {
            _S1365 = false;
            break;
        }
        float2  _S1370 = uv_u_10;
        if(camera_model_14 == int(1))
        {
            float r_42 = length_0(_S1370);
            float s_10;
            if(r_42 < 0.00100000004749745f)
            {
                s_10 = 1.0f - r_42 * r_42 / 6.0f;
            }
            else
            {
                s_10 = (F32_sin((r_42))) / r_42;
            }
            *raydir_10 = make_float3 ((_S1370 * make_float2 (s_10)).x, (_S1370 * make_float2 (s_10)).y, (F32_cos((r_42))));
        }
        else
        {
            if(camera_model_14 == int(2))
            {
                float r_43 = length_0(_S1370);
                *raydir_10 = make_float3 ((_S1370 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_43 * r_43)))))))).x, (_S1370 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_43 * r_43)))))))).y, 1.0f - 0.5f * r_43 * r_43);
            }
            else
            {
                *raydir_10 = make_float3 (_S1370.x, _S1370.y, 1.0f);
            }
        }
        _S1365 = true;
        break;
    }
    return _S1365;
}

inline __device__ bool generate_ray_polar(float2  uv_44, int camera_model_15, FixedArray<float, 58>  dist_coeffs_47, float3  * raydir_11)
{
    bool _S1371;
    for(;;)
    {
        if(camera_model_15 == int(3))
        {
            float _S1372 = uv_44.x;
            if((F32_abs((_S1372))) > 3.14159274101257324f)
            {
                _S1371 = true;
            }
            else
            {
                _S1371 = (F32_abs((uv_44.y))) > 1.57079637050628662f;
            }
            if(_S1371)
            {
                int3  _S1373 = make_int3 (int(0));
                float3  _S1374 = make_float3 ((float)_S1373.x, (float)_S1373.y, (float)_S1373.z);
                *raydir_11 = _S1374;
                _S1371 = false;
                break;
            }
            float lat_11 = uv_44.y;
            float cl_11 = (F32_cos((lat_11)));
            *raydir_11 = make_float3 (cl_11 * (F32_sin((_S1372))), (F32_sin((lat_11))), cl_11 * (F32_cos((_S1372))));
            _S1371 = true;
            break;
        }
        FixedArray<float, 58>  _S1375 = dist_coeffs_47;
        float2  uv_u_11;
        bool _S1376 = undistort_point_0(uv_44, &_S1375, int(8), &uv_u_11);
        if(!_S1376)
        {
            int3  _S1377 = make_int3 (int(0));
            float3  _S1378 = make_float3 ((float)_S1377.x, (float)_S1377.y, (float)_S1377.z);
            *raydir_11 = _S1378;
            _S1371 = false;
            break;
        }
        float2  _S1379 = uv_u_11;
        if(camera_model_15 == int(1))
        {
            float r_44 = length_0(_S1379);
            if(r_44 >= 3.14159274101257324f)
            {
                int3  _S1380 = make_int3 (int(0));
                float3  _S1381 = make_float3 ((float)_S1380.x, (float)_S1380.y, (float)_S1380.z);
                *raydir_11 = _S1381;
                _S1371 = false;
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
            *raydir_11 = make_float3 ((_S1379 * make_float2 (s_11)).x, (_S1379 * make_float2 (s_11)).y, (F32_cos((r_44))));
        }
        else
        {
            if(camera_model_15 == int(2))
            {
                float r_45 = length_0(_S1379);
                if(r_45 >= 2.0f)
                {
                    int3  _S1382 = make_int3 (int(0));
                    float3  _S1383 = make_float3 ((float)_S1382.x, (float)_S1382.y, (float)_S1382.z);
                    *raydir_11 = _S1383;
                    _S1371 = false;
                    break;
                }
                *raydir_11 = make_float3 ((_S1379 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_45 * r_45)))))))).x, (_S1379 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_45 * r_45)))))))).y, 1.0f - 0.5f * r_45 * r_45);
            }
            else
            {
                *raydir_11 = make_float3 (_S1379.x, _S1379.y, 1.0f);
            }
        }
        *raydir_11 = normalize_0(*raydir_11);
        _S1371 = true;
        break;
    }
    return _S1371;
}

inline __device__ float3  transform_ray_o(Matrix<float, 3, 3>  R_0, float3  t_1)
{
    return - mul_2(t_1, R_0);
}

inline __device__ float3  transform_ray_d(Matrix<float, 3, 3>  R_1, float3  raydir_12)
{
    return mul_2(raydir_12, R_1);
}

inline __device__ float3  undo_transform_ray_d(Matrix<float, 3, 3>  R_2, float3  raydir_13)
{
    return mul_2(raydir_13, transpose_0(R_2));
}

inline __device__ void transform_ray_o_vjp(Matrix<float, 3, 3>  R_3, float3  t_2, float3  v_ray_o_0, Matrix<float, 3, 3>  * v_R_0, float3  * v_t_0)
{
    Matrix<float, 3, 3>  _S1384 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_R_0;
    (&dp_R_0)->primal_0 = R_3;
    (&dp_R_0)->differential_0 = _S1384;
    float3  _S1385 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_t_0;
    (&dp_t_0)->primal_0 = t_2;
    (&dp_t_0)->differential_0 = _S1385;
    _S520(&dp_R_0, &dp_t_0, v_ray_o_0);
    *v_R_0 = dp_R_0.differential_0;
    *v_t_0 = dp_t_0.differential_0;
    return;
}

inline __device__ void transform_ray_d_vjp(Matrix<float, 3, 3>  R_4, float3  raydir_14, float3  v_ray_d_0, Matrix<float, 3, 3>  * v_R_1, float3  * v_raydir_0)
{
    Matrix<float, 3, 3>  _S1386 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_R_1;
    (&dp_R_1)->primal_0 = R_4;
    (&dp_R_1)->differential_0 = _S1386;
    float3  _S1387 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_raydir_0;
    (&dp_raydir_0)->primal_0 = raydir_14;
    (&dp_raydir_0)->differential_0 = _S1387;
    _S505(&dp_R_1, &dp_raydir_0, v_ray_d_0);
    *v_R_1 = dp_R_1.differential_0;
    *v_raydir_0 = dp_raydir_0.differential_0;
    return;
}

inline __device__ Matrix<float, 3, 3>  compute_3dgut_iscl_rot(float4  quat_5, float3  scale_4)
{
    float x_18 = quat_5.y;
    float x2_7 = x_18 * x_18;
    float y2_7 = quat_5.z * quat_5.z;
    float z2_7 = quat_5.w * quat_5.w;
    float xy_7 = quat_5.y * quat_5.z;
    float xz_7 = quat_5.y * quat_5.w;
    float yz_7 = quat_5.z * quat_5.w;
    float wx_7 = quat_5.x * quat_5.y;
    float wy_7 = quat_5.x * quat_5.z;
    float wz_7 = quat_5.x * quat_5.w;
    float3  _S1388 = exp_0(- scale_4);
    return mul_3(makeMatrix<float, 3, 3> (_S1388.x, 0.0f, 0.0f, 0.0f, _S1388.y, 0.0f, 0.0f, 0.0f, _S1388.z), transpose_0(transpose_0(makeMatrix<float, 3, 3> (1.0f - 2.0f * (y2_7 + z2_7), 2.0f * (xy_7 + wz_7), 2.0f * (xz_7 - wy_7), 2.0f * (xy_7 - wz_7), 1.0f - 2.0f * (x2_7 + z2_7), 2.0f * (yz_7 + wx_7), 2.0f * (xz_7 + wy_7), 2.0f * (yz_7 - wx_7), 1.0f - 2.0f * (x2_7 + y2_7)))));
}

inline __device__ void compute_3dgut_iscl_rot_vjp(float4  quat_6, float3  scale_5, Matrix<float, 3, 3>  v_iscl_rot_0, float4  * v_quat_0, float3  * v_scale_0)
{
    float4  _S1389 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_quat_0;
    (&dp_quat_0)->primal_0 = quat_6;
    (&dp_quat_0)->differential_0 = _S1389;
    float3  _S1390 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_scale_0;
    (&dp_scale_0)->primal_0 = scale_5;
    (&dp_scale_0)->differential_0 = _S1390;
    _S491(&dp_quat_0, &dp_scale_0, v_iscl_rot_0);
    *v_quat_0 = dp_quat_0.differential_0;
    *v_scale_0 = dp_scale_0.differential_0;
    return;
}

inline __device__ float evaluate_alpha_3dgs(float3  mean_0, Matrix<float, 3, 3>  iscl_rot_0, float opacity_0, float3  ray_o_0, float3  ray_d_0)
{
    float3  grd_0 = mul_0(iscl_rot_0, ray_d_0);
    float3  gcrod_0 = cross_0(grd_0, mul_0(iscl_rot_0, ray_o_0 - mean_0));
    return opacity_0 * (F32_exp((-0.5f * dot_0(gcrod_0, gcrod_0) / dot_0(grd_0, grd_0))));
}

inline __device__ void evaluate_alpha_3dgs_vjp(float3  mean_1, Matrix<float, 3, 3>  iscl_rot_1, float opacity_1, float3  ray_o_1, float3  ray_d_1, float v_alpha_0, float3  * v_mean_0, Matrix<float, 3, 3>  * v_iscl_rot_1, float * v_opacity_0, float3  * v_ray_o_1, float3  * v_ray_d_1)
{
    float3  _S1391 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_mean_0;
    (&dp_mean_0)->primal_0 = mean_1;
    (&dp_mean_0)->differential_0 = _S1391;
    Matrix<float, 3, 3>  _S1392 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_iscl_rot_0;
    (&dp_iscl_rot_0)->primal_0 = iscl_rot_1;
    (&dp_iscl_rot_0)->differential_0 = _S1392;
    DiffPair_float_0 dp_opacity_0;
    (&dp_opacity_0)->primal_0 = opacity_1;
    (&dp_opacity_0)->differential_0 = 0.0f;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_o_0;
    (&dp_ray_o_0)->primal_0 = ray_o_1;
    (&dp_ray_o_0)->differential_0 = _S1391;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_d_0;
    (&dp_ray_d_0)->primal_0 = ray_d_1;
    (&dp_ray_d_0)->differential_0 = _S1391;
    _S426(&dp_mean_0, &dp_iscl_rot_0, &dp_opacity_0, &dp_ray_o_0, &dp_ray_d_0, v_alpha_0);
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
    float3  grd_1 = mul_0(iscl_rot_2, ray_d_2);
    *depth_0 = - dot_0(mul_0(iscl_rot_2, ray_o_2 - mean_2), grd_1) / dot_0(grd_1, grd_1);
    return;
}

inline __device__ void evaluate_color_3dgs_vjp(float3  mean_3, Matrix<float, 3, 3>  iscl_rot_3, float opacity_3, float3  rgb_1, float3  ray_o_3, float3  ray_d_3, float3  v_out_rgb_0, float v_depth_0, float3  * v_mean_1, Matrix<float, 3, 3>  * v_iscl_rot_2, float * v_opacity_1, float3  * v_rgb_0, float3  * v_ray_o_2, float3  * v_ray_d_2)
{
    float3  _S1393 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_mean_1;
    (&dp_mean_1)->primal_0 = mean_3;
    (&dp_mean_1)->differential_0 = _S1393;
    Matrix<float, 3, 3>  _S1394 = makeMatrix<float, 3, 3> (0.0f);
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 dp_iscl_rot_1;
    (&dp_iscl_rot_1)->primal_0 = iscl_rot_3;
    (&dp_iscl_rot_1)->differential_0 = _S1394;
    DiffPair_float_0 dp_opacity_1;
    (&dp_opacity_1)->primal_0 = opacity_3;
    (&dp_opacity_1)->differential_0 = 0.0f;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_rgb_0;
    (&dp_rgb_0)->primal_0 = rgb_1;
    (&dp_rgb_0)->differential_0 = _S1393;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_o_1;
    (&dp_ray_o_1)->primal_0 = ray_o_3;
    (&dp_ray_o_1)->differential_0 = _S1393;
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_ray_d_1;
    (&dp_ray_d_1)->primal_0 = ray_d_3;
    (&dp_ray_d_1)->differential_0 = _S1393;
    _S364(&dp_mean_1, &dp_iscl_rot_1, &dp_opacity_1, &dp_rgb_0, &dp_ray_o_1, &dp_ray_d_1, v_out_rgb_0, v_depth_0);
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

