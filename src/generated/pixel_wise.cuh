#pragma once

#include "generated/slang.cuh"

struct Tuple_0
{
    float value0_0;
};

inline __device__ Tuple_0 s_apply_sqrt_0(float x_0)
{
    Tuple_0 _S1 = { (F32_sqrt((x_0))) };
    return _S1;
}

struct s_bwdCallableCtx_sqrt_0
{
    float _S2;
};

struct DiffPair_float_0
{
    float primal_0;
    float differential_0;
};

inline __device__ void _d_sqrt_0(DiffPair_float_0 * dpx_0, float dOut_0)
{
    float _S3 = 0.5f / (F32_sqrt(((F32_max((1.00000001168609742e-07f), ((*dpx_0).primal_0)))))) * dOut_0;
    dpx_0->primal_0 = (*dpx_0).primal_0;
    dpx_0->differential_0 = _S3;
    return;
}

inline __device__ void s_bwdProp_sqrt_0(s_bwdCallableCtx_sqrt_0 * ctx_0, float * d_x_0, float d_out_0)
{
    DiffPair_float_0 _S4;
    (&_S4)->primal_0 = ctx_0->_S2;
    _d_sqrt_0(&_S4, d_out_0);
    *d_x_0 = (&_S4)->differential_0;
    return;
}

struct Tuple_1
{
    float value0_1;
};

inline __device__ Tuple_1 s_apply_cos_0(float x_1)
{
    Tuple_1 _S5 = { (F32_cos((x_1))) };
    return _S5;
}

struct Tuple_2
{
    float value0_2;
};

inline __device__ Tuple_2 s_apply_sin_0(float x_2)
{
    Tuple_2 _S6 = { (F32_sin((x_2))) };
    return _S6;
}

struct Tuple_3
{
    float value0_3;
};

inline __device__ float dot_0(float2  x_3, float2  y_0)
{
    int i_0 = int(0);
    float result_0 = 0.0f;
    for(;;)
    {
        if(i_0 < int(2))
        {
        }
        else
        {
            break;
        }
        float result_1 = result_0 + _slang_vector_get_element(x_3, i_0) * _slang_vector_get_element(y_0, i_0);
        i_0 = i_0 + int(1);
        result_0 = result_1;
    }
    return result_0;
}

inline __device__ float length_0(float2  x_4)
{
    return (F32_sqrt((dot_0(x_4, x_4))));
}

inline __device__ Tuple_3 s_apply_length_0(float2  x_5)
{
    Tuple_3 _S7 = { length_0(x_5) };
    return _S7;
}

struct Tuple_4
{
    float3  value0_4;
};

inline __device__ float dot_1(float3  x_6, float3  y_1)
{
    int i_1 = int(0);
    float result_2 = 0.0f;
    for(;;)
    {
        if(i_1 < int(3))
        {
        }
        else
        {
            break;
        }
        float result_3 = result_2 + _slang_vector_get_element(x_6, i_1) * _slang_vector_get_element(y_1, i_1);
        i_1 = i_1 + int(1);
        result_2 = result_3;
    }
    return result_2;
}

inline __device__ float length_1(float3  x_7)
{
    return (F32_sqrt((dot_1(x_7, x_7))));
}

inline __device__ float3  normalize_0(float3  x_8)
{
    return x_8 / make_float3 (length_1(x_8));
}

inline __device__ Tuple_4 s_apply_normalize_0(float3  x_9)
{
    Tuple_4 _S8 = { normalize_0(x_9) };
    return _S8;
}

struct s_bwdCallableCtx_normalize_0
{
    float3  _S9;
};

struct DiffPair_vectorx3Cfloatx2C3x3E_0
{
    float3  primal_0;
    float3  differential_0;
};

struct s_paramCtx_s_bwdCallableCtx_normalize_impl_0
{
    float3  value0_5;
};

struct s_bwdCallableCtx_normalize_impl_0
{
    s_paramCtx_s_bwdCallableCtx_normalize_impl_0 value0_6;
};

struct Tuple_5
{
    float value0_7;
};

inline __device__ Tuple_5 s_apply_length_1(float3  x_10)
{
    Tuple_5 _S10 = { length_1(x_10) };
    return _S10;
}

struct s_bwdCallableCtx_length_0
{
    float3  _S11;
};

struct s_paramCtx_s_bwdCallableCtx_length_impl_0
{
    float3  value0_8;
};

struct s_bwdCallableCtx_length_impl_0
{
    s_paramCtx_s_bwdCallableCtx_length_impl_0 value0_9;
};

inline __device__ void s_bwdProp_length_impl_0(s_bwdCallableCtx_length_impl_0 * _S12, float3  * _S13, float _S14)
{
    s_bwdCallableCtx_sqrt_0 _S15;
    (&_S15)->_S2 = *&((&(&_S12->value0_9)->value0_8)->x) * *&((&(&_S12->value0_9)->value0_8)->x) + *&((&(&_S12->value0_9)->value0_8)->y) * *&((&(&_S12->value0_9)->value0_8)->y) + *&((&(&_S12->value0_9)->value0_8)->z) * *&((&(&_S12->value0_9)->value0_8)->z);
    float _S16 = 0.0f;
    s_bwdCallableCtx_sqrt_0 _S17 = _S15;
    s_bwdProp_sqrt_0(&_S17, &_S16, _S14);
    float _S18 = *&((&(&_S12->value0_9)->value0_8)->z) * _S16;
    float _S19 = _S18 + _S18;
    float _S20 = *&((&(&_S12->value0_9)->value0_8)->y) * _S16;
    float _S21 = _S20 + _S20;
    float _S22 = *&((&(&_S12->value0_9)->value0_8)->x) * _S16;
    float _S23 = _S22 + _S22;
    float3  _S24 = make_float3 (0.0f);
    *&((&_S24)->z) = _S19;
    *&((&_S24)->y) = _S21;
    *&((&_S24)->x) = _S23;
    *_S13 = _S24;
    return;
}

inline __device__ void _S25(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S26, float _S27)
{
    s_paramCtx_s_bwdCallableCtx_length_impl_0 _S28;
    (&_S28)->value0_8 = _S26->primal_0;
    s_bwdCallableCtx_length_impl_0 _S29;
    (&_S29)->value0_9 = _S28;
    s_bwdProp_length_impl_0(&_S29, &_S26->differential_0, _S27);
    return;
}

inline __device__ void s_bwdProp_length_0(s_bwdCallableCtx_length_0 * ctx_1, float3  * d_x_1, float d_out_1)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S30;
    (&_S30)->primal_0 = ctx_1->_S11;
    _S25(&_S30, d_out_1);
    *d_x_1 = (&_S30)->differential_0;
    return;
}

inline __device__ void s_bwdProp_normalize_impl_0(s_bwdCallableCtx_normalize_impl_0 * _S31, float3  * _S32, float3  _S33)
{
    Tuple_5 _S34 = s_apply_length_1((&_S31->value0_6)->value0_5);
    s_bwdCallableCtx_length_0 _S35;
    (&_S35)->_S11 = (&_S31->value0_6)->value0_5;
    float3  _S36 = (&_S31->value0_6)->value0_5 * _S33;
    float3  _S37 = make_float3 (1.0f / _S34.value0_7) * _S33;
    float _S38 = - ((_S36.x + _S36.y + _S36.z) / (_S34.value0_7 * _S34.value0_7));
    float3  _S39 = make_float3 (0.0f);
    s_bwdCallableCtx_length_0 _S40 = _S35;
    s_bwdProp_length_0(&_S40, &_S39, _S38);
    *_S32 = _S37 + _S39;
    return;
}

inline __device__ void _S41(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S42, float3  _S43)
{
    s_paramCtx_s_bwdCallableCtx_normalize_impl_0 _S44;
    (&_S44)->value0_5 = _S42->primal_0;
    s_bwdCallableCtx_normalize_impl_0 _S45;
    (&_S45)->value0_6 = _S44;
    s_bwdProp_normalize_impl_0(&_S45, &_S42->differential_0, _S43);
    return;
}

inline __device__ void s_bwdProp_normalize_0(s_bwdCallableCtx_normalize_0 * ctx_2, float3  * d_x_2, float3  d_out_2)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S46;
    (&_S46)->primal_0 = ctx_2->_S9;
    _S41(&_S46, d_out_2);
    *d_x_2 = (&_S46)->differential_0;
    return;
}

struct Tuple_6
{
    float value0_10;
};

inline __device__ float clamp_0(float x_11, float minBound_0, float maxBound_0)
{
    return (F32_min(((F32_max((x_11), (minBound_0)))), (maxBound_0)));
}

inline __device__ float xfer_clamp01_0(float x_12)
{
    return clamp_0(x_12, 0.0f, 1.0f);
}

inline __device__ Tuple_6 s_apply_xfer_clamp01_0(float x_13)
{
    Tuple_6 _S47 = { xfer_clamp01_0(x_13) };
    return _S47;
}

struct s_bwdCallableCtx_xfer_clamp01_0
{
    float _S48;
};

inline __device__ void xfer_pass_grad_0(DiffPair_float_0 * dp_0, float v_out_0)
{
    dp_0->primal_0 = (*dp_0).primal_0;
    dp_0->differential_0 = v_out_0;
    return;
}

inline __device__ void s_bwdProp_xfer_clamp01_0(s_bwdCallableCtx_xfer_clamp01_0 * ctx_3, float * d_x_3, float d_out_3)
{
    DiffPair_float_0 _S49;
    (&_S49)->primal_0 = ctx_3->_S48;
    xfer_pass_grad_0(&_S49, d_out_3);
    *d_x_3 = (&_S49)->differential_0;
    return;
}

struct Tuple_7
{
    float value0_11;
};

inline __device__ float xfer_max0_0(float x_14)
{
    return (F32_max((x_14), (0.0f)));
}

inline __device__ Tuple_7 s_apply_xfer_max0_0(float x_15)
{
    Tuple_7 _S50 = { xfer_max0_0(x_15) };
    return _S50;
}

struct s_bwdCallableCtx_xfer_max0_0
{
    float _S51;
};

inline __device__ void s_bwdProp_xfer_max0_0(s_bwdCallableCtx_xfer_max0_0 * ctx_4, float * d_x_4, float d_out_4)
{
    DiffPair_float_0 _S52;
    (&_S52)->primal_0 = ctx_4->_S51;
    xfer_pass_grad_0(&_S52, d_out_4);
    *d_x_4 = (&_S52)->differential_0;
    return;
}

struct Tuple_8
{
    float value0_12;
};

inline __device__ Tuple_8 s_apply_pow_0(float x_16, float y_2)
{
    Tuple_8 _S53 = { (F32_pow((x_16), (y_2))) };
    return _S53;
}

struct s_bwdCallableCtx_pow_0
{
    float _S54;
    float _S55;
};

inline __device__ void _d_pow_0(DiffPair_float_0 * dpx_1, DiffPair_float_0 * dpy_0, float dOut_1)
{
    if(((*dpx_1).primal_0) < 9.99999997475242708e-07f)
    {
        dpx_1->primal_0 = (*dpx_1).primal_0;
        dpx_1->differential_0 = 0.0f;
        dpy_0->primal_0 = (*dpy_0).primal_0;
        dpy_0->differential_0 = 0.0f;
    }
    else
    {
        float val_0 = (F32_pow(((*dpx_1).primal_0), ((*dpy_0).primal_0)));
        DiffPair_float_0 _S56 = *dpx_1;
        float _S57 = val_0 * (*dpy_0).primal_0 / (*dpx_1).primal_0 * dOut_1;
        dpx_1->primal_0 = (*dpx_1).primal_0;
        dpx_1->differential_0 = _S57;
        float _S58 = val_0 * (F32_log((_S56.primal_0))) * dOut_1;
        dpy_0->primal_0 = (*dpy_0).primal_0;
        dpy_0->differential_0 = _S58;
    }
    return;
}

inline __device__ void s_bwdProp_pow_0(s_bwdCallableCtx_pow_0 * ctx_5, float * d_x_5, float * d_y_0, float d_out_5)
{
    DiffPair_float_0 _S59;
    (&_S59)->primal_0 = ctx_5->_S54;
    DiffPair_float_0 _S60;
    (&_S60)->primal_0 = ctx_5->_S55;
    _d_pow_0(&_S59, &_S60, d_out_5);
    *d_x_5 = (&_S59)->differential_0;
    *d_y_0 = (&_S60)->differential_0;
    return;
}

struct Tuple_9
{
    float3  value0_13;
};

inline __device__ float3  cross_0(float3  left_0, float3  right_0)
{
    float _S61 = left_0.y;
    float _S62 = right_0.z;
    float _S63 = left_0.z;
    float _S64 = right_0.y;
    float _S65 = right_0.x;
    float _S66 = left_0.x;
    return make_float3 (_S61 * _S62 - _S63 * _S64, _S63 * _S65 - _S66 * _S62, _S66 * _S64 - _S61 * _S65);
}

inline __device__ Tuple_9 s_apply_cross_0(float3  left_1, float3  right_1)
{
    Tuple_9 _S67 = { cross_0(left_1, right_1) };
    return _S67;
}

struct s_bwdCallableCtx_cross_0
{
    float3  _S68;
    float3  _S69;
};

inline __device__ void _d_cross_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * a_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * b_0, float3  dOut_2)
{
    float _S70 = dOut_2.y;
    float _S71 = dOut_2.z;
    float _S72 = dOut_2.x;
    float _S73 = (*a_0).primal_0.z * _S70 + - (*a_0).primal_0.y * _S71;
    float _S74 = - (*a_0).primal_0.z * _S72 + (*a_0).primal_0.x * _S71;
    float _S75 = (*a_0).primal_0.y * _S72 + - (*a_0).primal_0.x * _S70;
    float3  _S76 = make_float3 (- (*b_0).primal_0.z * _S70 + (*b_0).primal_0.y * _S71, (*b_0).primal_0.z * _S72 + - (*b_0).primal_0.x * _S71, - (*b_0).primal_0.y * _S72 + (*b_0).primal_0.x * _S70);
    a_0->primal_0 = (*a_0).primal_0;
    a_0->differential_0 = _S76;
    float3  _S77 = make_float3 (_S73, _S74, _S75);
    b_0->primal_0 = (*b_0).primal_0;
    b_0->differential_0 = _S77;
    return;
}

inline __device__ void s_bwdProp_cross_0(s_bwdCallableCtx_cross_0 * ctx_6, float3  * d_left_0, float3  * d_right_0, float3  d_out_6)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S78;
    (&_S78)->primal_0 = ctx_6->_S68;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S79;
    (&_S79)->primal_0 = ctx_6->_S69;
    _d_cross_0(&_S78, &_S79, d_out_6);
    *d_left_0 = (&_S78)->differential_0;
    *d_right_0 = (&_S79)->differential_0;
    return;
}

struct Tuple_10
{
    float value0_14;
};

inline __device__ Tuple_10 s_apply_dot_0(float3  x_17, float3  y_3)
{
    Tuple_10 _S80 = { dot_1(x_17, y_3) };
    return _S80;
}

struct s_bwdCallableCtx_dot_0
{
    float3  _S81;
    float3  _S82;
};

inline __device__ void _d_dot_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dpx_2, DiffPair_vectorx3Cfloatx2C3x3E_0 * dpy_1, float dOut_3)
{
    float3  x_d_result_0;
    *&((&x_d_result_0)->x) = (*dpy_1).primal_0.x * dOut_3;
    float3  y_d_result_0;
    *&((&y_d_result_0)->x) = (*dpx_2).primal_0.x * dOut_3;
    *&((&x_d_result_0)->y) = (*dpy_1).primal_0.y * dOut_3;
    *&((&y_d_result_0)->y) = (*dpx_2).primal_0.y * dOut_3;
    *&((&x_d_result_0)->z) = (*dpy_1).primal_0.z * dOut_3;
    *&((&y_d_result_0)->z) = (*dpx_2).primal_0.z * dOut_3;
    dpx_2->primal_0 = (*dpx_2).primal_0;
    dpx_2->differential_0 = x_d_result_0;
    dpy_1->primal_0 = (*dpy_1).primal_0;
    dpy_1->differential_0 = y_d_result_0;
    return;
}

inline __device__ void s_bwdProp_dot_0(s_bwdCallableCtx_dot_0 * ctx_7, float3  * d_x_6, float3  * d_y_1, float d_out_7)
{
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S83;
    (&_S83)->primal_0 = ctx_7->_S81;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S84;
    (&_S84)->primal_0 = ctx_7->_S82;
    _d_dot_0(&_S83, &_S84, d_out_7);
    *d_x_6 = (&_S83)->differential_0;
    *d_y_1 = (&_S84)->differential_0;
    return;
}

struct Tuple_11
{
    float3  value0_15;
};

inline __device__ float3  mul_0(Matrix<float, 3, 3>  left_2, float3  right_2)
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
            float sum_1 = sum_0 + _slang_vector_get_element(left_2.rows[i_2], j_0) * _slang_vector_get_element(right_2, j_0);
            j_0 = j_0 + int(1);
            sum_0 = sum_1;
        }
        *_slang_vector_get_element_ptr(&result_4, i_2) = sum_0;
        i_2 = i_2 + int(1);
    }
    return result_4;
}

inline __device__ Tuple_11 s_apply_mul_0(Matrix<float, 3, 3>  left_3, float3  right_3)
{
    Tuple_11 _S85 = { mul_0(left_3, right_3) };
    return _S85;
}

struct s_bwdCallableCtx_mul_0
{
    Matrix<float, 3, 3>  _S86;
    float3  _S87;
};

struct DiffPair_matrixx3Cfloatx2C3x2C3x3E_0
{
    Matrix<float, 3, 3>  primal_0;
    Matrix<float, 3, 3>  differential_0;
};

inline __device__ void _d_mul_0(DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 * left_4, DiffPair_vectorx3Cfloatx2C3x3E_0 * right_4, float3  dOut_4)
{
    float _S88 = (*left_4).primal_0.rows[int(0)].x * dOut_4.x;
    Matrix<float, 3, 3>  left_d_result_0;
    *&(((&left_d_result_0)->rows + (int(0)))->x) = (*right_4).primal_0.x * dOut_4.x;
    float sum_2 = _S88 + (*left_4).primal_0.rows[int(1)].x * dOut_4.y;
    *&(((&left_d_result_0)->rows + (int(1)))->x) = (*right_4).primal_0.x * dOut_4.y;
    float sum_3 = sum_2 + (*left_4).primal_0.rows[int(2)].x * dOut_4.z;
    *&(((&left_d_result_0)->rows + (int(2)))->x) = (*right_4).primal_0.x * dOut_4.z;
    float3  right_d_result_0;
    *&((&right_d_result_0)->x) = sum_3;
    float _S89 = (*left_4).primal_0.rows[int(0)].y * dOut_4.x;
    *&(((&left_d_result_0)->rows + (int(0)))->y) = (*right_4).primal_0.y * dOut_4.x;
    float sum_4 = _S89 + (*left_4).primal_0.rows[int(1)].y * dOut_4.y;
    *&(((&left_d_result_0)->rows + (int(1)))->y) = (*right_4).primal_0.y * dOut_4.y;
    float sum_5 = sum_4 + (*left_4).primal_0.rows[int(2)].y * dOut_4.z;
    *&(((&left_d_result_0)->rows + (int(2)))->y) = (*right_4).primal_0.y * dOut_4.z;
    *&((&right_d_result_0)->y) = sum_5;
    float _S90 = (*left_4).primal_0.rows[int(0)].z * dOut_4.x;
    *&(((&left_d_result_0)->rows + (int(0)))->z) = (*right_4).primal_0.z * dOut_4.x;
    float sum_6 = _S90 + (*left_4).primal_0.rows[int(1)].z * dOut_4.y;
    *&(((&left_d_result_0)->rows + (int(1)))->z) = (*right_4).primal_0.z * dOut_4.y;
    float sum_7 = sum_6 + (*left_4).primal_0.rows[int(2)].z * dOut_4.z;
    *&(((&left_d_result_0)->rows + (int(2)))->z) = (*right_4).primal_0.z * dOut_4.z;
    *&((&right_d_result_0)->z) = sum_7;
    left_4->primal_0 = (*left_4).primal_0;
    left_4->differential_0 = left_d_result_0;
    right_4->primal_0 = (*right_4).primal_0;
    right_4->differential_0 = right_d_result_0;
    return;
}

inline __device__ void s_bwdProp_mul_0(s_bwdCallableCtx_mul_0 * ctx_8, Matrix<float, 3, 3>  * d_left_1, float3  * d_right_1, float3  d_out_8)
{
    DiffPair_matrixx3Cfloatx2C3x2C3x3E_0 _S91;
    (&_S91)->primal_0 = ctx_8->_S86;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S92;
    (&_S92)->primal_0 = ctx_8->_S87;
    _d_mul_0(&_S91, &_S92, d_out_8);
    *d_left_1 = (&_S91)->differential_0;
    *d_right_1 = (&_S92)->differential_0;
    return;
}

struct Tuple_12
{
    float value0_16;
};

inline __device__ Tuple_12 s_apply_max_0(float x_18, float y_4)
{
    Tuple_12 _S93 = { (F32_max((x_18), (y_4))) };
    return _S93;
}

struct s_bwdCallableCtx_max_0
{
    float _S94;
    float _S95;
};

inline __device__ void _d_max_0(DiffPair_float_0 * dpx_3, DiffPair_float_0 * dpy_2, float dOut_5)
{
    DiffPair_float_0 _S96 = *dpx_3;
    float _S97;
    if(((*dpx_3).primal_0) > ((*dpy_2).primal_0))
    {
        _S97 = dOut_5;
    }
    else
    {
        if(((*dpx_3).primal_0) < ((*dpy_2).primal_0))
        {
            _S97 = 0.0f;
        }
        else
        {
            _S97 = 0.5f * dOut_5;
        }
    }
    dpx_3->primal_0 = _S96.primal_0;
    dpx_3->differential_0 = _S97;
    DiffPair_float_0 _S98 = *dpy_2;
    if(((*dpy_2).primal_0) > (_S96.primal_0))
    {
        _S97 = dOut_5;
    }
    else
    {
        if(((*dpy_2).primal_0) < ((*dpx_3).primal_0))
        {
            _S97 = 0.0f;
        }
        else
        {
            _S97 = 0.5f * dOut_5;
        }
    }
    dpy_2->primal_0 = _S98.primal_0;
    dpy_2->differential_0 = _S97;
    return;
}

inline __device__ void s_bwdProp_max_0(s_bwdCallableCtx_max_0 * ctx_9, float * d_x_7, float * d_y_2, float d_out_9)
{
    DiffPair_float_0 _S99;
    (&_S99)->primal_0 = ctx_9->_S94;
    DiffPair_float_0 _S100;
    (&_S100)->primal_0 = ctx_9->_S95;
    _d_max_0(&_S99, &_S100, d_out_9);
    *d_x_7 = (&_S99)->differential_0;
    *d_y_2 = (&_S100)->differential_0;
    return;
}

struct DiffPair_vectorx3Cfloatx2C4x3E_0
{
    float4  primal_0;
    float4  differential_0;
};

struct s_minCtx_s_bwdCallableCtx_depth_normal_loss_0
{
    bool value0_17;
    float2  value1_0;
    float2  value2_0;
    bool value3_0;
    float2  value4_0;
    bool value5_0;
    float2  value6_0;
    bool value7_0;
    float2  value8_0;
    bool value9_0;
};

struct Tuple_13
{
    float value0_18;
    s_minCtx_s_bwdCallableCtx_depth_normal_loss_0 value1_1;
};

inline __device__ int clamp_1(int x_19, int minBound_1, int maxBound_1)
{
    return (I32_min(((I32_max((x_19), (minBound_1)))), (maxBound_1)));
}

inline __device__ float DistKBPolarSpline_cubic_0(float a_1, float b_1, float c_0, float d_0, float t_0)
{
    return b_1 + 0.5f * t_0 * (c_0 - a_1 + t_0 * (2.0f * a_1 - 5.0f * b_1 + 4.0f * c_0 - d_0 + t_0 * (3.0f * (b_1 - c_0) + d_0 - a_1)));
}

inline __device__ float2  DistKBPolarSpline_distort_0(float2  uv_0, FixedArray<float, 58>  * coeffs_0)
{
    float r2_0 = dot_0(uv_0, uv_0);
    float2  kb_0 = uv_0 * make_float2 (1.0f + r2_0 * ((*coeffs_0)[int(0)] + r2_0 * ((*coeffs_0)[int(1)] + r2_0 * ((*coeffs_0)[int(2)] + r2_0 * (*coeffs_0)[int(3)]))));
    float2  grid_0 = kb_0 * make_float2 ((*coeffs_0)[int(4)], (*coeffs_0)[int(5)]);
    if((dot_0(grid_0, grid_0)) < 9.99999968265522539e-21f)
    {
        return kb_0;
    }
    float radius_0 = length_0(grid_0);
    float _S101 = grid_0.y;
    float _S102 = grid_0.x;
    float theta_0 = (F32_atan2((_S101), (_S102))) * 0.79577469825744629f;
    float theta_1;
    if(theta_0 < 0.0f)
    {
        theta_1 = theta_0 + 5.0f;
    }
    else
    {
        theta_1 = theta_0;
    }
    int _S103 = int((F32_floor((radius_0))));
    int _S104 = int((F32_floor((theta_1))));
    int2  _S105 = make_int2 (int(0));
    float2  _S106 = make_float2 ((float)_S105.x, (float)_S105.y);
    float2  rt_0 = _S106;
    FixedArray<float, 4>  rows_0;
    int _S107 = clamp_1(_S103 - int(1), int(0), int(6));
    int col_0 = ((_S104 - int(1)) % int(5) + int(5)) % int(5);
    FixedArray<float, 4>  nodes_0;
    bool _S108 = _S107 < int(2);
    float _S109;
    if(_S108)
    {
        _S109 = 0.0f;
    }
    else
    {
        _S109 = (*coeffs_0)[int(8) + (_S107 - int(2)) * int(5) + col_0];
    }
    nodes_0[int(0)] = _S109;
    int col_1 = ((_S104 + int(1) - int(1)) % int(5) + int(5)) % int(5);
    if(_S108)
    {
        _S109 = 0.0f;
    }
    else
    {
        _S109 = (*coeffs_0)[int(8) + (_S107 - int(2)) * int(5) + col_1];
    }
    nodes_0[int(1)] = _S109;
    int col_2 = ((_S104 + int(2) - int(1)) % int(5) + int(5)) % int(5);
    if(_S108)
    {
        _S109 = 0.0f;
    }
    else
    {
        _S109 = (*coeffs_0)[int(8) + (_S107 - int(2)) * int(5) + col_2];
    }
    nodes_0[int(2)] = _S109;
    int col_3 = ((_S104 + int(3) - int(1)) % int(5) + int(5)) % int(5);
    if(_S108)
    {
        _S109 = 0.0f;
    }
    else
    {
        _S109 = (*coeffs_0)[int(8) + (_S107 - int(2)) * int(5) + col_3];
    }
    nodes_0[int(3)] = _S109;
    float _S110 = theta_1 - float(_S104);
    rows_0[int(0)] = DistKBPolarSpline_cubic_0(nodes_0[int(0)], nodes_0[int(1)], nodes_0[int(2)], nodes_0[int(3)], _S110);
    int _S111 = clamp_1(_S103 + int(1) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_1;
    bool _S112 = _S111 < int(2);
    if(_S112)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S111 - int(2)) * int(5) + col_0];
    }
    nodes_1[int(0)] = theta_1;
    if(_S112)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S111 - int(2)) * int(5) + col_1];
    }
    nodes_1[int(1)] = theta_1;
    if(_S112)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S111 - int(2)) * int(5) + col_2];
    }
    nodes_1[int(2)] = theta_1;
    if(_S112)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S111 - int(2)) * int(5) + col_3];
    }
    nodes_1[int(3)] = theta_1;
    rows_0[int(1)] = DistKBPolarSpline_cubic_0(nodes_1[int(0)], nodes_1[int(1)], nodes_1[int(2)], nodes_1[int(3)], _S110);
    int _S113 = clamp_1(_S103 + int(2) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_2;
    bool _S114 = _S113 < int(2);
    if(_S114)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S113 - int(2)) * int(5) + col_0];
    }
    nodes_2[int(0)] = theta_1;
    if(_S114)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S113 - int(2)) * int(5) + col_1];
    }
    nodes_2[int(1)] = theta_1;
    if(_S114)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S113 - int(2)) * int(5) + col_2];
    }
    nodes_2[int(2)] = theta_1;
    if(_S114)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S113 - int(2)) * int(5) + col_3];
    }
    nodes_2[int(3)] = theta_1;
    rows_0[int(2)] = DistKBPolarSpline_cubic_0(nodes_2[int(0)], nodes_2[int(1)], nodes_2[int(2)], nodes_2[int(3)], _S110);
    int _S115 = clamp_1(_S103 + int(3) - int(1), int(0), int(6));
    FixedArray<float, 4>  nodes_3;
    bool _S116 = _S115 < int(2);
    if(_S116)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S115 - int(2)) * int(5) + col_0];
    }
    nodes_3[int(0)] = theta_1;
    if(_S116)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S115 - int(2)) * int(5) + col_1];
    }
    nodes_3[int(1)] = theta_1;
    if(_S116)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S115 - int(2)) * int(5) + col_2];
    }
    nodes_3[int(2)] = theta_1;
    if(_S116)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(8) + (_S115 - int(2)) * int(5) + col_3];
    }
    nodes_3[int(3)] = theta_1;
    float _S117 = DistKBPolarSpline_cubic_0(nodes_3[int(0)], nodes_3[int(1)], nodes_3[int(2)], nodes_3[int(3)], _S110);
    rows_0[int(3)] = _S117;
    float _S118 = radius_0 - float(_S103);
    *&((&rt_0)->x) = DistKBPolarSpline_cubic_0(rows_0[int(0)], rows_0[int(1)], rows_0[int(2)], _S117, _S118);
    FixedArray<float, 4>  rows_1;
    FixedArray<float, 4>  nodes_4;
    if(_S108)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S107 - int(2)) * int(5) + col_0];
    }
    nodes_4[int(0)] = theta_1;
    if(_S108)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S107 - int(2)) * int(5) + col_1];
    }
    nodes_4[int(1)] = theta_1;
    if(_S108)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S107 - int(2)) * int(5) + col_2];
    }
    nodes_4[int(2)] = theta_1;
    if(_S108)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S107 - int(2)) * int(5) + col_3];
    }
    nodes_4[int(3)] = theta_1;
    rows_1[int(0)] = DistKBPolarSpline_cubic_0(nodes_4[int(0)], nodes_4[int(1)], nodes_4[int(2)], nodes_4[int(3)], _S110);
    FixedArray<float, 4>  nodes_5;
    if(_S112)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S111 - int(2)) * int(5) + col_0];
    }
    nodes_5[int(0)] = theta_1;
    if(_S112)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S111 - int(2)) * int(5) + col_1];
    }
    nodes_5[int(1)] = theta_1;
    if(_S112)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S111 - int(2)) * int(5) + col_2];
    }
    nodes_5[int(2)] = theta_1;
    if(_S112)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S111 - int(2)) * int(5) + col_3];
    }
    nodes_5[int(3)] = theta_1;
    rows_1[int(1)] = DistKBPolarSpline_cubic_0(nodes_5[int(0)], nodes_5[int(1)], nodes_5[int(2)], nodes_5[int(3)], _S110);
    FixedArray<float, 4>  nodes_6;
    if(_S114)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S113 - int(2)) * int(5) + col_0];
    }
    nodes_6[int(0)] = theta_1;
    if(_S114)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S113 - int(2)) * int(5) + col_1];
    }
    nodes_6[int(1)] = theta_1;
    if(_S114)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S113 - int(2)) * int(5) + col_2];
    }
    nodes_6[int(2)] = theta_1;
    if(_S114)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S113 - int(2)) * int(5) + col_3];
    }
    nodes_6[int(3)] = theta_1;
    rows_1[int(2)] = DistKBPolarSpline_cubic_0(nodes_6[int(0)], nodes_6[int(1)], nodes_6[int(2)], nodes_6[int(3)], _S110);
    FixedArray<float, 4>  nodes_7;
    if(_S116)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S115 - int(2)) * int(5) + col_0];
    }
    nodes_7[int(0)] = theta_1;
    if(_S116)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S115 - int(2)) * int(5) + col_1];
    }
    nodes_7[int(1)] = theta_1;
    if(_S116)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S115 - int(2)) * int(5) + col_2];
    }
    nodes_7[int(2)] = theta_1;
    if(_S116)
    {
        theta_1 = 0.0f;
    }
    else
    {
        theta_1 = (*coeffs_0)[int(33) + (_S115 - int(2)) * int(5) + col_3];
    }
    nodes_7[int(3)] = theta_1;
    float _S119 = DistKBPolarSpline_cubic_0(nodes_7[int(0)], nodes_7[int(1)], nodes_7[int(2)], nodes_7[int(3)], _S110);
    rows_1[int(3)] = _S119;
    *&((&rt_0)->y) = DistKBPolarSpline_cubic_0(rows_1[int(0)], rows_1[int(1)], rows_1[int(2)], _S119, _S118);
    return kb_0 + make_float2 (rt_0.x * _S102 - rt_0.y * _S101, rt_0.x * _S101 + rt_0.y * _S102) / make_float2 (radius_0) * make_float2 ((*coeffs_0)[int(6)], (*coeffs_0)[int(7)]);
}

struct DiffPair_vectorx3Cfloatx2C2x3E_0
{
    float2  primal_0;
    float2  differential_0;
};

inline __device__ DiffPair_float_0 _d_dot_1(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_4, DiffPair_vectorx3Cfloatx2C2x3E_0 * dpy_3)
{
    DiffPair_float_0 _S120 = { *&((&dpx_4->primal_0)->x) * *&((&dpy_3->primal_0)->x) + *&((&dpx_4->primal_0)->y) * *&((&dpy_3->primal_0)->y), *&((&dpx_4->primal_0)->x) * *&((&dpy_3->differential_0)->x) + *&((&dpy_3->primal_0)->x) * *&((&dpx_4->differential_0)->x) + *&((&dpx_4->primal_0)->y) * *&((&dpy_3->differential_0)->y) + *&((&dpy_3->primal_0)->y) * *&((&dpx_4->differential_0)->y) };
    return _S120;
}

inline __device__ DiffPair_float_0 _d_sqrt_1(DiffPair_float_0 * dpx_5)
{
    DiffPair_float_0 _S121 = { (F32_sqrt((dpx_5->primal_0))), 0.5f / (F32_sqrt(((F32_max((1.00000001168609742e-07f), (dpx_5->primal_0)))))) * dpx_5->differential_0 };
    return _S121;
}

inline __device__ DiffPair_float_0 s_fwd_length_impl_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpx_6)
{
    float _S122 = *&((&dpx_6->differential_0)->x) * *&((&dpx_6->primal_0)->x);
    float _S123 = *&((&dpx_6->differential_0)->y) * *&((&dpx_6->primal_0)->y);
    float s_diff_len_0 = _S122 + _S122 + (_S123 + _S123);
    DiffPair_float_0 _S124;
    (&_S124)->primal_0 = *&((&dpx_6->primal_0)->x) * *&((&dpx_6->primal_0)->x) + *&((&dpx_6->primal_0)->y) * *&((&dpx_6->primal_0)->y);
    (&_S124)->differential_0 = s_diff_len_0;
    DiffPair_float_0 _S125 = _d_sqrt_1(&_S124);
    DiffPair_float_0 _S126 = { _S125.primal_0, _S125.differential_0 };
    return _S126;
}

inline __device__ DiffPair_float_0 _d_atan2_0(DiffPair_float_0 * dpy_4, DiffPair_float_0 * dpx_7)
{
    float _S127 = dpx_7->primal_0 * dpx_7->primal_0 + dpy_4->primal_0 * dpy_4->primal_0;
    DiffPair_float_0 _S128 = { (F32_atan2((dpy_4->primal_0), (dpx_7->primal_0))), - dpy_4->primal_0 / _S127 * dpx_7->differential_0 + dpx_7->primal_0 / _S127 * dpy_4->differential_0 };
    return _S128;
}

inline __device__ DiffPair_float_0 s_fwd_DistKBPolarSpline_cubic_0(DiffPair_float_0 * dpa_0, DiffPair_float_0 * dpb_0, DiffPair_float_0 * dpc_0, DiffPair_float_0 * dpd_0, DiffPair_float_0 * dpt_0)
{
    float _S129 = 0.5f * dpt_0->primal_0;
    float _S130 = 3.0f * (dpb_0->primal_0 - dpc_0->primal_0) + dpd_0->primal_0 - dpa_0->primal_0;
    float _S131 = 2.0f * dpa_0->primal_0 - 5.0f * dpb_0->primal_0 + 4.0f * dpc_0->primal_0 - dpd_0->primal_0 + dpt_0->primal_0 * _S130;
    float _S132 = dpc_0->primal_0 - dpa_0->primal_0 + dpt_0->primal_0 * _S131;
    DiffPair_float_0 _S133 = { dpb_0->primal_0 + _S129 * _S132, dpb_0->differential_0 + (dpt_0->differential_0 * 0.5f * _S132 + (dpc_0->differential_0 - dpa_0->differential_0 + (dpt_0->differential_0 * _S131 + (dpa_0->differential_0 * 2.0f - dpb_0->differential_0 * 5.0f + dpc_0->differential_0 * 4.0f - dpd_0->differential_0 + (dpt_0->differential_0 * _S130 + ((dpb_0->differential_0 - dpc_0->differential_0) * 3.0f + dpd_0->differential_0 - dpa_0->differential_0) * dpt_0->primal_0)) * dpt_0->primal_0)) * _S129) };
    return _S133;
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistKBPolarSpline_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_0, FixedArray<float, 58>  * coeffs_1)
{
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S134;
    (&_S134)->primal_0 = dpuv_0->primal_0;
    (&_S134)->differential_0 = dpuv_0->differential_0;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S135;
    (&_S135)->primal_0 = dpuv_0->primal_0;
    (&_S135)->differential_0 = dpuv_0->differential_0;
    DiffPair_float_0 _S136 = _d_dot_1(&_S134, &_S135);
    float _S137 = (*coeffs_1)[int(2)] + _S136.primal_0 * (*coeffs_1)[int(3)];
    float _S138 = (*coeffs_1)[int(1)] + _S136.primal_0 * _S137;
    float _S139 = (*coeffs_1)[int(0)] + _S136.primal_0 * _S138;
    float radial_0 = 1.0f + _S136.primal_0 * _S139;
    float2  kb_1 = dpuv_0->primal_0 * make_float2 (radial_0);
    float2  s_diff_kb_0 = dpuv_0->differential_0 * make_float2 (radial_0) + make_float2 (_S136.differential_0 * _S139 + (_S136.differential_0 * _S138 + (_S136.differential_0 * _S137 + _S136.differential_0 * (*coeffs_1)[int(3)] * _S136.primal_0) * _S136.primal_0) * _S136.primal_0) * dpuv_0->primal_0;
    float2  _S140 = make_float2 ((*coeffs_1)[int(4)], (*coeffs_1)[int(5)]);
    float2  grid_1 = kb_1 * _S140;
    float2  _S141 = s_diff_kb_0 * _S140;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S142;
    (&_S142)->primal_0 = grid_1;
    (&_S142)->differential_0 = _S141;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S143;
    (&_S143)->primal_0 = grid_1;
    (&_S143)->differential_0 = _S141;
    DiffPair_float_0 _S144 = _d_dot_1(&_S142, &_S143);
    if((_S144.primal_0) < 9.99999968265522539e-21f)
    {
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S145 = { kb_1, s_diff_kb_0 };
        return _S145;
    }
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S146;
    (&_S146)->primal_0 = grid_1;
    (&_S146)->differential_0 = _S141;
    DiffPair_float_0 _S147 = s_fwd_length_impl_0(&_S146);
    float _S148 = grid_1.y;
    float _S149 = _S141.y;
    float _S150 = grid_1.x;
    float _S151 = _S141.x;
    DiffPair_float_0 _S152;
    (&_S152)->primal_0 = _S148;
    (&_S152)->differential_0 = _S149;
    DiffPair_float_0 _S153;
    (&_S153)->primal_0 = _S150;
    (&_S153)->differential_0 = _S151;
    DiffPair_float_0 _S154 = _d_atan2_0(&_S152, &_S153);
    float theta_2 = _S154.primal_0 * 0.79577469825744629f;
    float _S155 = _S154.differential_0 * 0.79577469825744629f;
    float theta_3;
    if(theta_2 < 0.0f)
    {
        theta_3 = theta_2 + 5.0f;
    }
    else
    {
        theta_3 = theta_2;
    }
    int _S156 = int((F32_floor((_S147.primal_0))));
    int _S157 = int((F32_floor((theta_3))));
    int2  _S158 = make_int2 (int(0));
    float2  rt_1 = make_float2 ((float)_S158.x, (float)_S158.y);
    int _S159 = clamp_1(_S156 - int(1), int(0), int(6));
    int col_4 = ((_S157 - int(1)) % int(5) + int(5)) % int(5);
    bool _S160 = _S159 < int(2);
    int _S161 = (_S159 - int(2)) * int(5);
    int _S162 = int(8) + _S161;
    float _S163 = (*coeffs_1)[_S162 + col_4];
    int col_5 = ((_S157 + int(1) - int(1)) % int(5) + int(5)) % int(5);
    float _S164 = (*coeffs_1)[_S162 + col_5];
    int col_6 = ((_S157 + int(2) - int(1)) % int(5) + int(5)) % int(5);
    float _S165 = (*coeffs_1)[_S162 + col_6];
    int col_7 = ((_S157 + int(3) - int(1)) % int(5) + int(5)) % int(5);
    float _S166 = (*coeffs_1)[_S162 + col_7];
    float _S167 = theta_3 - float(_S157);
    int _S168 = clamp_1(_S156 + int(1) - int(1), int(0), int(6));
    bool _S169 = _S168 < int(2);
    int _S170 = (_S168 - int(2)) * int(5);
    int _S171 = int(8) + _S170;
    float _S172 = (*coeffs_1)[_S171 + col_4];
    float _S173 = (*coeffs_1)[_S171 + col_5];
    float _S174 = (*coeffs_1)[_S171 + col_6];
    float _S175 = (*coeffs_1)[_S171 + col_7];
    int _S176 = clamp_1(_S156 + int(2) - int(1), int(0), int(6));
    bool _S177 = _S176 < int(2);
    int _S178 = (_S176 - int(2)) * int(5);
    int _S179 = int(8) + _S178;
    float _S180 = (*coeffs_1)[_S179 + col_4];
    float _S181 = (*coeffs_1)[_S179 + col_5];
    float _S182 = (*coeffs_1)[_S179 + col_6];
    float _S183 = (*coeffs_1)[_S179 + col_7];
    int _S184 = clamp_1(_S156 + int(3) - int(1), int(0), int(6));
    bool _S185 = _S184 < int(2);
    int _S186 = (_S184 - int(2)) * int(5);
    int _S187 = int(8) + _S186;
    float _S188 = (*coeffs_1)[_S187 + col_4];
    float _S189 = (*coeffs_1)[_S187 + col_5];
    float _S190 = (*coeffs_1)[_S187 + col_6];
    float _S191 = (*coeffs_1)[_S187 + col_7];
    float _S192 = _S147.primal_0 - float(_S156);
    int _S193 = int(33) + _S161;
    float _S194 = (*coeffs_1)[_S193 + col_4];
    float _S195 = (*coeffs_1)[_S193 + col_5];
    float _S196 = (*coeffs_1)[_S193 + col_6];
    float _S197 = (*coeffs_1)[_S193 + col_7];
    int _S198 = int(33) + _S170;
    float _S199 = (*coeffs_1)[_S198 + col_4];
    float _S200 = (*coeffs_1)[_S198 + col_5];
    float _S201 = (*coeffs_1)[_S198 + col_6];
    float _S202 = (*coeffs_1)[_S198 + col_7];
    int _S203 = int(33) + _S178;
    float _S204 = (*coeffs_1)[_S203 + col_4];
    float _S205 = (*coeffs_1)[_S203 + col_5];
    float _S206 = (*coeffs_1)[_S203 + col_6];
    float _S207 = (*coeffs_1)[_S203 + col_7];
    int _S208 = int(33) + _S186;
    float _S209 = (*coeffs_1)[_S208 + col_4];
    float _S210 = (*coeffs_1)[_S208 + col_5];
    float _S211 = (*coeffs_1)[_S208 + col_6];
    float _S212 = (*coeffs_1)[_S208 + col_7];
    float2  _S213 = make_float2 ((*coeffs_1)[int(6)], (*coeffs_1)[int(7)]);
    if(_S160)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S163;
    }
    float _S214;
    if(_S160)
    {
        _S214 = 0.0f;
    }
    else
    {
        _S214 = _S164;
    }
    float _S215;
    if(_S160)
    {
        _S215 = 0.0f;
    }
    else
    {
        _S215 = _S165;
    }
    float _S216;
    if(_S160)
    {
        _S216 = 0.0f;
    }
    else
    {
        _S216 = _S166;
    }
    DiffPair_float_0 _S217;
    (&_S217)->primal_0 = theta_3;
    (&_S217)->differential_0 = 0.0f;
    DiffPair_float_0 _S218;
    (&_S218)->primal_0 = _S214;
    (&_S218)->differential_0 = 0.0f;
    DiffPair_float_0 _S219;
    (&_S219)->primal_0 = _S215;
    (&_S219)->differential_0 = 0.0f;
    DiffPair_float_0 _S220;
    (&_S220)->primal_0 = _S216;
    (&_S220)->differential_0 = 0.0f;
    DiffPair_float_0 _S221;
    (&_S221)->primal_0 = _S167;
    (&_S221)->differential_0 = _S155;
    DiffPair_float_0 _S222 = s_fwd_DistKBPolarSpline_cubic_0(&_S217, &_S218, &_S219, &_S220, &_S221);
    if(_S169)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S172;
    }
    if(_S169)
    {
        _S214 = 0.0f;
    }
    else
    {
        _S214 = _S173;
    }
    if(_S169)
    {
        _S215 = 0.0f;
    }
    else
    {
        _S215 = _S174;
    }
    if(_S169)
    {
        _S216 = 0.0f;
    }
    else
    {
        _S216 = _S175;
    }
    DiffPair_float_0 _S223;
    (&_S223)->primal_0 = theta_3;
    (&_S223)->differential_0 = 0.0f;
    DiffPair_float_0 _S224;
    (&_S224)->primal_0 = _S214;
    (&_S224)->differential_0 = 0.0f;
    DiffPair_float_0 _S225;
    (&_S225)->primal_0 = _S215;
    (&_S225)->differential_0 = 0.0f;
    DiffPair_float_0 _S226;
    (&_S226)->primal_0 = _S216;
    (&_S226)->differential_0 = 0.0f;
    DiffPair_float_0 _S227;
    (&_S227)->primal_0 = _S167;
    (&_S227)->differential_0 = _S155;
    DiffPair_float_0 _S228 = s_fwd_DistKBPolarSpline_cubic_0(&_S223, &_S224, &_S225, &_S226, &_S227);
    if(_S177)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S180;
    }
    if(_S177)
    {
        _S214 = 0.0f;
    }
    else
    {
        _S214 = _S181;
    }
    if(_S177)
    {
        _S215 = 0.0f;
    }
    else
    {
        _S215 = _S182;
    }
    if(_S177)
    {
        _S216 = 0.0f;
    }
    else
    {
        _S216 = _S183;
    }
    DiffPair_float_0 _S229;
    (&_S229)->primal_0 = theta_3;
    (&_S229)->differential_0 = 0.0f;
    DiffPair_float_0 _S230;
    (&_S230)->primal_0 = _S214;
    (&_S230)->differential_0 = 0.0f;
    DiffPair_float_0 _S231;
    (&_S231)->primal_0 = _S215;
    (&_S231)->differential_0 = 0.0f;
    DiffPair_float_0 _S232;
    (&_S232)->primal_0 = _S216;
    (&_S232)->differential_0 = 0.0f;
    DiffPair_float_0 _S233;
    (&_S233)->primal_0 = _S167;
    (&_S233)->differential_0 = _S155;
    DiffPair_float_0 _S234 = s_fwd_DistKBPolarSpline_cubic_0(&_S229, &_S230, &_S231, &_S232, &_S233);
    if(_S185)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S188;
    }
    if(_S185)
    {
        _S214 = 0.0f;
    }
    else
    {
        _S214 = _S189;
    }
    if(_S185)
    {
        _S215 = 0.0f;
    }
    else
    {
        _S215 = _S190;
    }
    if(_S185)
    {
        _S216 = 0.0f;
    }
    else
    {
        _S216 = _S191;
    }
    DiffPair_float_0 _S235;
    (&_S235)->primal_0 = theta_3;
    (&_S235)->differential_0 = 0.0f;
    DiffPair_float_0 _S236;
    (&_S236)->primal_0 = _S214;
    (&_S236)->differential_0 = 0.0f;
    DiffPair_float_0 _S237;
    (&_S237)->primal_0 = _S215;
    (&_S237)->differential_0 = 0.0f;
    DiffPair_float_0 _S238;
    (&_S238)->primal_0 = _S216;
    (&_S238)->differential_0 = 0.0f;
    DiffPair_float_0 _S239;
    (&_S239)->primal_0 = _S167;
    (&_S239)->differential_0 = _S155;
    DiffPair_float_0 _S240 = s_fwd_DistKBPolarSpline_cubic_0(&_S235, &_S236, &_S237, &_S238, &_S239);
    DiffPair_float_0 _S241;
    (&_S241)->primal_0 = _S222.primal_0;
    (&_S241)->differential_0 = _S222.differential_0;
    DiffPair_float_0 _S242;
    (&_S242)->primal_0 = _S228.primal_0;
    (&_S242)->differential_0 = _S228.differential_0;
    DiffPair_float_0 _S243;
    (&_S243)->primal_0 = _S234.primal_0;
    (&_S243)->differential_0 = _S234.differential_0;
    DiffPair_float_0 _S244;
    (&_S244)->primal_0 = _S240.primal_0;
    (&_S244)->differential_0 = _S240.differential_0;
    DiffPair_float_0 _S245;
    (&_S245)->primal_0 = _S192;
    (&_S245)->differential_0 = _S147.differential_0;
    DiffPair_float_0 _S246 = s_fwd_DistKBPolarSpline_cubic_0(&_S241, &_S242, &_S243, &_S244, &_S245);
    float2  _S247 = rt_1;
    *&((&_S247)->x) = _S246.primal_0;
    float2  _S248 = make_float2 (0.0f);
    *&((&_S248)->x) = _S246.differential_0;
    if(_S160)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S194;
    }
    if(_S160)
    {
        _S214 = 0.0f;
    }
    else
    {
        _S214 = _S195;
    }
    if(_S160)
    {
        _S215 = 0.0f;
    }
    else
    {
        _S215 = _S196;
    }
    if(_S160)
    {
        _S216 = 0.0f;
    }
    else
    {
        _S216 = _S197;
    }
    DiffPair_float_0 _S249;
    (&_S249)->primal_0 = theta_3;
    (&_S249)->differential_0 = 0.0f;
    DiffPair_float_0 _S250;
    (&_S250)->primal_0 = _S214;
    (&_S250)->differential_0 = 0.0f;
    DiffPair_float_0 _S251;
    (&_S251)->primal_0 = _S215;
    (&_S251)->differential_0 = 0.0f;
    DiffPair_float_0 _S252;
    (&_S252)->primal_0 = _S216;
    (&_S252)->differential_0 = 0.0f;
    DiffPair_float_0 _S253;
    (&_S253)->primal_0 = _S167;
    (&_S253)->differential_0 = _S155;
    DiffPair_float_0 _S254 = s_fwd_DistKBPolarSpline_cubic_0(&_S249, &_S250, &_S251, &_S252, &_S253);
    if(_S169)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S199;
    }
    if(_S169)
    {
        _S214 = 0.0f;
    }
    else
    {
        _S214 = _S200;
    }
    if(_S169)
    {
        _S215 = 0.0f;
    }
    else
    {
        _S215 = _S201;
    }
    if(_S169)
    {
        _S216 = 0.0f;
    }
    else
    {
        _S216 = _S202;
    }
    DiffPair_float_0 _S255;
    (&_S255)->primal_0 = theta_3;
    (&_S255)->differential_0 = 0.0f;
    DiffPair_float_0 _S256;
    (&_S256)->primal_0 = _S214;
    (&_S256)->differential_0 = 0.0f;
    DiffPair_float_0 _S257;
    (&_S257)->primal_0 = _S215;
    (&_S257)->differential_0 = 0.0f;
    DiffPair_float_0 _S258;
    (&_S258)->primal_0 = _S216;
    (&_S258)->differential_0 = 0.0f;
    DiffPair_float_0 _S259;
    (&_S259)->primal_0 = _S167;
    (&_S259)->differential_0 = _S155;
    DiffPair_float_0 _S260 = s_fwd_DistKBPolarSpline_cubic_0(&_S255, &_S256, &_S257, &_S258, &_S259);
    if(_S177)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S204;
    }
    if(_S177)
    {
        _S214 = 0.0f;
    }
    else
    {
        _S214 = _S205;
    }
    if(_S177)
    {
        _S215 = 0.0f;
    }
    else
    {
        _S215 = _S206;
    }
    if(_S177)
    {
        _S216 = 0.0f;
    }
    else
    {
        _S216 = _S207;
    }
    DiffPair_float_0 _S261;
    (&_S261)->primal_0 = theta_3;
    (&_S261)->differential_0 = 0.0f;
    DiffPair_float_0 _S262;
    (&_S262)->primal_0 = _S214;
    (&_S262)->differential_0 = 0.0f;
    DiffPair_float_0 _S263;
    (&_S263)->primal_0 = _S215;
    (&_S263)->differential_0 = 0.0f;
    DiffPair_float_0 _S264;
    (&_S264)->primal_0 = _S216;
    (&_S264)->differential_0 = 0.0f;
    DiffPair_float_0 _S265;
    (&_S265)->primal_0 = _S167;
    (&_S265)->differential_0 = _S155;
    DiffPair_float_0 _S266 = s_fwd_DistKBPolarSpline_cubic_0(&_S261, &_S262, &_S263, &_S264, &_S265);
    if(_S185)
    {
        theta_3 = 0.0f;
    }
    else
    {
        theta_3 = _S209;
    }
    if(_S185)
    {
        _S214 = 0.0f;
    }
    else
    {
        _S214 = _S210;
    }
    if(_S185)
    {
        _S215 = 0.0f;
    }
    else
    {
        _S215 = _S211;
    }
    if(_S185)
    {
        _S216 = 0.0f;
    }
    else
    {
        _S216 = _S212;
    }
    DiffPair_float_0 _S267;
    (&_S267)->primal_0 = theta_3;
    (&_S267)->differential_0 = 0.0f;
    DiffPair_float_0 _S268;
    (&_S268)->primal_0 = _S214;
    (&_S268)->differential_0 = 0.0f;
    DiffPair_float_0 _S269;
    (&_S269)->primal_0 = _S215;
    (&_S269)->differential_0 = 0.0f;
    DiffPair_float_0 _S270;
    (&_S270)->primal_0 = _S216;
    (&_S270)->differential_0 = 0.0f;
    DiffPair_float_0 _S271;
    (&_S271)->primal_0 = _S167;
    (&_S271)->differential_0 = _S155;
    DiffPair_float_0 _S272 = s_fwd_DistKBPolarSpline_cubic_0(&_S267, &_S268, &_S269, &_S270, &_S271);
    DiffPair_float_0 _S273;
    (&_S273)->primal_0 = _S254.primal_0;
    (&_S273)->differential_0 = _S254.differential_0;
    DiffPair_float_0 _S274;
    (&_S274)->primal_0 = _S260.primal_0;
    (&_S274)->differential_0 = _S260.differential_0;
    DiffPair_float_0 _S275;
    (&_S275)->primal_0 = _S266.primal_0;
    (&_S275)->differential_0 = _S266.differential_0;
    DiffPair_float_0 _S276;
    (&_S276)->primal_0 = _S272.primal_0;
    (&_S276)->differential_0 = _S272.differential_0;
    DiffPair_float_0 _S277;
    (&_S277)->primal_0 = _S192;
    (&_S277)->differential_0 = _S147.differential_0;
    DiffPair_float_0 _S278 = s_fwd_DistKBPolarSpline_cubic_0(&_S273, &_S274, &_S275, &_S276, &_S277);
    *&((&_S247)->y) = _S278.primal_0;
    *&((&_S248)->y) = _S278.differential_0;
    float _S279 = _S247.x;
    float _S280 = _S248.x;
    float _S281 = _S247.y;
    float _S282 = _S248.y;
    float2  _S283 = make_float2 (_S279 * _S150 - _S281 * _S148, _S279 * _S148 + _S281 * _S150);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S284 = { kb_1 + _S283 / make_float2 (_S147.primal_0) * _S213, s_diff_kb_0 + (make_float2 (_S280 * _S150 + _S151 * _S279 - (_S282 * _S148 + _S149 * _S281), _S280 * _S148 + _S149 * _S279 + (_S282 * _S150 + _S151 * _S281)) * make_float2 (_S147.primal_0) - _S283 * make_float2 (_S147.differential_0)) / make_float2 (_S147.primal_0 * _S147.primal_0) * _S213 };
    return _S284;
}

inline __device__ Matrix<float, 2, 2>  transpose_0(Matrix<float, 2, 2>  x_20)
{
    Matrix<float, 2, 2>  result_5;
    int r_0 = int(0);
    for(;;)
    {
        if(r_0 < int(2))
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
            *_slang_vector_get_element_ptr(((&result_5)->rows + (r_0)), c_1) = _slang_vector_get_element(x_20.rows[c_1], r_0);
            c_1 = c_1 + int(1);
        }
        r_0 = r_0 + int(1);
    }
    return result_5;
}

inline __device__ float determinant_0(Matrix<float, 2, 2>  m_0)
{
    return m_0.rows[int(0)].x * m_0.rows[int(1)].y - m_0.rows[int(0)].y * m_0.rows[int(1)].x;
}

inline __device__ bool undistort_point_0(float2  uv_1, FixedArray<float, 58>  * dist_coeffs_0, int maxiter_0, float2  * uv_undist_0)
{
    int i_3 = int(0);
    float2  q_0 = uv_1;
    for(;;)
    {
        if(i_3 < maxiter_0)
        {
        }
        else
        {
            break;
        }
        float2  _S285 = DistKBPolarSpline_distort_0(q_0, dist_coeffs_0);
        float2  r_1 = _S285 - uv_1;
        float2  _S286 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S287;
        (&_S287)->primal_0 = q_0;
        (&_S287)->differential_0 = _S286;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S288 = s_fwd_DistKBPolarSpline_distort_0(&_S287, dist_coeffs_0);
        float2  _S289 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S290;
        (&_S290)->primal_0 = q_0;
        (&_S290)->differential_0 = _S289;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S291 = s_fwd_DistKBPolarSpline_distort_0(&_S290, dist_coeffs_0);
        Matrix<float, 2, 2>  _S292 = transpose_0(makeMatrix<float, 2, 2> (_S288.differential_0, _S291.differential_0));
        float inv_det_0 = 1.0f / (_S292.rows[int(0)].x * _S292.rows[int(1)].y - _S292.rows[int(0)].y * _S292.rows[int(1)].x);
        float _S293 = r_1.x;
        float _S294 = r_1.y;
        float2  q_1 = q_0 - make_float2 ((_S293 * _S292.rows[int(1)].y - _S294 * _S292.rows[int(0)].y) * inv_det_0, (- _S293 * _S292.rows[int(1)].x + _S294 * _S292.rows[int(0)].x) * inv_det_0);
        i_3 = i_3 + int(1);
        q_0 = q_1;
    }
    *uv_undist_0 = q_0;
    float2  _S295 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S296;
    (&_S296)->primal_0 = q_0;
    (&_S296)->differential_0 = _S295;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S297 = s_fwd_DistKBPolarSpline_distort_0(&_S296, dist_coeffs_0);
    float2  _S298 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S299;
    (&_S299)->primal_0 = q_0;
    (&_S299)->differential_0 = _S298;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S300 = s_fwd_DistKBPolarSpline_distort_0(&_S299, dist_coeffs_0);
    Matrix<float, 2, 2>  _S301 = transpose_0(makeMatrix<float, 2, 2> (_S297.differential_0, _S300.differential_0));
    float _S302 = (F32_min((determinant_0(_S301)), ((F32_min((_S301.rows[int(0)].x), (_S301.rows[int(1)].y))))));
    bool _S303;
    if(_S302 > 0.25f)
    {
        _S303 = _S302 < 4.0f;
    }
    else
    {
        _S303 = false;
    }
    if(_S303)
    {
        float2  _S304 = DistKBPolarSpline_distort_0(q_0, dist_coeffs_0);
        _S303 = (dot_0(q_0, _S304)) >= 0.0f;
    }
    else
    {
        _S303 = false;
    }
    if(_S303)
    {
        float2  _S305 = DistKBPolarSpline_distort_0(*uv_undist_0, dist_coeffs_0);
        _S303 = (length_0(_S305 - uv_1)) < 0.00999999977648258f;
    }
    else
    {
        _S303 = false;
    }
    return _S303;
}

struct Tuple_14
{
    float3  value0_19;
};

struct Tuple_15
{
    float3  value0_20;
};

inline __device__ Tuple_15 s_apply_equirect_unproj_0(float2  _S306)
{
    float lon_0 = _S306.x;
    float lat_0 = _S306.y;
    Tuple_1 _S307 = s_apply_cos_0(lat_0);
    Tuple_15 _S308;
    (&_S308)->value0_20 = make_float3 (_S307.value0_1 * s_apply_sin_0(lon_0).value0_2, s_apply_sin_0(lat_0).value0_2, _S307.value0_1 * s_apply_cos_0(lon_0).value0_1);
    return _S308;
}

inline __device__ Tuple_14 s_apply_unproject_raydir_0(float2  _S309, int camera_model_0, bool is_ray_depth_0)
{
    float3  raydir_0;
    bool is_unit_0;
    if(camera_model_0 == int(1))
    {
        Tuple_3 _S310 = s_apply_length_0(_S309);
        float3  _S311 = make_float3 ((_S309 / make_float2 (s_apply_max_0(_S310.value0_3, 1.00000001168609742e-07f).value0_16) * make_float2 (s_apply_sin_0(_S310.value0_3).value0_2)).x, (_S309 / make_float2 (s_apply_max_0(_S310.value0_3, 1.00000001168609742e-07f).value0_16) * make_float2 (s_apply_sin_0(_S310.value0_3).value0_2)).y, s_apply_cos_0(_S310.value0_3).value0_1);
        is_unit_0 = true;
        raydir_0 = _S311;
    }
    else
    {
        if(camera_model_0 == int(2))
        {
            Tuple_3 _S312 = s_apply_length_0(_S309);
            float3  _S313 = make_float3 ((_S309 * make_float2 (s_apply_sqrt_0(s_apply_max_0(0.0f, 1.0f - 0.25f * _S312.value0_3 * _S312.value0_3).value0_16).value0_0)).x, (_S309 * make_float2 (s_apply_sqrt_0(s_apply_max_0(0.0f, 1.0f - 0.25f * _S312.value0_3 * _S312.value0_3).value0_16).value0_0)).y, 1.0f - 0.5f * _S312.value0_3 * _S312.value0_3);
            is_unit_0 = true;
            raydir_0 = _S313;
        }
        else
        {
            bool _S314 = camera_model_0 == int(3);
            if(_S314)
            {
                raydir_0 = s_apply_equirect_unproj_0(_S309).value0_20;
            }
            else
            {
                raydir_0 = make_float3 (_S309.x, _S309.y, 1.0f);
            }
            is_unit_0 = _S314;
        }
    }
    if(is_ray_depth_0)
    {
        if(is_unit_0)
        {
        }
        else
        {
            raydir_0 = s_apply_normalize_0(raydir_0).value0_4;
        }
    }
    else
    {
        raydir_0 = raydir_0 / make_float3 (raydir_0.z);
    }
    Tuple_14 _S315;
    (&_S315)->value0_19 = raydir_0;
    return _S315;
}

inline __device__ Tuple_13 s_apply_depth_normal_loss_0(float2  pix_center_0, float4  intrins_0, FixedArray<float, 58>  * dist_coeffs_1, int camera_model_1, bool is_ray_depth_1, float4  _S316, float3  _S317)
{
    float2  _S318 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_normal_loss_0 _S319;
    (&_S319)->value0_17 = false;
    (&_S319)->value1_0 = _S318;
    (&_S319)->value2_0 = _S318;
    (&_S319)->value3_0 = false;
    (&_S319)->value4_0 = _S318;
    (&_S319)->value5_0 = false;
    (&_S319)->value6_0 = _S318;
    (&_S319)->value7_0 = false;
    (&_S319)->value8_0 = _S318;
    (&_S319)->value9_0 = false;
    float3  _S320 = make_float3 (0.0f);
    float2  _S321 = float2 {intrins_0.z, intrins_0.w};
    float2  _S322 = float2 {intrins_0.x, intrins_0.y};
    float2  uv_2 = (pix_center_0 + make_float2 (-1.0f, -0.0f) - _S321) / _S322;
    float2  _S323 = _S318;
    bool _S324 = undistort_point_0(uv_2, dist_coeffs_1, int(12), &_S323);
    (&_S319)->value0_17 = _S324;
    float2  uv_u_0 = _S323;
    (&_S319)->value1_0 = _S323;
    bool _S325 = !!_S324;
    int _S326;
    float3  raydir_1;
    FixedArray<float3 , 5>  points_0;
    if(_S325)
    {
        Tuple_14 _S327 = s_apply_unproject_raydir_0(uv_u_0, camera_model_1, is_ray_depth_1);
        float3  _S328 = make_float3 (_S316.x) * _S327.value0_19;
        float2  uv_3 = (pix_center_0 + make_float2 (1.0f, -0.0f) - _S321) / _S322;
        float2  _S329 = _S318;
        bool _S330 = undistort_point_0(uv_3, dist_coeffs_1, int(12), &_S329);
        (&_S319)->value2_0 = _S329;
        (&_S319)->value3_0 = _S330;
        float2  uv_u_1 = _S329;
        bool _runFlag_0;
        if(!_S330)
        {
            _runFlag_0 = false;
        }
        else
        {
            _runFlag_0 = _S325;
        }
        if(_runFlag_0)
        {
            Tuple_14 _S331 = s_apply_unproject_raydir_0(uv_u_1, camera_model_1, is_ray_depth_1);
            float3  _S332 = make_float3 (_S316.y) * _S331.value0_19;
            float2  uv_4 = (pix_center_0 + make_float2 (0.0f, -1.0f) - _S321) / _S322;
            float2  _S333 = _S318;
            bool _S334 = undistort_point_0(uv_4, dist_coeffs_1, int(12), &_S333);
            (&_S319)->value4_0 = _S333;
            (&_S319)->value5_0 = _S334;
            float2  uv_u_2 = _S333;
            if(!_S334)
            {
                _runFlag_0 = false;
            }
            if(_runFlag_0)
            {
                Tuple_14 _S335 = s_apply_unproject_raydir_0(uv_u_2, camera_model_1, is_ray_depth_1);
                float3  _S336 = make_float3 (_S316.z) * _S335.value0_19;
                float2  uv_5 = (pix_center_0 + make_float2 (0.0f, 1.0f) - _S321) / _S322;
                float2  _S337 = _S318;
                bool _S338 = undistort_point_0(uv_5, dist_coeffs_1, int(12), &_S337);
                (&_S319)->value6_0 = _S337;
                (&_S319)->value7_0 = _S338;
                float2  uv_u_3 = _S337;
                if(!_S338)
                {
                    _runFlag_0 = false;
                }
                if(_runFlag_0)
                {
                    Tuple_14 _S339 = s_apply_unproject_raydir_0(uv_u_3, camera_model_1, is_ray_depth_1);
                    float3  _S340 = make_float3 (_S316.w) * _S339.value0_19;
                    float2  uv_6 = (pix_center_0 - _S321) / _S322;
                    float2  _S341 = _S318;
                    bool _S342 = undistort_point_0(uv_6, dist_coeffs_1, int(12), &_S341);
                    (&_S319)->value8_0 = _S341;
                    (&_S319)->value9_0 = _S342;
                    float2  uv_u_4 = _S341;
                    if(!_S342)
                    {
                        _runFlag_0 = false;
                    }
                    if(_runFlag_0)
                    {
                        Tuple_14 _S343 = s_apply_unproject_raydir_0(uv_u_4, camera_model_1, is_ray_depth_1);
                        _S326 = int(1);
                        raydir_1 = _S343.value0_19;
                    }
                    else
                    {
                        _S326 = int(0);
                        raydir_1 = _S339.value0_19;
                    }
                    points_0[int(0)] = _S328;
                    points_0[int(1)] = _S332;
                    points_0[int(2)] = _S336;
                    points_0[int(3)] = _S340;
                    points_0[int(4)] = _S320;
                }
                else
                {
                    _S326 = int(0);
                    raydir_1 = _S335.value0_19;
                    points_0[int(0)] = _S328;
                    points_0[int(1)] = _S332;
                    points_0[int(2)] = _S336;
                    points_0[int(3)] = _S320;
                    points_0[int(4)] = _S320;
                }
            }
            else
            {
                _S326 = int(0);
                raydir_1 = _S331.value0_19;
                points_0[int(0)] = _S328;
                points_0[int(1)] = _S332;
                points_0[int(2)] = _S320;
                points_0[int(3)] = _S320;
                points_0[int(4)] = _S320;
            }
        }
        else
        {
            _S326 = int(0);
            raydir_1 = _S327.value0_19;
            points_0[int(0)] = _S328;
            points_0[int(1)] = _S320;
            points_0[int(2)] = _S320;
            points_0[int(3)] = _S320;
            points_0[int(4)] = _S320;
        }
    }
    else
    {
        _S326 = int(0);
        points_0[int(0)] = _S320;
        points_0[int(1)] = _S320;
        points_0[int(2)] = _S320;
        points_0[int(3)] = _S320;
        points_0[int(4)] = _S320;
    }
    float _S344;
    if(!(_S326 != int(1)))
    {
        Tuple_9 _S345 = s_apply_cross_0(points_0[int(1)] - points_0[int(0)], - (points_0[int(3)] - points_0[int(2)]));
        float3  _S346 = _S345.value0_13;
        float3  normal_0;
        if((s_apply_dot_0(_S346, _S346).value0_14) != 0.0f)
        {
            normal_0 = s_apply_normalize_0(_S345.value0_13).value0_4;
        }
        else
        {
            normal_0 = _S345.value0_13;
        }
        float3  _S347;
        if((s_apply_dot_0(_S317, _S317).value0_14) != 0.0f)
        {
            _S347 = s_apply_normalize_0(_S317).value0_4;
        }
        else
        {
            _S347 = _S317;
        }
        _S344 = (1.0f - s_apply_dot_0(normal_0, _S347).value0_14 + 0.00100000004749745f) / (s_apply_max_0(s_apply_dot_0(normal_0, - s_apply_normalize_0(raydir_1).value0_4).value0_14, 0.0f).value0_16 + 0.00100000004749745f);
    }
    else
    {
        _S344 = 0.0f;
    }
    Tuple_13 _S348;
    (&_S348)->value0_18 = _S344;
    (&_S348)->value1_1 = _S319;
    return _S348;
}

struct s_paramCtx_s_bwdCallableCtx_depth_normal_loss_0
{
    int value1_2;
    bool value2_1;
    float4  value3_1;
    float3  value4_1;
};

struct s_bwdCallableCtx_depth_normal_loss_0
{
    s_paramCtx_s_bwdCallableCtx_depth_normal_loss_0 value0_21;
    s_minCtx_s_bwdCallableCtx_depth_normal_loss_0 value1_3;
};

inline __device__ void Array_dzero_0(FixedArray<float3 , 5>  * _S349)
{
    float3  _S350 = make_float3 (0.0f);
    (*_S349)[int(0)] = _S350;
    (*_S349)[int(1)] = _S350;
    (*_S349)[int(2)] = _S350;
    (*_S349)[int(3)] = _S350;
    (*_S349)[int(4)] = _S350;
    return;
}

inline __device__ void Array_dadd_0(FixedArray<float3 , 5>  * a_2, FixedArray<float3 , 5>  * b_2, FixedArray<float3 , 5>  * _S351)
{
    FixedArray<float3 , 5>  result_6;
    result_6[int(0)] = (*a_2)[int(0)] + (*b_2)[int(0)];
    result_6[int(1)] = (*a_2)[int(1)] + (*b_2)[int(1)];
    result_6[int(2)] = (*a_2)[int(2)] + (*b_2)[int(2)];
    result_6[int(3)] = (*a_2)[int(3)] + (*b_2)[int(3)];
    result_6[int(4)] = (*a_2)[int(4)] + (*b_2)[int(4)];
    *_S351 = result_6;
    return;
}

inline __device__ void s_bwdProp_depth_normal_loss_0(s_bwdCallableCtx_depth_normal_loss_0 * _S352, float4  * _S353, float3  * _S354, float _S355)
{
    float3  _S356 = make_float3 (0.0f);
    bool _S357 = !!(&_S352->value1_3)->value0_17;
    bool _runFlag_1;
    bool _runFlag_2;
    bool _runFlag_3;
    bool _runFlag_4;
    int _S358;
    float3  raydir_2;
    float3  _S359;
    float3  _S360;
    float3  _S361;
    float3  _S362;
    FixedArray<float3 , 5>  points_1;
    if(_S357)
    {
        bool _S363 = (&_S352->value0_21)->value2_1;
        int _S364 = (&_S352->value0_21)->value1_2;
        Tuple_14 _S365 = s_apply_unproject_raydir_0((&_S352->value1_3)->value1_0, (&_S352->value0_21)->value1_2, (&_S352->value0_21)->value2_1);
        float3  _S366 = make_float3 (*&((&(&_S352->value0_21)->value3_1)->x)) * _S365.value0_19;
        float2  _S367 = (&_S352->value1_3)->value2_0;
        if(!(&_S352->value1_3)->value3_0)
        {
            _runFlag_1 = false;
        }
        else
        {
            _runFlag_1 = _S357;
        }
        if(_runFlag_1)
        {
            Tuple_14 _S368 = s_apply_unproject_raydir_0(_S367, _S364, _S363);
            float3  _S369 = make_float3 (*&((&(&_S352->value0_21)->value3_1)->y)) * _S368.value0_19;
            float2  _S370 = (&_S352->value1_3)->value4_0;
            if(!(&_S352->value1_3)->value5_0)
            {
                _runFlag_2 = false;
            }
            else
            {
                _runFlag_2 = _runFlag_1;
            }
            if(_runFlag_2)
            {
                Tuple_14 _S371 = s_apply_unproject_raydir_0(_S370, _S364, _S363);
                float3  _S372 = make_float3 (*&((&(&_S352->value0_21)->value3_1)->z)) * _S371.value0_19;
                float2  _S373 = (&_S352->value1_3)->value6_0;
                if(!(&_S352->value1_3)->value7_0)
                {
                    _runFlag_3 = false;
                }
                else
                {
                    _runFlag_3 = _runFlag_2;
                }
                if(_runFlag_3)
                {
                    Tuple_14 _S374 = s_apply_unproject_raydir_0(_S373, _S364, _S363);
                    float3  _S375 = make_float3 (*&((&(&_S352->value0_21)->value3_1)->w)) * _S374.value0_19;
                    float2  _S376 = (&_S352->value1_3)->value8_0;
                    if(!(&_S352->value1_3)->value9_0)
                    {
                        _runFlag_4 = false;
                    }
                    else
                    {
                        _runFlag_4 = _runFlag_3;
                    }
                    if(_runFlag_4)
                    {
                        Tuple_14 _S377 = s_apply_unproject_raydir_0(_S376, _S364, _S363);
                        _S358 = int(1);
                        raydir_2 = _S377.value0_19;
                    }
                    else
                    {
                        _S358 = int(0);
                        raydir_2 = _S374.value0_19;
                    }
                    points_1[int(0)] = _S366;
                    points_1[int(1)] = _S369;
                    points_1[int(2)] = _S372;
                    points_1[int(3)] = _S375;
                    points_1[int(4)] = _S356;
                    _S359 = _S374.value0_19;
                }
                else
                {
                    _S358 = int(0);
                    raydir_2 = _S371.value0_19;
                    points_1[int(0)] = _S366;
                    points_1[int(1)] = _S369;
                    points_1[int(2)] = _S372;
                    points_1[int(3)] = _S356;
                    points_1[int(4)] = _S356;
                    _S359 = _S356;
                }
                _S360 = _S371.value0_19;
            }
            else
            {
                _S358 = int(0);
                raydir_2 = _S368.value0_19;
                points_1[int(0)] = _S366;
                points_1[int(1)] = _S369;
                points_1[int(2)] = _S356;
                points_1[int(3)] = _S356;
                points_1[int(4)] = _S356;
                _runFlag_3 = false;
                _S359 = _S356;
                _S360 = _S356;
            }
            _S361 = _S368.value0_19;
        }
        else
        {
            _S358 = int(0);
            raydir_2 = _S365.value0_19;
            points_1[int(0)] = _S366;
            points_1[int(1)] = _S356;
            points_1[int(2)] = _S356;
            points_1[int(3)] = _S356;
            points_1[int(4)] = _S356;
            _runFlag_2 = false;
            _runFlag_3 = false;
            _S359 = _S356;
            _S360 = _S356;
            _S361 = _S356;
        }
        _S362 = _S365.value0_19;
    }
    else
    {
        _S358 = int(0);
        points_1[int(0)] = _S356;
        points_1[int(1)] = _S356;
        points_1[int(2)] = _S356;
        points_1[int(3)] = _S356;
        points_1[int(4)] = _S356;
        _runFlag_1 = false;
        _runFlag_2 = false;
        _runFlag_3 = false;
        _S359 = _S356;
        _S360 = _S356;
        _S361 = _S356;
        _S362 = _S356;
    }
    bool _S378 = !(_S358 != int(1));
    bool _S379;
    float3  normal_1;
    float3  _S380;
    s_bwdCallableCtx_normalize_0 _S381;
    s_bwdCallableCtx_normalize_0 _S382;
    float _S383;
    float _S384;
    float _S385;
    s_bwdCallableCtx_max_0 _S386;
    s_bwdCallableCtx_dot_0 _S387;
    s_bwdCallableCtx_dot_0 _S388;
    s_bwdCallableCtx_dot_0 _S389;
    s_bwdCallableCtx_dot_0 _S390;
    s_bwdCallableCtx_cross_0 _S391;
    if(_S378)
    {
        float3  dx_0 = points_1[int(1)] - points_1[int(0)];
        float3  _S392 = - (points_1[int(3)] - points_1[int(2)]);
        Tuple_9 _S393 = s_apply_cross_0(dx_0, _S392);
        s_bwdCallableCtx_cross_0 _S394;
        (&_S394)->_S68 = dx_0;
        (&_S394)->_S69 = _S392;
        s_bwdCallableCtx_cross_0 _S395 = _S394;
        Tuple_10 _S396 = s_apply_dot_0(_S393.value0_13, _S393.value0_13);
        s_bwdCallableCtx_dot_0 _S397;
        (&_S397)->_S81 = _S393.value0_13;
        (&_S397)->_S82 = _S393.value0_13;
        s_bwdCallableCtx_dot_0 _S398 = _S397;
        bool _S399 = (_S396.value0_14) != 0.0f;
        if(_S399)
        {
            Tuple_4 _S400 = s_apply_normalize_0(_S393.value0_13);
            s_bwdCallableCtx_normalize_0 _S401;
            (&_S401)->_S9 = _S393.value0_13;
            normal_1 = _S400.value0_4;
            _S381 = _S401;
        }
        else
        {
            normal_1 = _S393.value0_13;
            (&_S381)->_S9 = _S356;
        }
        float3  _S402 = (&_S352->value0_21)->value4_1;
        Tuple_10 _S403 = s_apply_dot_0((&_S352->value0_21)->value4_1, (&_S352->value0_21)->value4_1);
        s_bwdCallableCtx_dot_0 _S404;
        (&_S404)->_S81 = (&_S352->value0_21)->value4_1;
        (&_S404)->_S82 = (&_S352->value0_21)->value4_1;
        s_bwdCallableCtx_dot_0 _S405 = _S404;
        bool _S406 = (_S403.value0_14) != 0.0f;
        if(_S406)
        {
            Tuple_4 _S407 = s_apply_normalize_0(_S402);
            s_bwdCallableCtx_normalize_0 _S408;
            (&_S408)->_S9 = _S402;
            _S380 = _S407.value0_4;
            _S382 = _S408;
        }
        else
        {
            _S380 = _S402;
            (&_S382)->_S9 = _S356;
        }
        Tuple_10 _S409 = s_apply_dot_0(normal_1, _S380);
        s_bwdCallableCtx_dot_0 _S410;
        (&_S410)->_S81 = normal_1;
        (&_S410)->_S82 = _S380;
        float num_0 = 1.0f - _S409.value0_14;
        float3  _S411 = - s_apply_normalize_0(raydir_2).value0_4;
        Tuple_10 _S412 = s_apply_dot_0(normal_1, _S411);
        s_bwdCallableCtx_dot_0 _S413;
        (&_S413)->_S81 = normal_1;
        (&_S413)->_S82 = _S411;
        float _S414 = num_0 + 0.00100000004749745f;
        Tuple_12 _S415 = s_apply_max_0(_S412.value0_14, 0.0f);
        s_bwdCallableCtx_max_0 _S416;
        (&_S416)->_S94 = _S412.value0_14;
        (&_S416)->_S95 = 0.0f;
        float _S417 = _S415.value0_16 + 0.00100000004749745f;
        s_bwdCallableCtx_normalize_0 _S418 = _S381;
        _S383 = _S417 * _S417;
        _S384 = _S414;
        _S385 = _S417;
        _S386 = _S416;
        _S387 = _S413;
        _S388 = _S410;
        _runFlag_4 = _S406;
        _S381 = _S382;
        _S389 = _S405;
        _S379 = _S399;
        _S382 = _S418;
        _S390 = _S398;
        _S391 = _S395;
    }
    else
    {
        _S383 = 0.0f;
        _S384 = 0.0f;
        _S385 = 0.0f;
        (&_S386)->_S94 = 0.0f;
        (&_S386)->_S95 = 0.0f;
        (&_S387)->_S81 = _S356;
        (&_S387)->_S82 = _S356;
        (&_S388)->_S81 = _S356;
        (&_S388)->_S82 = _S356;
        _runFlag_4 = false;
        (&_S381)->_S9 = _S356;
        (&_S389)->_S81 = _S356;
        (&_S389)->_S82 = _S356;
        _S379 = false;
        (&_S382)->_S9 = _S356;
        (&_S390)->_S81 = _S356;
        (&_S390)->_S82 = _S356;
        (&_S391)->_S68 = _S356;
        (&_S391)->_S69 = _S356;
    }
    float4  _S419 = make_float4 (0.0f);
    FixedArray<float3 , 5>  _S420;
    Array_dzero_0(&_S420);
    FixedArray<float3 , 5>  _S421 = _S420;
    if(_S378)
    {
        float _S422 = _S355 / _S383;
        float _S423 = _S384 * - _S422;
        float s_diff_num_T_0 = _S385 * _S422;
        float _S424 = 0.0f;
        float _S425 = 0.0f;
        s_bwdCallableCtx_max_0 _S426 = _S386;
        s_bwdProp_max_0(&_S426, &_S424, &_S425, _S423);
        float3  _S427 = _S356;
        float3  _S428 = _S356;
        s_bwdCallableCtx_dot_0 _S429 = _S387;
        s_bwdProp_dot_0(&_S429, &_S427, &_S428, _S424);
        float _S430 = - s_diff_num_T_0;
        float3  _S431 = _S356;
        float3  _S432 = _S356;
        s_bwdCallableCtx_dot_0 _S433 = _S388;
        s_bwdProp_dot_0(&_S433, &_S431, &_S432, _S430);
        float3  _S434 = _S432;
        float3  _S435 = _S427 + _S431;
        if(_runFlag_4)
        {
            float3  _S436 = _S356;
            s_bwdCallableCtx_normalize_0 _S437 = _S381;
            s_bwdProp_normalize_0(&_S437, &_S436, _S434);
            raydir_2 = _S436;
        }
        else
        {
            raydir_2 = _S434;
        }
        float3  _S438 = _S356;
        float3  _S439 = _S356;
        s_bwdCallableCtx_dot_0 _S440 = _S389;
        s_bwdProp_dot_0(&_S440, &_S438, &_S439, 0.0f);
        float3  _S441 = _S438 + _S439 + raydir_2;
        if(_S379)
        {
            float3  _S442 = _S356;
            s_bwdCallableCtx_normalize_0 _S443 = _S382;
            s_bwdProp_normalize_0(&_S443, &_S442, _S435);
            raydir_2 = _S442;
        }
        else
        {
            raydir_2 = _S435;
        }
        float3  _S444 = _S356;
        float3  _S445 = _S356;
        s_bwdCallableCtx_dot_0 _S446 = _S390;
        s_bwdProp_dot_0(&_S446, &_S444, &_S445, 0.0f);
        float3  _S447 = _S444 + _S445 + raydir_2;
        float3  _S448 = _S356;
        float3  _S449 = _S356;
        s_bwdCallableCtx_cross_0 _S450 = _S391;
        s_bwdProp_cross_0(&_S450, &_S448, &_S449, _S447);
        float3  s_diff_dy_T_0 = - _S449;
        float3  _S451 = - s_diff_dy_T_0;
        float3  _S452 = - _S448;
        FixedArray<float3 , 5>  _S453 = _S421;
        _S453[int(2)] = _S451;
        _S453[int(3)] = s_diff_dy_T_0;
        _S453[int(0)] = _S452;
        _S453[int(1)] = _S448;
        FixedArray<float3 , 5>  _S454 = _S421;
        FixedArray<float3 , 5>  _S455 = _S453;
        FixedArray<float3 , 5>  _S456;
        Array_dadd_0(&_S454, &_S455, &_S456);
        points_1 = _S456;
        raydir_2 = _S441;
    }
    else
    {
        points_1 = _S421;
        raydir_2 = _S356;
    }
    float4  _S457;
    if(_S357)
    {
        if(_runFlag_1)
        {
            if(_runFlag_2)
            {
                if(_runFlag_3)
                {
                    FixedArray<float3 , 5>  _S458 = points_1;
                    FixedArray<float3 , 5>  _S459 = _S421;
                    FixedArray<float3 , 5>  _S460;
                    Array_dadd_0(&_S458, &_S459, &_S460);
                    float3  _S461 = _S359 * _S460[int(3)];
                    float _S462 = _S461.x + _S461.y + _S461.z;
                    float4  _S463 = _S419;
                    *&((&_S463)->w) = _S462;
                    points_1 = _S421;
                    _S359 = _S460[int(2)];
                    normal_1 = _S460[int(0)];
                    _S380 = _S460[int(1)];
                    _S457 = _S463;
                }
                else
                {
                    FixedArray<float3 , 5>  _S464 = points_1;
                    FixedArray<float3 , 5>  _S465 = _S421;
                    FixedArray<float3 , 5>  _S466;
                    Array_dadd_0(&_S464, &_S465, &_S466);
                    points_1 = _S466;
                    _S359 = _S356;
                    normal_1 = _S356;
                    _S380 = _S356;
                    _S457 = _S419;
                }
                float3  _S467 = _S360 * (points_1[int(2)] + _S359);
                float _S468 = _S467.x + _S467.y + _S467.z;
                float3  _S469 = points_1[int(0)] + normal_1;
                float3  _S470 = points_1[int(1)] + _S380;
                float4  _S471 = _S419;
                *&((&_S471)->z) = _S468;
                float4  _S472 = _S457 + _S471;
                points_1 = _S421;
                _S359 = _S470;
                _S360 = _S469;
                _S457 = _S472;
            }
            else
            {
                FixedArray<float3 , 5>  _S473 = points_1;
                FixedArray<float3 , 5>  _S474 = _S421;
                FixedArray<float3 , 5>  _S475;
                Array_dadd_0(&_S473, &_S474, &_S475);
                points_1 = _S475;
                _S359 = _S356;
                _S360 = _S356;
                _S457 = _S419;
            }
            float3  _S476 = _S361 * (points_1[int(1)] + _S359);
            float _S477 = _S476.x + _S476.y + _S476.z;
            float3  _S478 = points_1[int(0)] + _S360;
            float4  _S479 = _S419;
            *&((&_S479)->y) = _S477;
            float4  _S480 = _S457 + _S479;
            points_1 = _S421;
            _S359 = _S478;
            _S457 = _S480;
        }
        else
        {
            FixedArray<float3 , 5>  _S481 = points_1;
            FixedArray<float3 , 5>  _S482 = _S421;
            FixedArray<float3 , 5>  _S483;
            Array_dadd_0(&_S481, &_S482, &_S483);
            points_1 = _S483;
            _S359 = _S356;
            _S457 = _S419;
        }
        float3  _S484 = _S362 * (points_1[int(0)] + _S359);
        float _S485 = _S484.x + _S484.y + _S484.z;
        float4  _S486 = _S419;
        *&((&_S486)->x) = _S485;
        _S457 = _S457 + _S486;
    }
    else
    {
        _S457 = _S419;
    }
    *_S353 = _S457;
    *_S354 = raydir_2;
    return;
}

inline __device__ void _S487(float2  _S488, float4  _S489, FixedArray<float, 58>  * _S490, int _S491, bool _S492, DiffPair_vectorx3Cfloatx2C4x3E_0 * _S493, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S494, float _S495)
{
    float4  _S496 = _S493->primal_0;
    float3  _S497 = _S494->primal_0;
    Tuple_13 _S498 = s_apply_depth_normal_loss_0(_S488, _S489, _S490, _S491, _S492, _S493->primal_0, _S494->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_normal_loss_0 _S499;
    (&_S499)->value1_2 = _S491;
    (&_S499)->value2_1 = _S492;
    (&_S499)->value3_1 = _S496;
    (&_S499)->value4_1 = _S497;
    s_bwdCallableCtx_depth_normal_loss_0 _S500;
    (&_S500)->value0_21 = _S499;
    (&_S500)->value1_3 = _S498.value1_1;
    s_bwdProp_depth_normal_loss_0(&_S500, &_S493->differential_0, &_S494->differential_0, _S495);
    return;
}

struct s_minCtx_s_bwdCallableCtx_depth_to_normal_0
{
    float2  value0_22;
    bool value1_4;
    float2  value2_2;
    bool value3_2;
    float2  value4_2;
    bool value5_1;
    float2  value6_1;
    bool value7_1;
};

struct Tuple_16
{
    float3  value0_23;
    s_minCtx_s_bwdCallableCtx_depth_to_normal_0 value1_5;
};

inline __device__ Tuple_16 s_apply_depth_to_normal_0(float2  pix_center_1, float4  intrins_1, FixedArray<float, 58>  * dist_coeffs_2, int camera_model_2, bool is_ray_depth_2, float4  _S501)
{
    float2  _S502 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_to_normal_0 _S503;
    (&_S503)->value0_22 = _S502;
    (&_S503)->value1_4 = false;
    (&_S503)->value2_2 = _S502;
    (&_S503)->value3_2 = false;
    (&_S503)->value4_2 = _S502;
    (&_S503)->value5_1 = false;
    (&_S503)->value6_1 = _S502;
    (&_S503)->value7_1 = false;
    float3  _S504 = make_float3 (0.0f);
    bool _runFlag_5;
    if((_S501.x) == 0.0f)
    {
        _runFlag_5 = true;
    }
    else
    {
        _runFlag_5 = (_S501.y) == 0.0f;
    }
    if(_runFlag_5)
    {
        _runFlag_5 = true;
    }
    else
    {
        _runFlag_5 = (_S501.z) == 0.0f;
    }
    if(_runFlag_5)
    {
        _runFlag_5 = true;
    }
    else
    {
        _runFlag_5 = (_S501.w) == 0.0f;
    }
    float3  normal_2;
    if(_runFlag_5)
    {
        normal_2 = make_float3 (0.0f);
    }
    bool _S505 = !_runFlag_5;
    if(_S505)
    {
        float2  _S506 = float2 {intrins_1.z, intrins_1.w};
        float2  _S507 = float2 {intrins_1.x, intrins_1.y};
        float2  uv_7 = (pix_center_1 + make_float2 (-1.0f, -0.0f) - _S506) / _S507;
        float2  _S508 = _S502;
        bool _S509 = undistort_point_0(uv_7, dist_coeffs_2, int(12), &_S508);
        (&_S503)->value0_22 = _S508;
        (&_S503)->value1_4 = _S509;
        float2  uv_u_5 = _S508;
        bool _S510 = !_S509;
        if(_S510)
        {
            normal_2 = make_float3 (0.0f);
        }
        bool _S511 = !_S510;
        int _S512;
        FixedArray<float3 , 4>  points_2;
        if(_S511)
        {
            float3  _S513 = make_float3 (_S501.x) * s_apply_unproject_raydir_0(uv_u_5, camera_model_2, is_ray_depth_2).value0_19;
            float2  uv_8 = (pix_center_1 + make_float2 (1.0f, -0.0f) - _S506) / _S507;
            float2  _S514 = _S502;
            bool _S515 = undistort_point_0(uv_8, dist_coeffs_2, int(12), &_S514);
            (&_S503)->value2_2 = _S514;
            (&_S503)->value3_2 = _S515;
            float2  uv_u_6 = _S514;
            bool _S516 = !_S515;
            if(_S516)
            {
                normal_2 = make_float3 (0.0f);
            }
            bool _S517 = !_S516;
            if(_S517)
            {
                float3  _S518 = make_float3 (_S501.y) * s_apply_unproject_raydir_0(uv_u_6, camera_model_2, is_ray_depth_2).value0_19;
                _S512 = int(2);
                points_2[int(0)] = _S513;
                points_2[int(1)] = _S518;
                points_2[int(2)] = _S504;
                points_2[int(3)] = _S504;
            }
            else
            {
                _S512 = int(0);
                points_2[int(0)] = _S513;
                points_2[int(1)] = _S504;
                points_2[int(2)] = _S504;
                points_2[int(3)] = _S504;
            }
            if(_S512 != int(2))
            {
                _runFlag_5 = false;
            }
            else
            {
                _runFlag_5 = _S511;
                _S512 = int(0);
            }
            if(_runFlag_5)
            {
                float2  uv_9 = (pix_center_1 + make_float2 (0.0f, -1.0f) - _S506) / _S507;
                float2  _S519 = _S502;
                bool _S520 = undistort_point_0(uv_9, dist_coeffs_2, int(12), &_S519);
                (&_S503)->value4_2 = _S519;
                (&_S503)->value5_1 = _S520;
                float2  uv_u_7 = _S519;
                if(!_S520)
                {
                    float3  _S521 = make_float3 (0.0f);
                    _runFlag_5 = false;
                    _S512 = int(0);
                    normal_2 = _S521;
                }
                if(_runFlag_5)
                {
                    points_2[int(2)] = make_float3 (_S501.z) * s_apply_unproject_raydir_0(uv_u_7, camera_model_2, is_ray_depth_2).value0_19;
                    float2  uv_10 = (pix_center_1 + make_float2 (0.0f, 1.0f) - _S506) / _S507;
                    float2  _S522 = _S502;
                    bool _S523 = undistort_point_0(uv_10, dist_coeffs_2, int(12), &_S522);
                    (&_S503)->value6_1 = _S522;
                    (&_S503)->value7_1 = _S523;
                    float2  uv_u_8 = _S522;
                    bool _S524 = !_S523;
                    if(_S524)
                    {
                        normal_2 = make_float3 (0.0f);
                    }
                    bool _S525 = !_S524;
                    int _S526;
                    if(_S525)
                    {
                        points_2[int(3)] = make_float3 (_S501.w) * s_apply_unproject_raydir_0(uv_u_8, camera_model_2, is_ray_depth_2).value0_19;
                        _S526 = int(2);
                    }
                    else
                    {
                        _S526 = int(0);
                    }
                    if(_S526 != int(2))
                    {
                        _runFlag_5 = false;
                        _S512 = _S526;
                    }
                    if(_runFlag_5)
                    {
                        _S512 = int(1);
                    }
                }
            }
        }
        else
        {
            _S512 = int(0);
            points_2[int(0)] = _S504;
            points_2[int(1)] = _S504;
            points_2[int(2)] = _S504;
            points_2[int(3)] = _S504;
        }
        if(_S512 != int(1))
        {
            _runFlag_5 = false;
        }
        else
        {
            _runFlag_5 = _S505;
        }
        if(_runFlag_5)
        {
            Tuple_9 _S527 = s_apply_cross_0(points_2[int(1)] - points_2[int(0)], - (points_2[int(3)] - points_2[int(2)]));
            float3  _S528 = _S527.value0_13;
            if((s_apply_dot_0(_S528, _S528).value0_14) != 0.0f)
            {
                normal_2 = _S527.value0_13 / make_float3 (s_apply_length_1(_S527.value0_13).value0_7);
            }
            else
            {
                normal_2 = _S527.value0_13;
            }
        }
    }
    Tuple_16 _S529;
    (&_S529)->value0_23 = normal_2;
    (&_S529)->value1_5 = _S503;
    return _S529;
}

struct s_paramCtx_s_bwdCallableCtx_depth_to_normal_0
{
    int value1_6;
    bool value2_3;
    float4  value3_3;
};

struct s_bwdCallableCtx_depth_to_normal_0
{
    s_paramCtx_s_bwdCallableCtx_depth_to_normal_0 value0_24;
    s_minCtx_s_bwdCallableCtx_depth_to_normal_0 value1_7;
};

inline __device__ void Array_dzero_1(FixedArray<float3 , 4>  * _S530)
{
    float3  _S531 = make_float3 (0.0f);
    (*_S530)[int(0)] = _S531;
    (*_S530)[int(1)] = _S531;
    (*_S530)[int(2)] = _S531;
    (*_S530)[int(3)] = _S531;
    return;
}

inline __device__ void Array_dadd_1(FixedArray<float3 , 4>  * a_3, FixedArray<float3 , 4>  * b_3, FixedArray<float3 , 4>  * _S532)
{
    FixedArray<float3 , 4>  result_7;
    result_7[int(0)] = (*a_3)[int(0)] + (*b_3)[int(0)];
    result_7[int(1)] = (*a_3)[int(1)] + (*b_3)[int(1)];
    result_7[int(2)] = (*a_3)[int(2)] + (*b_3)[int(2)];
    result_7[int(3)] = (*a_3)[int(3)] + (*b_3)[int(3)];
    *_S532 = result_7;
    return;
}

inline __device__ void s_bwdProp_depth_to_normal_0(s_bwdCallableCtx_depth_to_normal_0 * _S533, float4  * _S534, float3  _S535)
{
    float3  _S536 = make_float3 (0.0f);
    float4  _S537 = (&_S533->value0_24)->value3_3;
    bool _runFlag_6;
    if(((&_S533->value0_24)->value3_3.x) == 0.0f)
    {
        _runFlag_6 = true;
    }
    else
    {
        _runFlag_6 = (_S537.y) == 0.0f;
    }
    if(_runFlag_6)
    {
        _runFlag_6 = true;
    }
    else
    {
        _runFlag_6 = (_S537.z) == 0.0f;
    }
    if(_runFlag_6)
    {
        _runFlag_6 = true;
    }
    else
    {
        _runFlag_6 = (_S537.w) == 0.0f;
    }
    bool _S538 = !_runFlag_6;
    bool _runFlag_7;
    bool _runFlag_8;
    bool _S539;
    bool _runFlag_9;
    bool _S540;
    bool _S541;
    FixedArray<float3 , 4>  points_3;
    float3  _S542;
    float3  _S543;
    float3  _S544;
    float3  _S545;
    float3  _S546;
    float3  _S547;
    float3  _S548;
    s_bwdCallableCtx_length_0 _S549;
    s_bwdCallableCtx_dot_0 _S550;
    s_bwdCallableCtx_cross_0 _S551;
    if(_S538)
    {
        float2  _S552 = (&_S533->value1_7)->value0_22;
        bool _S553 = !!(&_S533->value1_7)->value1_4;
        int _S554;
        if(_S553)
        {
            bool _S555 = (&_S533->value0_24)->value2_3;
            int _S556 = (&_S533->value0_24)->value1_6;
            Tuple_14 _S557 = s_apply_unproject_raydir_0(_S552, (&_S533->value0_24)->value1_6, (&_S533->value0_24)->value2_3);
            float3  _S558 = make_float3 (*&((&(&_S533->value0_24)->value3_3)->x)) * _S557.value0_19;
            float2  _S559 = (&_S533->value1_7)->value2_2;
            bool _S560 = !!(&_S533->value1_7)->value3_2;
            if(_S560)
            {
                Tuple_14 _S561 = s_apply_unproject_raydir_0(_S559, _S556, _S555);
                float3  _S562 = make_float3 (*&((&(&_S533->value0_24)->value3_3)->y)) * _S561.value0_19;
                _S554 = int(2);
                points_3[int(0)] = _S558;
                points_3[int(1)] = _S562;
                points_3[int(2)] = _S536;
                points_3[int(3)] = _S536;
                _S542 = _S561.value0_19;
            }
            else
            {
                _S554 = int(0);
                points_3[int(0)] = _S558;
                points_3[int(1)] = _S536;
                points_3[int(2)] = _S536;
                points_3[int(3)] = _S536;
                _S542 = _S536;
            }
            if(_S554 != int(2))
            {
                _runFlag_6 = false;
            }
            else
            {
                _runFlag_6 = _S553;
                _S554 = int(0);
            }
            if(_runFlag_6)
            {
                float2  _S563 = (&_S533->value1_7)->value4_2;
                if(!(&_S533->value1_7)->value5_1)
                {
                    _runFlag_7 = false;
                    _S554 = int(0);
                }
                else
                {
                    _runFlag_7 = _runFlag_6;
                }
                if(_runFlag_7)
                {
                    Tuple_14 _S564 = s_apply_unproject_raydir_0(_S563, _S556, _S555);
                    points_3[int(2)] = make_float3 (*&((&(&_S533->value0_24)->value3_3)->z)) * _S564.value0_19;
                    float2  _S565 = (&_S533->value1_7)->value6_1;
                    bool _S566 = !!(&_S533->value1_7)->value7_1;
                    int _S567;
                    if(_S566)
                    {
                        Tuple_14 _S568 = s_apply_unproject_raydir_0(_S565, _S556, _S555);
                        points_3[int(3)] = make_float3 (*&((&(&_S533->value0_24)->value3_3)->w)) * _S568.value0_19;
                        _S567 = int(2);
                        _S543 = _S568.value0_19;
                    }
                    else
                    {
                        _S567 = int(0);
                        _S543 = _S536;
                    }
                    if(_S567 != int(2))
                    {
                        _runFlag_8 = false;
                        _S554 = _S567;
                    }
                    else
                    {
                        _runFlag_8 = _runFlag_7;
                    }
                    if(_runFlag_8)
                    {
                        _S554 = int(1);
                    }
                    _runFlag_8 = _S566;
                    _S544 = _S564.value0_19;
                }
                else
                {
                    _runFlag_8 = false;
                    _S543 = _S536;
                    _S544 = _S536;
                }
            }
            else
            {
                _runFlag_7 = false;
                _runFlag_8 = false;
                _S543 = _S536;
                _S544 = _S536;
            }
            float3  _S569 = _S542;
            _S542 = _S543;
            _S543 = _S544;
            _S539 = _S560;
            _S544 = _S569;
            _S545 = _S557.value0_19;
        }
        else
        {
            _S554 = int(0);
            points_3[int(0)] = _S536;
            points_3[int(1)] = _S536;
            points_3[int(2)] = _S536;
            points_3[int(3)] = _S536;
            _runFlag_6 = false;
            _runFlag_7 = false;
            _runFlag_8 = false;
            _S542 = _S536;
            _S543 = _S536;
            _S539 = false;
            _S544 = _S536;
            _S545 = _S536;
        }
        if(_S554 != int(1))
        {
            _runFlag_9 = false;
        }
        else
        {
            _runFlag_9 = _S538;
        }
        if(_runFlag_9)
        {
            float3  dx_1 = points_3[int(1)] - points_3[int(0)];
            float3  _S570 = - (points_3[int(3)] - points_3[int(2)]);
            Tuple_9 _S571 = s_apply_cross_0(dx_1, _S570);
            s_bwdCallableCtx_cross_0 _S572;
            (&_S572)->_S68 = dx_1;
            (&_S572)->_S69 = _S570;
            s_bwdCallableCtx_cross_0 _S573 = _S572;
            Tuple_10 _S574 = s_apply_dot_0(_S571.value0_13, _S571.value0_13);
            s_bwdCallableCtx_dot_0 _S575;
            (&_S575)->_S81 = _S571.value0_13;
            (&_S575)->_S82 = _S571.value0_13;
            s_bwdCallableCtx_dot_0 _S576 = _S575;
            bool _S577 = (_S574.value0_14) != 0.0f;
            if(_S577)
            {
                Tuple_5 _S578 = s_apply_length_1(_S571.value0_13);
                float3  _S579 = make_float3 (_S578.value0_7);
                s_bwdCallableCtx_length_0 _S580;
                (&_S580)->_S11 = _S571.value0_13;
                _S546 = make_float3 (_S578.value0_7 * _S578.value0_7);
                _S547 = _S579;
                _S549 = _S580;
            }
            else
            {
                _S546 = _S536;
                _S547 = _S536;
                (&_S549)->_S11 = _S536;
            }
            float3  _S581 = _S547;
            _S540 = _S577;
            _S547 = _S571.value0_13;
            _S548 = _S581;
            _S550 = _S576;
            _S551 = _S573;
        }
        else
        {
            _S540 = false;
            _S546 = _S536;
            _S547 = _S536;
            _S548 = _S536;
            (&_S549)->_S11 = _S536;
            (&_S550)->_S81 = _S536;
            (&_S550)->_S82 = _S536;
            (&_S551)->_S68 = _S536;
            (&_S551)->_S69 = _S536;
        }
        bool _S582 = _runFlag_6;
        bool _S583 = _runFlag_7;
        bool _S584 = _runFlag_8;
        float3  _S585 = _S542;
        float3  _S586 = _S543;
        bool _S587 = _S539;
        float3  _S588 = _S544;
        float3  _S589 = _S545;
        _runFlag_6 = _runFlag_9;
        _runFlag_7 = _S540;
        _S542 = _S546;
        _S543 = _S547;
        _S544 = _S548;
        _runFlag_8 = _S553;
        _S539 = _S582;
        _runFlag_9 = _S583;
        _S540 = _S584;
        _S545 = _S585;
        _S546 = _S586;
        _S541 = _S587;
        _S547 = _S588;
        _S548 = _S589;
    }
    else
    {
        _runFlag_6 = false;
        _runFlag_7 = false;
        _S542 = _S536;
        _S543 = _S536;
        _S544 = _S536;
        (&_S549)->_S11 = _S536;
        (&_S550)->_S81 = _S536;
        (&_S550)->_S82 = _S536;
        (&_S551)->_S68 = _S536;
        (&_S551)->_S69 = _S536;
        _runFlag_8 = false;
        _S539 = false;
        _runFlag_9 = false;
        _S540 = false;
        _S545 = _S536;
        _S546 = _S536;
        _S541 = false;
        _S547 = _S536;
        _S548 = _S536;
    }
    FixedArray<float3 , 4>  _S590;
    Array_dzero_1(&_S590);
    FixedArray<float3 , 4>  _S591 = _S590;
    float4  _S592 = make_float4 (0.0f);
    float4  _S593;
    if(_S538)
    {
        if(_runFlag_6)
        {
            if(_runFlag_7)
            {
                float3  _S594 = _S535 / _S542;
                float3  _S595 = _S543 * - _S594;
                float3  _S596 = _S544 * _S594;
                float _S597 = _S595.x + _S595.y + _S595.z;
                float3  _S598 = _S536;
                s_bwdCallableCtx_length_0 _S599 = _S549;
                s_bwdProp_length_0(&_S599, &_S598, _S597);
                _S542 = _S596 + _S598;
            }
            else
            {
                _S542 = _S535;
            }
            float3  _S600 = _S536;
            float3  _S601 = _S536;
            s_bwdCallableCtx_dot_0 _S602 = _S550;
            s_bwdProp_dot_0(&_S602, &_S600, &_S601, 0.0f);
            float3  _S603 = _S600 + _S601 + _S542;
            float3  _S604 = _S536;
            float3  _S605 = _S536;
            s_bwdCallableCtx_cross_0 _S606 = _S551;
            s_bwdProp_cross_0(&_S606, &_S604, &_S605, _S603);
            float3  s_diff_dy_T_1 = - _S605;
            float3  _S607 = - s_diff_dy_T_1;
            float3  _S608 = - _S604;
            FixedArray<float3 , 4>  _S609 = _S591;
            _S609[int(2)] = _S607;
            _S609[int(3)] = s_diff_dy_T_1;
            _S609[int(0)] = _S608;
            _S609[int(1)] = _S604;
            FixedArray<float3 , 4>  _S610 = _S591;
            FixedArray<float3 , 4>  _S611 = _S609;
            FixedArray<float3 , 4>  _S612;
            Array_dadd_1(&_S610, &_S611, &_S612);
            points_3 = _S612;
        }
        else
        {
            points_3 = _S591;
        }
        if(_runFlag_8)
        {
            if(_S539)
            {
                if(_runFlag_9)
                {
                    FixedArray<float3 , 4>  _S613 = points_3;
                    FixedArray<float3 , 4>  _S614 = _S591;
                    FixedArray<float3 , 4>  _S615;
                    Array_dadd_1(&_S613, &_S614, &_S615);
                    FixedArray<float3 , 4>  _S616 = _S615;
                    if(_S540)
                    {
                        points_3 = _S616;
                        points_3[int(3)] = _S536;
                        float3  _S617 = _S545 * _S616[int(3)];
                        float _S618 = _S617.x + _S617.y + _S617.z;
                        FixedArray<float3 , 4>  _S619 = points_3;
                        FixedArray<float3 , 4>  _S620 = _S591;
                        FixedArray<float3 , 4>  _S621;
                        Array_dadd_1(&_S619, &_S620, &_S621);
                        float4  _S622 = _S592;
                        *&((&_S622)->w) = _S618;
                        points_3 = _S621;
                        _S593 = _S622;
                    }
                    else
                    {
                        FixedArray<float3 , 4>  _S623 = _S616;
                        FixedArray<float3 , 4>  _S624 = _S591;
                        FixedArray<float3 , 4>  _S625;
                        Array_dadd_1(&_S623, &_S624, &_S625);
                        points_3 = _S625;
                        _S593 = _S592;
                    }
                    FixedArray<float3 , 4>  _S626 = points_3;
                    points_3[int(2)] = _S536;
                    float3  _S627 = _S546 * _S626[int(2)];
                    float _S628 = _S627.x + _S627.y + _S627.z;
                    FixedArray<float3 , 4>  _S629 = points_3;
                    FixedArray<float3 , 4>  _S630 = _S591;
                    FixedArray<float3 , 4>  _S631;
                    Array_dadd_1(&_S629, &_S630, &_S631);
                    float4  _S632 = _S592;
                    *&((&_S632)->z) = _S628;
                    float4  _S633 = _S593 + _S632;
                    points_3 = _S631;
                    _S593 = _S633;
                }
                else
                {
                    FixedArray<float3 , 4>  _S634 = points_3;
                    FixedArray<float3 , 4>  _S635 = _S591;
                    FixedArray<float3 , 4>  _S636;
                    Array_dadd_1(&_S634, &_S635, &_S636);
                    points_3 = _S636;
                    _S593 = _S592;
                }
            }
            else
            {
                FixedArray<float3 , 4>  _S637 = points_3;
                FixedArray<float3 , 4>  _S638 = _S591;
                FixedArray<float3 , 4>  _S639;
                Array_dadd_1(&_S637, &_S638, &_S639);
                points_3 = _S639;
                _S593 = _S592;
            }
            if(_S541)
            {
                FixedArray<float3 , 4>  _S640 = points_3;
                float3  _S641 = _S547 * points_3[int(1)];
                float _S642 = _S641.x + _S641.y + _S641.z;
                float4  _S643 = _S592;
                *&((&_S643)->y) = _S642;
                float4  _S644 = _S593 + _S643;
                points_3 = _S591;
                _S542 = _S640[int(0)];
                _S593 = _S644;
            }
            else
            {
                FixedArray<float3 , 4>  _S645 = points_3;
                FixedArray<float3 , 4>  _S646 = _S591;
                FixedArray<float3 , 4>  _S647;
                Array_dadd_1(&_S645, &_S646, &_S647);
                points_3 = _S647;
                _S542 = _S536;
            }
            float3  _S648 = _S548 * (points_3[int(0)] + _S542);
            float _S649 = _S648.x + _S648.y + _S648.z;
            float4  _S650 = _S592;
            *&((&_S650)->x) = _S649;
            _S593 = _S593 + _S650;
        }
        else
        {
            _S593 = _S592;
        }
    }
    else
    {
        _S593 = _S592;
    }
    *_S534 = _S593;
    return;
}

inline __device__ void _S651(float2  _S652, float4  _S653, FixedArray<float, 58>  * _S654, int _S655, bool _S656, DiffPair_vectorx3Cfloatx2C4x3E_0 * _S657, float3  _S658)
{
    float4  _S659 = _S657->primal_0;
    Tuple_16 _S660 = s_apply_depth_to_normal_0(_S652, _S653, _S654, _S655, _S656, _S657->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_to_normal_0 _S661;
    (&_S661)->value1_6 = _S655;
    (&_S661)->value2_3 = _S656;
    (&_S661)->value3_3 = _S659;
    s_bwdCallableCtx_depth_to_normal_0 _S662;
    (&_S662)->value0_24 = _S661;
    (&_S662)->value1_7 = _S660.value1_5;
    s_bwdProp_depth_to_normal_0(&_S662, &_S657->differential_0, _S658);
    return;
}

struct s_minCtx_s_bwdCallableCtx_depth_to_point_0
{
    bool value0_25;
    float2  value1_8;
};

struct Tuple_17
{
    float3  value0_26;
    s_minCtx_s_bwdCallableCtx_depth_to_point_0 value1_9;
};

inline __device__ Tuple_17 s_apply_depth_to_point_0(float2  pix_pos_0, float4  intrins_2, FixedArray<float, 58>  * dist_coeffs_3, int camera_model_3, bool is_ray_depth_3, float _S663)
{
    float2  _S664 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_to_point_0 _S665;
    (&_S665)->value0_25 = false;
    (&_S665)->value1_8 = _S664;
    float2  uv_11 = (pix_pos_0 - float2 {intrins_2.z, intrins_2.w}) / float2 {intrins_2.x, intrins_2.y};
    float2  _S666 = _S664;
    bool _S667 = undistort_point_0(uv_11, dist_coeffs_3, int(12), &_S666);
    (&_S665)->value0_25 = _S667;
    float2  uv_u_9 = _S666;
    (&_S665)->value1_8 = _S666;
    bool _S668 = !_S667;
    float3  _S669;
    if(_S668)
    {
        _S669 = make_float3 (0.0f);
    }
    bool _S670 = !_S668;
    if(_S670)
    {
        _S669 = make_float3 (_S663) * s_apply_unproject_raydir_0(uv_u_9, camera_model_3, is_ray_depth_3).value0_19;
    }
    Tuple_17 _S671;
    (&_S671)->value0_26 = _S669;
    (&_S671)->value1_9 = _S665;
    return _S671;
}

struct s_paramCtx_s_bwdCallableCtx_depth_to_point_0
{
    int value0_27;
    bool value1_10;
};

struct s_bwdCallableCtx_depth_to_point_0
{
    s_paramCtx_s_bwdCallableCtx_depth_to_point_0 value0_28;
    s_minCtx_s_bwdCallableCtx_depth_to_point_0 value1_11;
};

inline __device__ void s_bwdProp_depth_to_point_0(s_bwdCallableCtx_depth_to_point_0 * _S672, float * _S673, float3  _S674)
{
    float3  _S675 = make_float3 (0.0f);
    bool _S676 = !!(&_S672->value1_11)->value0_25;
    float3  _S677;
    if(_S676)
    {
        _S677 = s_apply_unproject_raydir_0((&_S672->value1_11)->value1_8, (&_S672->value0_28)->value0_27, (&_S672->value0_28)->value1_10).value0_19;
    }
    else
    {
        _S677 = _S675;
    }
    if(_S676)
    {
        _S677 = _S677 * _S674;
    }
    else
    {
        _S677 = _S675;
    }
    *_S673 = _S677.x + _S677.y + _S677.z;
    return;
}

inline __device__ void _S678(float2  _S679, float4  _S680, FixedArray<float, 58>  * _S681, int _S682, bool _S683, DiffPair_float_0 * _S684, float3  _S685)
{
    Tuple_17 _S686 = s_apply_depth_to_point_0(_S679, _S680, _S681, _S682, _S683, _S684->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_to_point_0 _S687;
    (&_S687)->value0_27 = _S682;
    (&_S687)->value1_10 = _S683;
    s_bwdCallableCtx_depth_to_point_0 _S688;
    (&_S688)->value0_28 = _S687;
    (&_S688)->value1_11 = _S686.value1_9;
    s_bwdProp_depth_to_point_0(&_S688, &_S684->differential_0, _S685);
    return;
}

inline __device__ float2  DistThinPrism_distort_0(float2  uv_12, FixedArray<float, 8>  * coeffs_2)
{
    float u_0 = uv_12.x;
    float v_0 = uv_12.y;
    float r2_1 = u_0 * u_0 + v_0 * v_0;
    return uv_12 * make_float2 (1.0f + r2_1 * ((*coeffs_2)[int(0)] + r2_1 * ((*coeffs_2)[int(1)] + r2_1 * ((*coeffs_2)[int(2)] + r2_1 * (*coeffs_2)[int(3)])))) + make_float2 (2.0f * (*coeffs_2)[int(4)] * u_0 * v_0 + (*coeffs_2)[int(5)] * (r2_1 + 2.0f * u_0 * u_0) + (*coeffs_2)[int(6)] * r2_1, 2.0f * (*coeffs_2)[int(5)] * u_0 * v_0 + (*coeffs_2)[int(4)] * (r2_1 + 2.0f * v_0 * v_0) + (*coeffs_2)[int(7)] * r2_1);
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistThinPrism_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_1, FixedArray<float, 8>  * coeffs_3)
{
    float u_1 = dpuv_1->primal_0.x;
    float s_diff_u_0 = dpuv_1->differential_0.x;
    float v_1 = dpuv_1->primal_0.y;
    float s_diff_v_0 = dpuv_1->differential_0.y;
    float _S689 = s_diff_u_0 * u_1;
    float _S690 = s_diff_v_0 * v_1;
    float r2_2 = u_1 * u_1 + v_1 * v_1;
    float s_diff_r2_0 = _S689 + _S689 + (_S690 + _S690);
    float _S691 = (*coeffs_3)[int(2)] + r2_2 * (*coeffs_3)[int(3)];
    float _S692 = (*coeffs_3)[int(1)] + r2_2 * _S691;
    float _S693 = (*coeffs_3)[int(0)] + r2_2 * _S692;
    float radial_1 = 1.0f + r2_2 * _S693;
    float _S694 = 2.0f * (*coeffs_3)[int(4)];
    float _S695 = _S694 * u_1;
    float _S696 = 2.0f * u_1;
    float _S697 = 2.0f * (*coeffs_3)[int(5)];
    float _S698 = _S697 * u_1;
    float _S699 = 2.0f * v_1;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S700 = { dpuv_1->primal_0 * make_float2 (radial_1) + make_float2 (_S695 * v_1 + (*coeffs_3)[int(5)] * (r2_2 + _S696 * u_1) + (*coeffs_3)[int(6)] * r2_2, _S698 * v_1 + (*coeffs_3)[int(4)] * (r2_2 + _S699 * v_1) + (*coeffs_3)[int(7)] * r2_2), dpuv_1->differential_0 * make_float2 (radial_1) + make_float2 (s_diff_r2_0 * _S693 + (s_diff_r2_0 * _S692 + (s_diff_r2_0 * _S691 + s_diff_r2_0 * (*coeffs_3)[int(3)] * r2_2) * r2_2) * r2_2) * dpuv_1->primal_0 + make_float2 (s_diff_u_0 * _S694 * v_1 + s_diff_v_0 * _S695 + (s_diff_r2_0 + (s_diff_u_0 * 2.0f * u_1 + s_diff_u_0 * _S696)) * (*coeffs_3)[int(5)] + s_diff_r2_0 * (*coeffs_3)[int(6)], s_diff_u_0 * _S697 * v_1 + s_diff_v_0 * _S698 + (s_diff_r2_0 + (s_diff_v_0 * 2.0f * v_1 + s_diff_v_0 * _S699)) * (*coeffs_3)[int(4)] + s_diff_r2_0 * (*coeffs_3)[int(7)]) };
    return _S700;
}

inline __device__ bool undistort_point_1(float2  uv_13, FixedArray<float, 8>  * dist_coeffs_4, int maxiter_1, float2  * uv_undist_1)
{
    int i_4 = int(0);
    float2  q_2 = uv_13;
    for(;;)
    {
        if(i_4 < maxiter_1)
        {
        }
        else
        {
            break;
        }
        float2  _S701 = DistThinPrism_distort_0(q_2, dist_coeffs_4);
        float2  r_2 = _S701 - uv_13;
        float2  _S702 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S703;
        (&_S703)->primal_0 = q_2;
        (&_S703)->differential_0 = _S702;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S704 = s_fwd_DistThinPrism_distort_0(&_S703, dist_coeffs_4);
        float2  _S705 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S706;
        (&_S706)->primal_0 = q_2;
        (&_S706)->differential_0 = _S705;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S707 = s_fwd_DistThinPrism_distort_0(&_S706, dist_coeffs_4);
        Matrix<float, 2, 2>  _S708 = transpose_0(makeMatrix<float, 2, 2> (_S704.differential_0, _S707.differential_0));
        float inv_det_1 = 1.0f / (_S708.rows[int(0)].x * _S708.rows[int(1)].y - _S708.rows[int(0)].y * _S708.rows[int(1)].x);
        float _S709 = r_2.x;
        float _S710 = r_2.y;
        float2  q_3 = q_2 - make_float2 ((_S709 * _S708.rows[int(1)].y - _S710 * _S708.rows[int(0)].y) * inv_det_1, (- _S709 * _S708.rows[int(1)].x + _S710 * _S708.rows[int(0)].x) * inv_det_1);
        i_4 = i_4 + int(1);
        q_2 = q_3;
    }
    *uv_undist_1 = q_2;
    float2  _S711 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S712;
    (&_S712)->primal_0 = q_2;
    (&_S712)->differential_0 = _S711;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S713 = s_fwd_DistThinPrism_distort_0(&_S712, dist_coeffs_4);
    float2  _S714 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S715;
    (&_S715)->primal_0 = q_2;
    (&_S715)->differential_0 = _S714;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S716 = s_fwd_DistThinPrism_distort_0(&_S715, dist_coeffs_4);
    Matrix<float, 2, 2>  _S717 = transpose_0(makeMatrix<float, 2, 2> (_S713.differential_0, _S716.differential_0));
    float _S718 = (F32_min((determinant_0(_S717)), ((F32_min((_S717.rows[int(0)].x), (_S717.rows[int(1)].y))))));
    bool _S719;
    if(_S718 > 0.25f)
    {
        _S719 = _S718 < 4.0f;
    }
    else
    {
        _S719 = false;
    }
    if(_S719)
    {
        float2  _S720 = DistThinPrism_distort_0(q_2, dist_coeffs_4);
        _S719 = (dot_0(q_2, _S720)) >= 0.0f;
    }
    else
    {
        _S719 = false;
    }
    if(_S719)
    {
        float2  _S721 = DistThinPrism_distort_0(*uv_undist_1, dist_coeffs_4);
        _S719 = (length_0(_S721 - uv_13)) < 0.00999999977648258f;
    }
    else
    {
        _S719 = false;
    }
    return _S719;
}

inline __device__ Tuple_13 s_apply_depth_normal_loss_1(float2  pix_center_2, float4  intrins_3, FixedArray<float, 8>  * dist_coeffs_5, int camera_model_4, bool is_ray_depth_4, float4  _S722, float3  _S723)
{
    float2  _S724 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_normal_loss_0 _S725;
    (&_S725)->value0_17 = false;
    (&_S725)->value1_0 = _S724;
    (&_S725)->value2_0 = _S724;
    (&_S725)->value3_0 = false;
    (&_S725)->value4_0 = _S724;
    (&_S725)->value5_0 = false;
    (&_S725)->value6_0 = _S724;
    (&_S725)->value7_0 = false;
    (&_S725)->value8_0 = _S724;
    (&_S725)->value9_0 = false;
    float3  _S726 = make_float3 (0.0f);
    float2  _S727 = float2 {intrins_3.z, intrins_3.w};
    float2  _S728 = float2 {intrins_3.x, intrins_3.y};
    float2  uv_14 = (pix_center_2 + make_float2 (-1.0f, -0.0f) - _S727) / _S728;
    float2  _S729 = _S724;
    bool _S730 = undistort_point_1(uv_14, dist_coeffs_5, int(12), &_S729);
    (&_S725)->value0_17 = _S730;
    float2  uv_u_10 = _S729;
    (&_S725)->value1_0 = _S729;
    bool _S731 = !!_S730;
    int _S732;
    float3  raydir_3;
    FixedArray<float3 , 5>  points_4;
    if(_S731)
    {
        Tuple_14 _S733 = s_apply_unproject_raydir_0(uv_u_10, camera_model_4, is_ray_depth_4);
        float3  _S734 = make_float3 (_S722.x) * _S733.value0_19;
        float2  uv_15 = (pix_center_2 + make_float2 (1.0f, -0.0f) - _S727) / _S728;
        float2  _S735 = _S724;
        bool _S736 = undistort_point_1(uv_15, dist_coeffs_5, int(12), &_S735);
        (&_S725)->value2_0 = _S735;
        (&_S725)->value3_0 = _S736;
        float2  uv_u_11 = _S735;
        bool _runFlag_10;
        if(!_S736)
        {
            _runFlag_10 = false;
        }
        else
        {
            _runFlag_10 = _S731;
        }
        if(_runFlag_10)
        {
            Tuple_14 _S737 = s_apply_unproject_raydir_0(uv_u_11, camera_model_4, is_ray_depth_4);
            float3  _S738 = make_float3 (_S722.y) * _S737.value0_19;
            float2  uv_16 = (pix_center_2 + make_float2 (0.0f, -1.0f) - _S727) / _S728;
            float2  _S739 = _S724;
            bool _S740 = undistort_point_1(uv_16, dist_coeffs_5, int(12), &_S739);
            (&_S725)->value4_0 = _S739;
            (&_S725)->value5_0 = _S740;
            float2  uv_u_12 = _S739;
            if(!_S740)
            {
                _runFlag_10 = false;
            }
            if(_runFlag_10)
            {
                Tuple_14 _S741 = s_apply_unproject_raydir_0(uv_u_12, camera_model_4, is_ray_depth_4);
                float3  _S742 = make_float3 (_S722.z) * _S741.value0_19;
                float2  uv_17 = (pix_center_2 + make_float2 (0.0f, 1.0f) - _S727) / _S728;
                float2  _S743 = _S724;
                bool _S744 = undistort_point_1(uv_17, dist_coeffs_5, int(12), &_S743);
                (&_S725)->value6_0 = _S743;
                (&_S725)->value7_0 = _S744;
                float2  uv_u_13 = _S743;
                if(!_S744)
                {
                    _runFlag_10 = false;
                }
                if(_runFlag_10)
                {
                    Tuple_14 _S745 = s_apply_unproject_raydir_0(uv_u_13, camera_model_4, is_ray_depth_4);
                    float3  _S746 = make_float3 (_S722.w) * _S745.value0_19;
                    float2  uv_18 = (pix_center_2 - _S727) / _S728;
                    float2  _S747 = _S724;
                    bool _S748 = undistort_point_1(uv_18, dist_coeffs_5, int(12), &_S747);
                    (&_S725)->value8_0 = _S747;
                    (&_S725)->value9_0 = _S748;
                    float2  uv_u_14 = _S747;
                    if(!_S748)
                    {
                        _runFlag_10 = false;
                    }
                    if(_runFlag_10)
                    {
                        Tuple_14 _S749 = s_apply_unproject_raydir_0(uv_u_14, camera_model_4, is_ray_depth_4);
                        _S732 = int(1);
                        raydir_3 = _S749.value0_19;
                    }
                    else
                    {
                        _S732 = int(0);
                        raydir_3 = _S745.value0_19;
                    }
                    points_4[int(0)] = _S734;
                    points_4[int(1)] = _S738;
                    points_4[int(2)] = _S742;
                    points_4[int(3)] = _S746;
                    points_4[int(4)] = _S726;
                }
                else
                {
                    _S732 = int(0);
                    raydir_3 = _S741.value0_19;
                    points_4[int(0)] = _S734;
                    points_4[int(1)] = _S738;
                    points_4[int(2)] = _S742;
                    points_4[int(3)] = _S726;
                    points_4[int(4)] = _S726;
                }
            }
            else
            {
                _S732 = int(0);
                raydir_3 = _S737.value0_19;
                points_4[int(0)] = _S734;
                points_4[int(1)] = _S738;
                points_4[int(2)] = _S726;
                points_4[int(3)] = _S726;
                points_4[int(4)] = _S726;
            }
        }
        else
        {
            _S732 = int(0);
            raydir_3 = _S733.value0_19;
            points_4[int(0)] = _S734;
            points_4[int(1)] = _S726;
            points_4[int(2)] = _S726;
            points_4[int(3)] = _S726;
            points_4[int(4)] = _S726;
        }
    }
    else
    {
        _S732 = int(0);
        points_4[int(0)] = _S726;
        points_4[int(1)] = _S726;
        points_4[int(2)] = _S726;
        points_4[int(3)] = _S726;
        points_4[int(4)] = _S726;
    }
    float _S750;
    if(!(_S732 != int(1)))
    {
        Tuple_9 _S751 = s_apply_cross_0(points_4[int(1)] - points_4[int(0)], - (points_4[int(3)] - points_4[int(2)]));
        float3  _S752 = _S751.value0_13;
        float3  normal_3;
        if((s_apply_dot_0(_S752, _S752).value0_14) != 0.0f)
        {
            normal_3 = s_apply_normalize_0(_S751.value0_13).value0_4;
        }
        else
        {
            normal_3 = _S751.value0_13;
        }
        float3  _S753;
        if((s_apply_dot_0(_S723, _S723).value0_14) != 0.0f)
        {
            _S753 = s_apply_normalize_0(_S723).value0_4;
        }
        else
        {
            _S753 = _S723;
        }
        _S750 = (1.0f - s_apply_dot_0(normal_3, _S753).value0_14 + 0.00100000004749745f) / (s_apply_max_0(s_apply_dot_0(normal_3, - s_apply_normalize_0(raydir_3).value0_4).value0_14, 0.0f).value0_16 + 0.00100000004749745f);
    }
    else
    {
        _S750 = 0.0f;
    }
    Tuple_13 _S754;
    (&_S754)->value0_18 = _S750;
    (&_S754)->value1_1 = _S725;
    return _S754;
}

inline __device__ void s_bwdProp_depth_normal_loss_1(s_bwdCallableCtx_depth_normal_loss_0 * _S755, float4  * _S756, float3  * _S757, float _S758)
{
    float3  _S759 = make_float3 (0.0f);
    bool _S760 = !!(&_S755->value1_3)->value0_17;
    bool _runFlag_11;
    bool _runFlag_12;
    bool _runFlag_13;
    bool _runFlag_14;
    int _S761;
    float3  raydir_4;
    float3  _S762;
    float3  _S763;
    float3  _S764;
    float3  _S765;
    FixedArray<float3 , 5>  points_5;
    if(_S760)
    {
        bool _S766 = (&_S755->value0_21)->value2_1;
        int _S767 = (&_S755->value0_21)->value1_2;
        Tuple_14 _S768 = s_apply_unproject_raydir_0((&_S755->value1_3)->value1_0, (&_S755->value0_21)->value1_2, (&_S755->value0_21)->value2_1);
        float3  _S769 = make_float3 (*&((&(&_S755->value0_21)->value3_1)->x)) * _S768.value0_19;
        float2  _S770 = (&_S755->value1_3)->value2_0;
        if(!(&_S755->value1_3)->value3_0)
        {
            _runFlag_11 = false;
        }
        else
        {
            _runFlag_11 = _S760;
        }
        if(_runFlag_11)
        {
            Tuple_14 _S771 = s_apply_unproject_raydir_0(_S770, _S767, _S766);
            float3  _S772 = make_float3 (*&((&(&_S755->value0_21)->value3_1)->y)) * _S771.value0_19;
            float2  _S773 = (&_S755->value1_3)->value4_0;
            if(!(&_S755->value1_3)->value5_0)
            {
                _runFlag_12 = false;
            }
            else
            {
                _runFlag_12 = _runFlag_11;
            }
            if(_runFlag_12)
            {
                Tuple_14 _S774 = s_apply_unproject_raydir_0(_S773, _S767, _S766);
                float3  _S775 = make_float3 (*&((&(&_S755->value0_21)->value3_1)->z)) * _S774.value0_19;
                float2  _S776 = (&_S755->value1_3)->value6_0;
                if(!(&_S755->value1_3)->value7_0)
                {
                    _runFlag_13 = false;
                }
                else
                {
                    _runFlag_13 = _runFlag_12;
                }
                if(_runFlag_13)
                {
                    Tuple_14 _S777 = s_apply_unproject_raydir_0(_S776, _S767, _S766);
                    float3  _S778 = make_float3 (*&((&(&_S755->value0_21)->value3_1)->w)) * _S777.value0_19;
                    float2  _S779 = (&_S755->value1_3)->value8_0;
                    if(!(&_S755->value1_3)->value9_0)
                    {
                        _runFlag_14 = false;
                    }
                    else
                    {
                        _runFlag_14 = _runFlag_13;
                    }
                    if(_runFlag_14)
                    {
                        Tuple_14 _S780 = s_apply_unproject_raydir_0(_S779, _S767, _S766);
                        _S761 = int(1);
                        raydir_4 = _S780.value0_19;
                    }
                    else
                    {
                        _S761 = int(0);
                        raydir_4 = _S777.value0_19;
                    }
                    points_5[int(0)] = _S769;
                    points_5[int(1)] = _S772;
                    points_5[int(2)] = _S775;
                    points_5[int(3)] = _S778;
                    points_5[int(4)] = _S759;
                    _S762 = _S777.value0_19;
                }
                else
                {
                    _S761 = int(0);
                    raydir_4 = _S774.value0_19;
                    points_5[int(0)] = _S769;
                    points_5[int(1)] = _S772;
                    points_5[int(2)] = _S775;
                    points_5[int(3)] = _S759;
                    points_5[int(4)] = _S759;
                    _S762 = _S759;
                }
                _S763 = _S774.value0_19;
            }
            else
            {
                _S761 = int(0);
                raydir_4 = _S771.value0_19;
                points_5[int(0)] = _S769;
                points_5[int(1)] = _S772;
                points_5[int(2)] = _S759;
                points_5[int(3)] = _S759;
                points_5[int(4)] = _S759;
                _runFlag_13 = false;
                _S762 = _S759;
                _S763 = _S759;
            }
            _S764 = _S771.value0_19;
        }
        else
        {
            _S761 = int(0);
            raydir_4 = _S768.value0_19;
            points_5[int(0)] = _S769;
            points_5[int(1)] = _S759;
            points_5[int(2)] = _S759;
            points_5[int(3)] = _S759;
            points_5[int(4)] = _S759;
            _runFlag_12 = false;
            _runFlag_13 = false;
            _S762 = _S759;
            _S763 = _S759;
            _S764 = _S759;
        }
        _S765 = _S768.value0_19;
    }
    else
    {
        _S761 = int(0);
        points_5[int(0)] = _S759;
        points_5[int(1)] = _S759;
        points_5[int(2)] = _S759;
        points_5[int(3)] = _S759;
        points_5[int(4)] = _S759;
        _runFlag_11 = false;
        _runFlag_12 = false;
        _runFlag_13 = false;
        _S762 = _S759;
        _S763 = _S759;
        _S764 = _S759;
        _S765 = _S759;
    }
    bool _S781 = !(_S761 != int(1));
    bool _S782;
    float3  normal_4;
    float3  _S783;
    s_bwdCallableCtx_normalize_0 _S784;
    s_bwdCallableCtx_normalize_0 _S785;
    float _S786;
    float _S787;
    float _S788;
    s_bwdCallableCtx_max_0 _S789;
    s_bwdCallableCtx_dot_0 _S790;
    s_bwdCallableCtx_dot_0 _S791;
    s_bwdCallableCtx_dot_0 _S792;
    s_bwdCallableCtx_dot_0 _S793;
    s_bwdCallableCtx_cross_0 _S794;
    if(_S781)
    {
        float3  dx_2 = points_5[int(1)] - points_5[int(0)];
        float3  _S795 = - (points_5[int(3)] - points_5[int(2)]);
        Tuple_9 _S796 = s_apply_cross_0(dx_2, _S795);
        s_bwdCallableCtx_cross_0 _S797;
        (&_S797)->_S68 = dx_2;
        (&_S797)->_S69 = _S795;
        s_bwdCallableCtx_cross_0 _S798 = _S797;
        Tuple_10 _S799 = s_apply_dot_0(_S796.value0_13, _S796.value0_13);
        s_bwdCallableCtx_dot_0 _S800;
        (&_S800)->_S81 = _S796.value0_13;
        (&_S800)->_S82 = _S796.value0_13;
        s_bwdCallableCtx_dot_0 _S801 = _S800;
        bool _S802 = (_S799.value0_14) != 0.0f;
        if(_S802)
        {
            Tuple_4 _S803 = s_apply_normalize_0(_S796.value0_13);
            s_bwdCallableCtx_normalize_0 _S804;
            (&_S804)->_S9 = _S796.value0_13;
            normal_4 = _S803.value0_4;
            _S784 = _S804;
        }
        else
        {
            normal_4 = _S796.value0_13;
            (&_S784)->_S9 = _S759;
        }
        float3  _S805 = (&_S755->value0_21)->value4_1;
        Tuple_10 _S806 = s_apply_dot_0((&_S755->value0_21)->value4_1, (&_S755->value0_21)->value4_1);
        s_bwdCallableCtx_dot_0 _S807;
        (&_S807)->_S81 = (&_S755->value0_21)->value4_1;
        (&_S807)->_S82 = (&_S755->value0_21)->value4_1;
        s_bwdCallableCtx_dot_0 _S808 = _S807;
        bool _S809 = (_S806.value0_14) != 0.0f;
        if(_S809)
        {
            Tuple_4 _S810 = s_apply_normalize_0(_S805);
            s_bwdCallableCtx_normalize_0 _S811;
            (&_S811)->_S9 = _S805;
            _S783 = _S810.value0_4;
            _S785 = _S811;
        }
        else
        {
            _S783 = _S805;
            (&_S785)->_S9 = _S759;
        }
        Tuple_10 _S812 = s_apply_dot_0(normal_4, _S783);
        s_bwdCallableCtx_dot_0 _S813;
        (&_S813)->_S81 = normal_4;
        (&_S813)->_S82 = _S783;
        float num_1 = 1.0f - _S812.value0_14;
        float3  _S814 = - s_apply_normalize_0(raydir_4).value0_4;
        Tuple_10 _S815 = s_apply_dot_0(normal_4, _S814);
        s_bwdCallableCtx_dot_0 _S816;
        (&_S816)->_S81 = normal_4;
        (&_S816)->_S82 = _S814;
        float _S817 = num_1 + 0.00100000004749745f;
        Tuple_12 _S818 = s_apply_max_0(_S815.value0_14, 0.0f);
        s_bwdCallableCtx_max_0 _S819;
        (&_S819)->_S94 = _S815.value0_14;
        (&_S819)->_S95 = 0.0f;
        float _S820 = _S818.value0_16 + 0.00100000004749745f;
        s_bwdCallableCtx_normalize_0 _S821 = _S784;
        _S786 = _S820 * _S820;
        _S787 = _S817;
        _S788 = _S820;
        _S789 = _S819;
        _S790 = _S816;
        _S791 = _S813;
        _runFlag_14 = _S809;
        _S784 = _S785;
        _S792 = _S808;
        _S782 = _S802;
        _S785 = _S821;
        _S793 = _S801;
        _S794 = _S798;
    }
    else
    {
        _S786 = 0.0f;
        _S787 = 0.0f;
        _S788 = 0.0f;
        (&_S789)->_S94 = 0.0f;
        (&_S789)->_S95 = 0.0f;
        (&_S790)->_S81 = _S759;
        (&_S790)->_S82 = _S759;
        (&_S791)->_S81 = _S759;
        (&_S791)->_S82 = _S759;
        _runFlag_14 = false;
        (&_S784)->_S9 = _S759;
        (&_S792)->_S81 = _S759;
        (&_S792)->_S82 = _S759;
        _S782 = false;
        (&_S785)->_S9 = _S759;
        (&_S793)->_S81 = _S759;
        (&_S793)->_S82 = _S759;
        (&_S794)->_S68 = _S759;
        (&_S794)->_S69 = _S759;
    }
    float4  _S822 = make_float4 (0.0f);
    FixedArray<float3 , 5>  _S823;
    Array_dzero_0(&_S823);
    FixedArray<float3 , 5>  _S824 = _S823;
    if(_S781)
    {
        float _S825 = _S758 / _S786;
        float _S826 = _S787 * - _S825;
        float s_diff_num_T_1 = _S788 * _S825;
        float _S827 = 0.0f;
        float _S828 = 0.0f;
        s_bwdCallableCtx_max_0 _S829 = _S789;
        s_bwdProp_max_0(&_S829, &_S827, &_S828, _S826);
        float3  _S830 = _S759;
        float3  _S831 = _S759;
        s_bwdCallableCtx_dot_0 _S832 = _S790;
        s_bwdProp_dot_0(&_S832, &_S830, &_S831, _S827);
        float _S833 = - s_diff_num_T_1;
        float3  _S834 = _S759;
        float3  _S835 = _S759;
        s_bwdCallableCtx_dot_0 _S836 = _S791;
        s_bwdProp_dot_0(&_S836, &_S834, &_S835, _S833);
        float3  _S837 = _S835;
        float3  _S838 = _S830 + _S834;
        if(_runFlag_14)
        {
            float3  _S839 = _S759;
            s_bwdCallableCtx_normalize_0 _S840 = _S784;
            s_bwdProp_normalize_0(&_S840, &_S839, _S837);
            raydir_4 = _S839;
        }
        else
        {
            raydir_4 = _S837;
        }
        float3  _S841 = _S759;
        float3  _S842 = _S759;
        s_bwdCallableCtx_dot_0 _S843 = _S792;
        s_bwdProp_dot_0(&_S843, &_S841, &_S842, 0.0f);
        float3  _S844 = _S841 + _S842 + raydir_4;
        if(_S782)
        {
            float3  _S845 = _S759;
            s_bwdCallableCtx_normalize_0 _S846 = _S785;
            s_bwdProp_normalize_0(&_S846, &_S845, _S838);
            raydir_4 = _S845;
        }
        else
        {
            raydir_4 = _S838;
        }
        float3  _S847 = _S759;
        float3  _S848 = _S759;
        s_bwdCallableCtx_dot_0 _S849 = _S793;
        s_bwdProp_dot_0(&_S849, &_S847, &_S848, 0.0f);
        float3  _S850 = _S847 + _S848 + raydir_4;
        float3  _S851 = _S759;
        float3  _S852 = _S759;
        s_bwdCallableCtx_cross_0 _S853 = _S794;
        s_bwdProp_cross_0(&_S853, &_S851, &_S852, _S850);
        float3  s_diff_dy_T_2 = - _S852;
        float3  _S854 = - s_diff_dy_T_2;
        float3  _S855 = - _S851;
        FixedArray<float3 , 5>  _S856 = _S824;
        _S856[int(2)] = _S854;
        _S856[int(3)] = s_diff_dy_T_2;
        _S856[int(0)] = _S855;
        _S856[int(1)] = _S851;
        FixedArray<float3 , 5>  _S857 = _S824;
        FixedArray<float3 , 5>  _S858 = _S856;
        FixedArray<float3 , 5>  _S859;
        Array_dadd_0(&_S857, &_S858, &_S859);
        points_5 = _S859;
        raydir_4 = _S844;
    }
    else
    {
        points_5 = _S824;
        raydir_4 = _S759;
    }
    float4  _S860;
    if(_S760)
    {
        if(_runFlag_11)
        {
            if(_runFlag_12)
            {
                if(_runFlag_13)
                {
                    FixedArray<float3 , 5>  _S861 = points_5;
                    FixedArray<float3 , 5>  _S862 = _S824;
                    FixedArray<float3 , 5>  _S863;
                    Array_dadd_0(&_S861, &_S862, &_S863);
                    float3  _S864 = _S762 * _S863[int(3)];
                    float _S865 = _S864.x + _S864.y + _S864.z;
                    float4  _S866 = _S822;
                    *&((&_S866)->w) = _S865;
                    points_5 = _S824;
                    _S762 = _S863[int(2)];
                    normal_4 = _S863[int(0)];
                    _S783 = _S863[int(1)];
                    _S860 = _S866;
                }
                else
                {
                    FixedArray<float3 , 5>  _S867 = points_5;
                    FixedArray<float3 , 5>  _S868 = _S824;
                    FixedArray<float3 , 5>  _S869;
                    Array_dadd_0(&_S867, &_S868, &_S869);
                    points_5 = _S869;
                    _S762 = _S759;
                    normal_4 = _S759;
                    _S783 = _S759;
                    _S860 = _S822;
                }
                float3  _S870 = _S763 * (points_5[int(2)] + _S762);
                float _S871 = _S870.x + _S870.y + _S870.z;
                float3  _S872 = points_5[int(0)] + normal_4;
                float3  _S873 = points_5[int(1)] + _S783;
                float4  _S874 = _S822;
                *&((&_S874)->z) = _S871;
                float4  _S875 = _S860 + _S874;
                points_5 = _S824;
                _S762 = _S873;
                _S763 = _S872;
                _S860 = _S875;
            }
            else
            {
                FixedArray<float3 , 5>  _S876 = points_5;
                FixedArray<float3 , 5>  _S877 = _S824;
                FixedArray<float3 , 5>  _S878;
                Array_dadd_0(&_S876, &_S877, &_S878);
                points_5 = _S878;
                _S762 = _S759;
                _S763 = _S759;
                _S860 = _S822;
            }
            float3  _S879 = _S764 * (points_5[int(1)] + _S762);
            float _S880 = _S879.x + _S879.y + _S879.z;
            float3  _S881 = points_5[int(0)] + _S763;
            float4  _S882 = _S822;
            *&((&_S882)->y) = _S880;
            float4  _S883 = _S860 + _S882;
            points_5 = _S824;
            _S762 = _S881;
            _S860 = _S883;
        }
        else
        {
            FixedArray<float3 , 5>  _S884 = points_5;
            FixedArray<float3 , 5>  _S885 = _S824;
            FixedArray<float3 , 5>  _S886;
            Array_dadd_0(&_S884, &_S885, &_S886);
            points_5 = _S886;
            _S762 = _S759;
            _S860 = _S822;
        }
        float3  _S887 = _S765 * (points_5[int(0)] + _S762);
        float _S888 = _S887.x + _S887.y + _S887.z;
        float4  _S889 = _S822;
        *&((&_S889)->x) = _S888;
        _S860 = _S860 + _S889;
    }
    else
    {
        _S860 = _S822;
    }
    *_S756 = _S860;
    *_S757 = raydir_4;
    return;
}

inline __device__ void _S890(float2  _S891, float4  _S892, FixedArray<float, 8>  * _S893, int _S894, bool _S895, DiffPair_vectorx3Cfloatx2C4x3E_0 * _S896, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S897, float _S898)
{
    float4  _S899 = _S896->primal_0;
    float3  _S900 = _S897->primal_0;
    Tuple_13 _S901 = s_apply_depth_normal_loss_1(_S891, _S892, _S893, _S894, _S895, _S896->primal_0, _S897->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_normal_loss_0 _S902;
    (&_S902)->value1_2 = _S894;
    (&_S902)->value2_1 = _S895;
    (&_S902)->value3_1 = _S899;
    (&_S902)->value4_1 = _S900;
    s_bwdCallableCtx_depth_normal_loss_0 _S903;
    (&_S903)->value0_21 = _S902;
    (&_S903)->value1_3 = _S901.value1_1;
    s_bwdProp_depth_normal_loss_1(&_S903, &_S896->differential_0, &_S897->differential_0, _S898);
    return;
}

inline __device__ Tuple_16 s_apply_depth_to_normal_1(float2  pix_center_3, float4  intrins_4, FixedArray<float, 8>  * dist_coeffs_6, int camera_model_5, bool is_ray_depth_5, float4  _S904)
{
    float2  _S905 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_to_normal_0 _S906;
    (&_S906)->value0_22 = _S905;
    (&_S906)->value1_4 = false;
    (&_S906)->value2_2 = _S905;
    (&_S906)->value3_2 = false;
    (&_S906)->value4_2 = _S905;
    (&_S906)->value5_1 = false;
    (&_S906)->value6_1 = _S905;
    (&_S906)->value7_1 = false;
    float3  _S907 = make_float3 (0.0f);
    bool _runFlag_15;
    if((_S904.x) == 0.0f)
    {
        _runFlag_15 = true;
    }
    else
    {
        _runFlag_15 = (_S904.y) == 0.0f;
    }
    if(_runFlag_15)
    {
        _runFlag_15 = true;
    }
    else
    {
        _runFlag_15 = (_S904.z) == 0.0f;
    }
    if(_runFlag_15)
    {
        _runFlag_15 = true;
    }
    else
    {
        _runFlag_15 = (_S904.w) == 0.0f;
    }
    float3  normal_5;
    if(_runFlag_15)
    {
        normal_5 = make_float3 (0.0f);
    }
    bool _S908 = !_runFlag_15;
    if(_S908)
    {
        float2  _S909 = float2 {intrins_4.z, intrins_4.w};
        float2  _S910 = float2 {intrins_4.x, intrins_4.y};
        float2  uv_19 = (pix_center_3 + make_float2 (-1.0f, -0.0f) - _S909) / _S910;
        float2  _S911 = _S905;
        bool _S912 = undistort_point_1(uv_19, dist_coeffs_6, int(12), &_S911);
        (&_S906)->value0_22 = _S911;
        (&_S906)->value1_4 = _S912;
        float2  uv_u_15 = _S911;
        bool _S913 = !_S912;
        if(_S913)
        {
            normal_5 = make_float3 (0.0f);
        }
        bool _S914 = !_S913;
        int _S915;
        FixedArray<float3 , 4>  points_6;
        if(_S914)
        {
            float3  _S916 = make_float3 (_S904.x) * s_apply_unproject_raydir_0(uv_u_15, camera_model_5, is_ray_depth_5).value0_19;
            float2  uv_20 = (pix_center_3 + make_float2 (1.0f, -0.0f) - _S909) / _S910;
            float2  _S917 = _S905;
            bool _S918 = undistort_point_1(uv_20, dist_coeffs_6, int(12), &_S917);
            (&_S906)->value2_2 = _S917;
            (&_S906)->value3_2 = _S918;
            float2  uv_u_16 = _S917;
            bool _S919 = !_S918;
            if(_S919)
            {
                normal_5 = make_float3 (0.0f);
            }
            bool _S920 = !_S919;
            if(_S920)
            {
                float3  _S921 = make_float3 (_S904.y) * s_apply_unproject_raydir_0(uv_u_16, camera_model_5, is_ray_depth_5).value0_19;
                _S915 = int(2);
                points_6[int(0)] = _S916;
                points_6[int(1)] = _S921;
                points_6[int(2)] = _S907;
                points_6[int(3)] = _S907;
            }
            else
            {
                _S915 = int(0);
                points_6[int(0)] = _S916;
                points_6[int(1)] = _S907;
                points_6[int(2)] = _S907;
                points_6[int(3)] = _S907;
            }
            if(_S915 != int(2))
            {
                _runFlag_15 = false;
            }
            else
            {
                _runFlag_15 = _S914;
                _S915 = int(0);
            }
            if(_runFlag_15)
            {
                float2  uv_21 = (pix_center_3 + make_float2 (0.0f, -1.0f) - _S909) / _S910;
                float2  _S922 = _S905;
                bool _S923 = undistort_point_1(uv_21, dist_coeffs_6, int(12), &_S922);
                (&_S906)->value4_2 = _S922;
                (&_S906)->value5_1 = _S923;
                float2  uv_u_17 = _S922;
                if(!_S923)
                {
                    float3  _S924 = make_float3 (0.0f);
                    _runFlag_15 = false;
                    _S915 = int(0);
                    normal_5 = _S924;
                }
                if(_runFlag_15)
                {
                    points_6[int(2)] = make_float3 (_S904.z) * s_apply_unproject_raydir_0(uv_u_17, camera_model_5, is_ray_depth_5).value0_19;
                    float2  uv_22 = (pix_center_3 + make_float2 (0.0f, 1.0f) - _S909) / _S910;
                    float2  _S925 = _S905;
                    bool _S926 = undistort_point_1(uv_22, dist_coeffs_6, int(12), &_S925);
                    (&_S906)->value6_1 = _S925;
                    (&_S906)->value7_1 = _S926;
                    float2  uv_u_18 = _S925;
                    bool _S927 = !_S926;
                    if(_S927)
                    {
                        normal_5 = make_float3 (0.0f);
                    }
                    bool _S928 = !_S927;
                    int _S929;
                    if(_S928)
                    {
                        points_6[int(3)] = make_float3 (_S904.w) * s_apply_unproject_raydir_0(uv_u_18, camera_model_5, is_ray_depth_5).value0_19;
                        _S929 = int(2);
                    }
                    else
                    {
                        _S929 = int(0);
                    }
                    if(_S929 != int(2))
                    {
                        _runFlag_15 = false;
                        _S915 = _S929;
                    }
                    if(_runFlag_15)
                    {
                        _S915 = int(1);
                    }
                }
            }
        }
        else
        {
            _S915 = int(0);
            points_6[int(0)] = _S907;
            points_6[int(1)] = _S907;
            points_6[int(2)] = _S907;
            points_6[int(3)] = _S907;
        }
        if(_S915 != int(1))
        {
            _runFlag_15 = false;
        }
        else
        {
            _runFlag_15 = _S908;
        }
        if(_runFlag_15)
        {
            Tuple_9 _S930 = s_apply_cross_0(points_6[int(1)] - points_6[int(0)], - (points_6[int(3)] - points_6[int(2)]));
            float3  _S931 = _S930.value0_13;
            if((s_apply_dot_0(_S931, _S931).value0_14) != 0.0f)
            {
                normal_5 = _S930.value0_13 / make_float3 (s_apply_length_1(_S930.value0_13).value0_7);
            }
            else
            {
                normal_5 = _S930.value0_13;
            }
        }
    }
    Tuple_16 _S932;
    (&_S932)->value0_23 = normal_5;
    (&_S932)->value1_5 = _S906;
    return _S932;
}

inline __device__ void s_bwdProp_depth_to_normal_1(s_bwdCallableCtx_depth_to_normal_0 * _S933, float4  * _S934, float3  _S935)
{
    float3  _S936 = make_float3 (0.0f);
    float4  _S937 = (&_S933->value0_24)->value3_3;
    bool _runFlag_16;
    if(((&_S933->value0_24)->value3_3.x) == 0.0f)
    {
        _runFlag_16 = true;
    }
    else
    {
        _runFlag_16 = (_S937.y) == 0.0f;
    }
    if(_runFlag_16)
    {
        _runFlag_16 = true;
    }
    else
    {
        _runFlag_16 = (_S937.z) == 0.0f;
    }
    if(_runFlag_16)
    {
        _runFlag_16 = true;
    }
    else
    {
        _runFlag_16 = (_S937.w) == 0.0f;
    }
    bool _S938 = !_runFlag_16;
    bool _runFlag_17;
    bool _runFlag_18;
    bool _S939;
    bool _runFlag_19;
    bool _S940;
    bool _S941;
    FixedArray<float3 , 4>  points_7;
    float3  _S942;
    float3  _S943;
    float3  _S944;
    float3  _S945;
    float3  _S946;
    float3  _S947;
    float3  _S948;
    s_bwdCallableCtx_length_0 _S949;
    s_bwdCallableCtx_dot_0 _S950;
    s_bwdCallableCtx_cross_0 _S951;
    if(_S938)
    {
        float2  _S952 = (&_S933->value1_7)->value0_22;
        bool _S953 = !!(&_S933->value1_7)->value1_4;
        int _S954;
        if(_S953)
        {
            bool _S955 = (&_S933->value0_24)->value2_3;
            int _S956 = (&_S933->value0_24)->value1_6;
            Tuple_14 _S957 = s_apply_unproject_raydir_0(_S952, (&_S933->value0_24)->value1_6, (&_S933->value0_24)->value2_3);
            float3  _S958 = make_float3 (*&((&(&_S933->value0_24)->value3_3)->x)) * _S957.value0_19;
            float2  _S959 = (&_S933->value1_7)->value2_2;
            bool _S960 = !!(&_S933->value1_7)->value3_2;
            if(_S960)
            {
                Tuple_14 _S961 = s_apply_unproject_raydir_0(_S959, _S956, _S955);
                float3  _S962 = make_float3 (*&((&(&_S933->value0_24)->value3_3)->y)) * _S961.value0_19;
                _S954 = int(2);
                points_7[int(0)] = _S958;
                points_7[int(1)] = _S962;
                points_7[int(2)] = _S936;
                points_7[int(3)] = _S936;
                _S942 = _S961.value0_19;
            }
            else
            {
                _S954 = int(0);
                points_7[int(0)] = _S958;
                points_7[int(1)] = _S936;
                points_7[int(2)] = _S936;
                points_7[int(3)] = _S936;
                _S942 = _S936;
            }
            if(_S954 != int(2))
            {
                _runFlag_16 = false;
            }
            else
            {
                _runFlag_16 = _S953;
                _S954 = int(0);
            }
            if(_runFlag_16)
            {
                float2  _S963 = (&_S933->value1_7)->value4_2;
                if(!(&_S933->value1_7)->value5_1)
                {
                    _runFlag_17 = false;
                    _S954 = int(0);
                }
                else
                {
                    _runFlag_17 = _runFlag_16;
                }
                if(_runFlag_17)
                {
                    Tuple_14 _S964 = s_apply_unproject_raydir_0(_S963, _S956, _S955);
                    points_7[int(2)] = make_float3 (*&((&(&_S933->value0_24)->value3_3)->z)) * _S964.value0_19;
                    float2  _S965 = (&_S933->value1_7)->value6_1;
                    bool _S966 = !!(&_S933->value1_7)->value7_1;
                    int _S967;
                    if(_S966)
                    {
                        Tuple_14 _S968 = s_apply_unproject_raydir_0(_S965, _S956, _S955);
                        points_7[int(3)] = make_float3 (*&((&(&_S933->value0_24)->value3_3)->w)) * _S968.value0_19;
                        _S967 = int(2);
                        _S943 = _S968.value0_19;
                    }
                    else
                    {
                        _S967 = int(0);
                        _S943 = _S936;
                    }
                    if(_S967 != int(2))
                    {
                        _runFlag_18 = false;
                        _S954 = _S967;
                    }
                    else
                    {
                        _runFlag_18 = _runFlag_17;
                    }
                    if(_runFlag_18)
                    {
                        _S954 = int(1);
                    }
                    _runFlag_18 = _S966;
                    _S944 = _S964.value0_19;
                }
                else
                {
                    _runFlag_18 = false;
                    _S943 = _S936;
                    _S944 = _S936;
                }
            }
            else
            {
                _runFlag_17 = false;
                _runFlag_18 = false;
                _S943 = _S936;
                _S944 = _S936;
            }
            float3  _S969 = _S942;
            _S942 = _S943;
            _S943 = _S944;
            _S939 = _S960;
            _S944 = _S969;
            _S945 = _S957.value0_19;
        }
        else
        {
            _S954 = int(0);
            points_7[int(0)] = _S936;
            points_7[int(1)] = _S936;
            points_7[int(2)] = _S936;
            points_7[int(3)] = _S936;
            _runFlag_16 = false;
            _runFlag_17 = false;
            _runFlag_18 = false;
            _S942 = _S936;
            _S943 = _S936;
            _S939 = false;
            _S944 = _S936;
            _S945 = _S936;
        }
        if(_S954 != int(1))
        {
            _runFlag_19 = false;
        }
        else
        {
            _runFlag_19 = _S938;
        }
        if(_runFlag_19)
        {
            float3  dx_3 = points_7[int(1)] - points_7[int(0)];
            float3  _S970 = - (points_7[int(3)] - points_7[int(2)]);
            Tuple_9 _S971 = s_apply_cross_0(dx_3, _S970);
            s_bwdCallableCtx_cross_0 _S972;
            (&_S972)->_S68 = dx_3;
            (&_S972)->_S69 = _S970;
            s_bwdCallableCtx_cross_0 _S973 = _S972;
            Tuple_10 _S974 = s_apply_dot_0(_S971.value0_13, _S971.value0_13);
            s_bwdCallableCtx_dot_0 _S975;
            (&_S975)->_S81 = _S971.value0_13;
            (&_S975)->_S82 = _S971.value0_13;
            s_bwdCallableCtx_dot_0 _S976 = _S975;
            bool _S977 = (_S974.value0_14) != 0.0f;
            if(_S977)
            {
                Tuple_5 _S978 = s_apply_length_1(_S971.value0_13);
                float3  _S979 = make_float3 (_S978.value0_7);
                s_bwdCallableCtx_length_0 _S980;
                (&_S980)->_S11 = _S971.value0_13;
                _S946 = make_float3 (_S978.value0_7 * _S978.value0_7);
                _S947 = _S979;
                _S949 = _S980;
            }
            else
            {
                _S946 = _S936;
                _S947 = _S936;
                (&_S949)->_S11 = _S936;
            }
            float3  _S981 = _S947;
            _S940 = _S977;
            _S947 = _S971.value0_13;
            _S948 = _S981;
            _S950 = _S976;
            _S951 = _S973;
        }
        else
        {
            _S940 = false;
            _S946 = _S936;
            _S947 = _S936;
            _S948 = _S936;
            (&_S949)->_S11 = _S936;
            (&_S950)->_S81 = _S936;
            (&_S950)->_S82 = _S936;
            (&_S951)->_S68 = _S936;
            (&_S951)->_S69 = _S936;
        }
        bool _S982 = _runFlag_16;
        bool _S983 = _runFlag_17;
        bool _S984 = _runFlag_18;
        float3  _S985 = _S942;
        float3  _S986 = _S943;
        bool _S987 = _S939;
        float3  _S988 = _S944;
        float3  _S989 = _S945;
        _runFlag_16 = _runFlag_19;
        _runFlag_17 = _S940;
        _S942 = _S946;
        _S943 = _S947;
        _S944 = _S948;
        _runFlag_18 = _S953;
        _S939 = _S982;
        _runFlag_19 = _S983;
        _S940 = _S984;
        _S945 = _S985;
        _S946 = _S986;
        _S941 = _S987;
        _S947 = _S988;
        _S948 = _S989;
    }
    else
    {
        _runFlag_16 = false;
        _runFlag_17 = false;
        _S942 = _S936;
        _S943 = _S936;
        _S944 = _S936;
        (&_S949)->_S11 = _S936;
        (&_S950)->_S81 = _S936;
        (&_S950)->_S82 = _S936;
        (&_S951)->_S68 = _S936;
        (&_S951)->_S69 = _S936;
        _runFlag_18 = false;
        _S939 = false;
        _runFlag_19 = false;
        _S940 = false;
        _S945 = _S936;
        _S946 = _S936;
        _S941 = false;
        _S947 = _S936;
        _S948 = _S936;
    }
    FixedArray<float3 , 4>  _S990;
    Array_dzero_1(&_S990);
    FixedArray<float3 , 4>  _S991 = _S990;
    float4  _S992 = make_float4 (0.0f);
    float4  _S993;
    if(_S938)
    {
        if(_runFlag_16)
        {
            if(_runFlag_17)
            {
                float3  _S994 = _S935 / _S942;
                float3  _S995 = _S943 * - _S994;
                float3  _S996 = _S944 * _S994;
                float _S997 = _S995.x + _S995.y + _S995.z;
                float3  _S998 = _S936;
                s_bwdCallableCtx_length_0 _S999 = _S949;
                s_bwdProp_length_0(&_S999, &_S998, _S997);
                _S942 = _S996 + _S998;
            }
            else
            {
                _S942 = _S935;
            }
            float3  _S1000 = _S936;
            float3  _S1001 = _S936;
            s_bwdCallableCtx_dot_0 _S1002 = _S950;
            s_bwdProp_dot_0(&_S1002, &_S1000, &_S1001, 0.0f);
            float3  _S1003 = _S1000 + _S1001 + _S942;
            float3  _S1004 = _S936;
            float3  _S1005 = _S936;
            s_bwdCallableCtx_cross_0 _S1006 = _S951;
            s_bwdProp_cross_0(&_S1006, &_S1004, &_S1005, _S1003);
            float3  s_diff_dy_T_3 = - _S1005;
            float3  _S1007 = - s_diff_dy_T_3;
            float3  _S1008 = - _S1004;
            FixedArray<float3 , 4>  _S1009 = _S991;
            _S1009[int(2)] = _S1007;
            _S1009[int(3)] = s_diff_dy_T_3;
            _S1009[int(0)] = _S1008;
            _S1009[int(1)] = _S1004;
            FixedArray<float3 , 4>  _S1010 = _S991;
            FixedArray<float3 , 4>  _S1011 = _S1009;
            FixedArray<float3 , 4>  _S1012;
            Array_dadd_1(&_S1010, &_S1011, &_S1012);
            points_7 = _S1012;
        }
        else
        {
            points_7 = _S991;
        }
        if(_runFlag_18)
        {
            if(_S939)
            {
                if(_runFlag_19)
                {
                    FixedArray<float3 , 4>  _S1013 = points_7;
                    FixedArray<float3 , 4>  _S1014 = _S991;
                    FixedArray<float3 , 4>  _S1015;
                    Array_dadd_1(&_S1013, &_S1014, &_S1015);
                    FixedArray<float3 , 4>  _S1016 = _S1015;
                    if(_S940)
                    {
                        points_7 = _S1016;
                        points_7[int(3)] = _S936;
                        float3  _S1017 = _S945 * _S1016[int(3)];
                        float _S1018 = _S1017.x + _S1017.y + _S1017.z;
                        FixedArray<float3 , 4>  _S1019 = points_7;
                        FixedArray<float3 , 4>  _S1020 = _S991;
                        FixedArray<float3 , 4>  _S1021;
                        Array_dadd_1(&_S1019, &_S1020, &_S1021);
                        float4  _S1022 = _S992;
                        *&((&_S1022)->w) = _S1018;
                        points_7 = _S1021;
                        _S993 = _S1022;
                    }
                    else
                    {
                        FixedArray<float3 , 4>  _S1023 = _S1016;
                        FixedArray<float3 , 4>  _S1024 = _S991;
                        FixedArray<float3 , 4>  _S1025;
                        Array_dadd_1(&_S1023, &_S1024, &_S1025);
                        points_7 = _S1025;
                        _S993 = _S992;
                    }
                    FixedArray<float3 , 4>  _S1026 = points_7;
                    points_7[int(2)] = _S936;
                    float3  _S1027 = _S946 * _S1026[int(2)];
                    float _S1028 = _S1027.x + _S1027.y + _S1027.z;
                    FixedArray<float3 , 4>  _S1029 = points_7;
                    FixedArray<float3 , 4>  _S1030 = _S991;
                    FixedArray<float3 , 4>  _S1031;
                    Array_dadd_1(&_S1029, &_S1030, &_S1031);
                    float4  _S1032 = _S992;
                    *&((&_S1032)->z) = _S1028;
                    float4  _S1033 = _S993 + _S1032;
                    points_7 = _S1031;
                    _S993 = _S1033;
                }
                else
                {
                    FixedArray<float3 , 4>  _S1034 = points_7;
                    FixedArray<float3 , 4>  _S1035 = _S991;
                    FixedArray<float3 , 4>  _S1036;
                    Array_dadd_1(&_S1034, &_S1035, &_S1036);
                    points_7 = _S1036;
                    _S993 = _S992;
                }
            }
            else
            {
                FixedArray<float3 , 4>  _S1037 = points_7;
                FixedArray<float3 , 4>  _S1038 = _S991;
                FixedArray<float3 , 4>  _S1039;
                Array_dadd_1(&_S1037, &_S1038, &_S1039);
                points_7 = _S1039;
                _S993 = _S992;
            }
            if(_S941)
            {
                FixedArray<float3 , 4>  _S1040 = points_7;
                float3  _S1041 = _S947 * points_7[int(1)];
                float _S1042 = _S1041.x + _S1041.y + _S1041.z;
                float4  _S1043 = _S992;
                *&((&_S1043)->y) = _S1042;
                float4  _S1044 = _S993 + _S1043;
                points_7 = _S991;
                _S942 = _S1040[int(0)];
                _S993 = _S1044;
            }
            else
            {
                FixedArray<float3 , 4>  _S1045 = points_7;
                FixedArray<float3 , 4>  _S1046 = _S991;
                FixedArray<float3 , 4>  _S1047;
                Array_dadd_1(&_S1045, &_S1046, &_S1047);
                points_7 = _S1047;
                _S942 = _S936;
            }
            float3  _S1048 = _S948 * (points_7[int(0)] + _S942);
            float _S1049 = _S1048.x + _S1048.y + _S1048.z;
            float4  _S1050 = _S992;
            *&((&_S1050)->x) = _S1049;
            _S993 = _S993 + _S1050;
        }
        else
        {
            _S993 = _S992;
        }
    }
    else
    {
        _S993 = _S992;
    }
    *_S934 = _S993;
    return;
}

inline __device__ void _S1051(float2  _S1052, float4  _S1053, FixedArray<float, 8>  * _S1054, int _S1055, bool _S1056, DiffPair_vectorx3Cfloatx2C4x3E_0 * _S1057, float3  _S1058)
{
    float4  _S1059 = _S1057->primal_0;
    Tuple_16 _S1060 = s_apply_depth_to_normal_1(_S1052, _S1053, _S1054, _S1055, _S1056, _S1057->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_to_normal_0 _S1061;
    (&_S1061)->value1_6 = _S1055;
    (&_S1061)->value2_3 = _S1056;
    (&_S1061)->value3_3 = _S1059;
    s_bwdCallableCtx_depth_to_normal_0 _S1062;
    (&_S1062)->value0_24 = _S1061;
    (&_S1062)->value1_7 = _S1060.value1_5;
    s_bwdProp_depth_to_normal_1(&_S1062, &_S1057->differential_0, _S1058);
    return;
}

inline __device__ Tuple_17 s_apply_depth_to_point_1(float2  pix_pos_1, float4  intrins_5, FixedArray<float, 8>  * dist_coeffs_7, int camera_model_6, bool is_ray_depth_6, float _S1063)
{
    float2  _S1064 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_to_point_0 _S1065;
    (&_S1065)->value0_25 = false;
    (&_S1065)->value1_8 = _S1064;
    float2  uv_23 = (pix_pos_1 - float2 {intrins_5.z, intrins_5.w}) / float2 {intrins_5.x, intrins_5.y};
    float2  _S1066 = _S1064;
    bool _S1067 = undistort_point_1(uv_23, dist_coeffs_7, int(12), &_S1066);
    (&_S1065)->value0_25 = _S1067;
    float2  uv_u_19 = _S1066;
    (&_S1065)->value1_8 = _S1066;
    bool _S1068 = !_S1067;
    float3  _S1069;
    if(_S1068)
    {
        _S1069 = make_float3 (0.0f);
    }
    bool _S1070 = !_S1068;
    if(_S1070)
    {
        _S1069 = make_float3 (_S1063) * s_apply_unproject_raydir_0(uv_u_19, camera_model_6, is_ray_depth_6).value0_19;
    }
    Tuple_17 _S1071;
    (&_S1071)->value0_26 = _S1069;
    (&_S1071)->value1_9 = _S1065;
    return _S1071;
}

inline __device__ void s_bwdProp_depth_to_point_1(s_bwdCallableCtx_depth_to_point_0 * _S1072, float * _S1073, float3  _S1074)
{
    float3  _S1075 = make_float3 (0.0f);
    bool _S1076 = !!(&_S1072->value1_11)->value0_25;
    float3  _S1077;
    if(_S1076)
    {
        _S1077 = s_apply_unproject_raydir_0((&_S1072->value1_11)->value1_8, (&_S1072->value0_28)->value0_27, (&_S1072->value0_28)->value1_10).value0_19;
    }
    else
    {
        _S1077 = _S1075;
    }
    if(_S1076)
    {
        _S1077 = _S1077 * _S1074;
    }
    else
    {
        _S1077 = _S1075;
    }
    *_S1073 = _S1077.x + _S1077.y + _S1077.z;
    return;
}

inline __device__ void _S1078(float2  _S1079, float4  _S1080, FixedArray<float, 8>  * _S1081, int _S1082, bool _S1083, DiffPair_float_0 * _S1084, float3  _S1085)
{
    Tuple_17 _S1086 = s_apply_depth_to_point_1(_S1079, _S1080, _S1081, _S1082, _S1083, _S1084->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_to_point_0 _S1087;
    (&_S1087)->value0_27 = _S1082;
    (&_S1087)->value1_10 = _S1083;
    s_bwdCallableCtx_depth_to_point_0 _S1088;
    (&_S1088)->value0_28 = _S1087;
    (&_S1088)->value1_11 = _S1086.value1_9;
    s_bwdProp_depth_to_point_1(&_S1088, &_S1084->differential_0, _S1085);
    return;
}

inline __device__ float2  DistOpenCV_distort_0(float2  uv_24, FixedArray<float, 4>  * coeffs_4)
{
    float u_2 = uv_24.x;
    float v_2 = uv_24.y;
    float r2_3 = u_2 * u_2 + v_2 * v_2;
    return uv_24 * make_float2 (1.0f + r2_3 * ((*coeffs_4)[int(0)] + r2_3 * (*coeffs_4)[int(1)])) + make_float2 (2.0f * (*coeffs_4)[int(2)] * u_2 * v_2 + (*coeffs_4)[int(3)] * (r2_3 + 2.0f * u_2 * u_2), 2.0f * (*coeffs_4)[int(3)] * u_2 * v_2 + (*coeffs_4)[int(2)] * (r2_3 + 2.0f * v_2 * v_2));
}

inline __device__ DiffPair_vectorx3Cfloatx2C2x3E_0 s_fwd_DistOpenCV_distort_0(DiffPair_vectorx3Cfloatx2C2x3E_0 * dpuv_2, FixedArray<float, 4>  * coeffs_5)
{
    float u_3 = dpuv_2->primal_0.x;
    float s_diff_u_1 = dpuv_2->differential_0.x;
    float v_3 = dpuv_2->primal_0.y;
    float s_diff_v_1 = dpuv_2->differential_0.y;
    float _S1089 = s_diff_u_1 * u_3;
    float _S1090 = s_diff_v_1 * v_3;
    float r2_4 = u_3 * u_3 + v_3 * v_3;
    float s_diff_r2_1 = _S1089 + _S1089 + (_S1090 + _S1090);
    float _S1091 = (*coeffs_5)[int(0)] + r2_4 * (*coeffs_5)[int(1)];
    float radial_2 = 1.0f + r2_4 * _S1091;
    float _S1092 = 2.0f * (*coeffs_5)[int(2)];
    float _S1093 = _S1092 * u_3;
    float _S1094 = 2.0f * u_3;
    float _S1095 = 2.0f * (*coeffs_5)[int(3)];
    float _S1096 = _S1095 * u_3;
    float _S1097 = 2.0f * v_3;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1098 = { dpuv_2->primal_0 * make_float2 (radial_2) + make_float2 (_S1093 * v_3 + (*coeffs_5)[int(3)] * (r2_4 + _S1094 * u_3), _S1096 * v_3 + (*coeffs_5)[int(2)] * (r2_4 + _S1097 * v_3)), dpuv_2->differential_0 * make_float2 (radial_2) + make_float2 (s_diff_r2_1 * _S1091 + s_diff_r2_1 * (*coeffs_5)[int(1)] * r2_4) * dpuv_2->primal_0 + make_float2 (s_diff_u_1 * _S1092 * v_3 + s_diff_v_1 * _S1093 + (s_diff_r2_1 + (s_diff_u_1 * 2.0f * u_3 + s_diff_u_1 * _S1094)) * (*coeffs_5)[int(3)], s_diff_u_1 * _S1095 * v_3 + s_diff_v_1 * _S1096 + (s_diff_r2_1 + (s_diff_v_1 * 2.0f * v_3 + s_diff_v_1 * _S1097)) * (*coeffs_5)[int(2)]) };
    return _S1098;
}

inline __device__ bool undistort_point_2(float2  uv_25, FixedArray<float, 4>  * dist_coeffs_8, int maxiter_2, float2  * uv_undist_2)
{
    int i_5 = int(0);
    float2  q_4 = uv_25;
    for(;;)
    {
        if(i_5 < maxiter_2)
        {
        }
        else
        {
            break;
        }
        float2  _S1099 = DistOpenCV_distort_0(q_4, dist_coeffs_8);
        float2  r_3 = _S1099 - uv_25;
        float2  _S1100 = make_float2 (1.0f, 0.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1101;
        (&_S1101)->primal_0 = q_4;
        (&_S1101)->differential_0 = _S1100;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1102 = s_fwd_DistOpenCV_distort_0(&_S1101, dist_coeffs_8);
        float2  _S1103 = make_float2 (0.0f, 1.0f);
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1104;
        (&_S1104)->primal_0 = q_4;
        (&_S1104)->differential_0 = _S1103;
        DiffPair_vectorx3Cfloatx2C2x3E_0 _S1105 = s_fwd_DistOpenCV_distort_0(&_S1104, dist_coeffs_8);
        Matrix<float, 2, 2>  _S1106 = transpose_0(makeMatrix<float, 2, 2> (_S1102.differential_0, _S1105.differential_0));
        float inv_det_2 = 1.0f / (_S1106.rows[int(0)].x * _S1106.rows[int(1)].y - _S1106.rows[int(0)].y * _S1106.rows[int(1)].x);
        float _S1107 = r_3.x;
        float _S1108 = r_3.y;
        float2  q_5 = q_4 - make_float2 ((_S1107 * _S1106.rows[int(1)].y - _S1108 * _S1106.rows[int(0)].y) * inv_det_2, (- _S1107 * _S1106.rows[int(1)].x + _S1108 * _S1106.rows[int(0)].x) * inv_det_2);
        i_5 = i_5 + int(1);
        q_4 = q_5;
    }
    *uv_undist_2 = q_4;
    float2  _S1109 = make_float2 (1.0f, 0.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1110;
    (&_S1110)->primal_0 = q_4;
    (&_S1110)->differential_0 = _S1109;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1111 = s_fwd_DistOpenCV_distort_0(&_S1110, dist_coeffs_8);
    float2  _S1112 = make_float2 (0.0f, 1.0f);
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1113;
    (&_S1113)->primal_0 = q_4;
    (&_S1113)->differential_0 = _S1112;
    DiffPair_vectorx3Cfloatx2C2x3E_0 _S1114 = s_fwd_DistOpenCV_distort_0(&_S1113, dist_coeffs_8);
    Matrix<float, 2, 2>  _S1115 = transpose_0(makeMatrix<float, 2, 2> (_S1111.differential_0, _S1114.differential_0));
    float _S1116 = (F32_min((determinant_0(_S1115)), ((F32_min((_S1115.rows[int(0)].x), (_S1115.rows[int(1)].y))))));
    bool _S1117;
    if(_S1116 > 0.25f)
    {
        _S1117 = _S1116 < 4.0f;
    }
    else
    {
        _S1117 = false;
    }
    if(_S1117)
    {
        float2  _S1118 = DistOpenCV_distort_0(q_4, dist_coeffs_8);
        _S1117 = (dot_0(q_4, _S1118)) >= 0.0f;
    }
    else
    {
        _S1117 = false;
    }
    if(_S1117)
    {
        float2  _S1119 = DistOpenCV_distort_0(*uv_undist_2, dist_coeffs_8);
        _S1117 = (length_0(_S1119 - uv_25)) < 0.00999999977648258f;
    }
    else
    {
        _S1117 = false;
    }
    return _S1117;
}

inline __device__ Tuple_13 s_apply_depth_normal_loss_2(float2  pix_center_4, float4  intrins_6, FixedArray<float, 4>  * dist_coeffs_9, int camera_model_7, bool is_ray_depth_7, float4  _S1120, float3  _S1121)
{
    float2  _S1122 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_normal_loss_0 _S1123;
    (&_S1123)->value0_17 = false;
    (&_S1123)->value1_0 = _S1122;
    (&_S1123)->value2_0 = _S1122;
    (&_S1123)->value3_0 = false;
    (&_S1123)->value4_0 = _S1122;
    (&_S1123)->value5_0 = false;
    (&_S1123)->value6_0 = _S1122;
    (&_S1123)->value7_0 = false;
    (&_S1123)->value8_0 = _S1122;
    (&_S1123)->value9_0 = false;
    float3  _S1124 = make_float3 (0.0f);
    float2  _S1125 = float2 {intrins_6.z, intrins_6.w};
    float2  _S1126 = float2 {intrins_6.x, intrins_6.y};
    float2  uv_26 = (pix_center_4 + make_float2 (-1.0f, -0.0f) - _S1125) / _S1126;
    float2  _S1127 = _S1122;
    bool _S1128 = undistort_point_2(uv_26, dist_coeffs_9, int(12), &_S1127);
    (&_S1123)->value0_17 = _S1128;
    float2  uv_u_20 = _S1127;
    (&_S1123)->value1_0 = _S1127;
    bool _S1129 = !!_S1128;
    int _S1130;
    float3  raydir_5;
    FixedArray<float3 , 5>  points_8;
    if(_S1129)
    {
        Tuple_14 _S1131 = s_apply_unproject_raydir_0(uv_u_20, camera_model_7, is_ray_depth_7);
        float3  _S1132 = make_float3 (_S1120.x) * _S1131.value0_19;
        float2  uv_27 = (pix_center_4 + make_float2 (1.0f, -0.0f) - _S1125) / _S1126;
        float2  _S1133 = _S1122;
        bool _S1134 = undistort_point_2(uv_27, dist_coeffs_9, int(12), &_S1133);
        (&_S1123)->value2_0 = _S1133;
        (&_S1123)->value3_0 = _S1134;
        float2  uv_u_21 = _S1133;
        bool _runFlag_20;
        if(!_S1134)
        {
            _runFlag_20 = false;
        }
        else
        {
            _runFlag_20 = _S1129;
        }
        if(_runFlag_20)
        {
            Tuple_14 _S1135 = s_apply_unproject_raydir_0(uv_u_21, camera_model_7, is_ray_depth_7);
            float3  _S1136 = make_float3 (_S1120.y) * _S1135.value0_19;
            float2  uv_28 = (pix_center_4 + make_float2 (0.0f, -1.0f) - _S1125) / _S1126;
            float2  _S1137 = _S1122;
            bool _S1138 = undistort_point_2(uv_28, dist_coeffs_9, int(12), &_S1137);
            (&_S1123)->value4_0 = _S1137;
            (&_S1123)->value5_0 = _S1138;
            float2  uv_u_22 = _S1137;
            if(!_S1138)
            {
                _runFlag_20 = false;
            }
            if(_runFlag_20)
            {
                Tuple_14 _S1139 = s_apply_unproject_raydir_0(uv_u_22, camera_model_7, is_ray_depth_7);
                float3  _S1140 = make_float3 (_S1120.z) * _S1139.value0_19;
                float2  uv_29 = (pix_center_4 + make_float2 (0.0f, 1.0f) - _S1125) / _S1126;
                float2  _S1141 = _S1122;
                bool _S1142 = undistort_point_2(uv_29, dist_coeffs_9, int(12), &_S1141);
                (&_S1123)->value6_0 = _S1141;
                (&_S1123)->value7_0 = _S1142;
                float2  uv_u_23 = _S1141;
                if(!_S1142)
                {
                    _runFlag_20 = false;
                }
                if(_runFlag_20)
                {
                    Tuple_14 _S1143 = s_apply_unproject_raydir_0(uv_u_23, camera_model_7, is_ray_depth_7);
                    float3  _S1144 = make_float3 (_S1120.w) * _S1143.value0_19;
                    float2  uv_30 = (pix_center_4 - _S1125) / _S1126;
                    float2  _S1145 = _S1122;
                    bool _S1146 = undistort_point_2(uv_30, dist_coeffs_9, int(12), &_S1145);
                    (&_S1123)->value8_0 = _S1145;
                    (&_S1123)->value9_0 = _S1146;
                    float2  uv_u_24 = _S1145;
                    if(!_S1146)
                    {
                        _runFlag_20 = false;
                    }
                    if(_runFlag_20)
                    {
                        Tuple_14 _S1147 = s_apply_unproject_raydir_0(uv_u_24, camera_model_7, is_ray_depth_7);
                        _S1130 = int(1);
                        raydir_5 = _S1147.value0_19;
                    }
                    else
                    {
                        _S1130 = int(0);
                        raydir_5 = _S1143.value0_19;
                    }
                    points_8[int(0)] = _S1132;
                    points_8[int(1)] = _S1136;
                    points_8[int(2)] = _S1140;
                    points_8[int(3)] = _S1144;
                    points_8[int(4)] = _S1124;
                }
                else
                {
                    _S1130 = int(0);
                    raydir_5 = _S1139.value0_19;
                    points_8[int(0)] = _S1132;
                    points_8[int(1)] = _S1136;
                    points_8[int(2)] = _S1140;
                    points_8[int(3)] = _S1124;
                    points_8[int(4)] = _S1124;
                }
            }
            else
            {
                _S1130 = int(0);
                raydir_5 = _S1135.value0_19;
                points_8[int(0)] = _S1132;
                points_8[int(1)] = _S1136;
                points_8[int(2)] = _S1124;
                points_8[int(3)] = _S1124;
                points_8[int(4)] = _S1124;
            }
        }
        else
        {
            _S1130 = int(0);
            raydir_5 = _S1131.value0_19;
            points_8[int(0)] = _S1132;
            points_8[int(1)] = _S1124;
            points_8[int(2)] = _S1124;
            points_8[int(3)] = _S1124;
            points_8[int(4)] = _S1124;
        }
    }
    else
    {
        _S1130 = int(0);
        points_8[int(0)] = _S1124;
        points_8[int(1)] = _S1124;
        points_8[int(2)] = _S1124;
        points_8[int(3)] = _S1124;
        points_8[int(4)] = _S1124;
    }
    float _S1148;
    if(!(_S1130 != int(1)))
    {
        Tuple_9 _S1149 = s_apply_cross_0(points_8[int(1)] - points_8[int(0)], - (points_8[int(3)] - points_8[int(2)]));
        float3  _S1150 = _S1149.value0_13;
        float3  normal_6;
        if((s_apply_dot_0(_S1150, _S1150).value0_14) != 0.0f)
        {
            normal_6 = s_apply_normalize_0(_S1149.value0_13).value0_4;
        }
        else
        {
            normal_6 = _S1149.value0_13;
        }
        float3  _S1151;
        if((s_apply_dot_0(_S1121, _S1121).value0_14) != 0.0f)
        {
            _S1151 = s_apply_normalize_0(_S1121).value0_4;
        }
        else
        {
            _S1151 = _S1121;
        }
        _S1148 = (1.0f - s_apply_dot_0(normal_6, _S1151).value0_14 + 0.00100000004749745f) / (s_apply_max_0(s_apply_dot_0(normal_6, - s_apply_normalize_0(raydir_5).value0_4).value0_14, 0.0f).value0_16 + 0.00100000004749745f);
    }
    else
    {
        _S1148 = 0.0f;
    }
    Tuple_13 _S1152;
    (&_S1152)->value0_18 = _S1148;
    (&_S1152)->value1_1 = _S1123;
    return _S1152;
}

inline __device__ void s_bwdProp_depth_normal_loss_2(s_bwdCallableCtx_depth_normal_loss_0 * _S1153, float4  * _S1154, float3  * _S1155, float _S1156)
{
    float3  _S1157 = make_float3 (0.0f);
    bool _S1158 = !!(&_S1153->value1_3)->value0_17;
    bool _runFlag_21;
    bool _runFlag_22;
    bool _runFlag_23;
    bool _runFlag_24;
    int _S1159;
    float3  raydir_6;
    float3  _S1160;
    float3  _S1161;
    float3  _S1162;
    float3  _S1163;
    FixedArray<float3 , 5>  points_9;
    if(_S1158)
    {
        bool _S1164 = (&_S1153->value0_21)->value2_1;
        int _S1165 = (&_S1153->value0_21)->value1_2;
        Tuple_14 _S1166 = s_apply_unproject_raydir_0((&_S1153->value1_3)->value1_0, (&_S1153->value0_21)->value1_2, (&_S1153->value0_21)->value2_1);
        float3  _S1167 = make_float3 (*&((&(&_S1153->value0_21)->value3_1)->x)) * _S1166.value0_19;
        float2  _S1168 = (&_S1153->value1_3)->value2_0;
        if(!(&_S1153->value1_3)->value3_0)
        {
            _runFlag_21 = false;
        }
        else
        {
            _runFlag_21 = _S1158;
        }
        if(_runFlag_21)
        {
            Tuple_14 _S1169 = s_apply_unproject_raydir_0(_S1168, _S1165, _S1164);
            float3  _S1170 = make_float3 (*&((&(&_S1153->value0_21)->value3_1)->y)) * _S1169.value0_19;
            float2  _S1171 = (&_S1153->value1_3)->value4_0;
            if(!(&_S1153->value1_3)->value5_0)
            {
                _runFlag_22 = false;
            }
            else
            {
                _runFlag_22 = _runFlag_21;
            }
            if(_runFlag_22)
            {
                Tuple_14 _S1172 = s_apply_unproject_raydir_0(_S1171, _S1165, _S1164);
                float3  _S1173 = make_float3 (*&((&(&_S1153->value0_21)->value3_1)->z)) * _S1172.value0_19;
                float2  _S1174 = (&_S1153->value1_3)->value6_0;
                if(!(&_S1153->value1_3)->value7_0)
                {
                    _runFlag_23 = false;
                }
                else
                {
                    _runFlag_23 = _runFlag_22;
                }
                if(_runFlag_23)
                {
                    Tuple_14 _S1175 = s_apply_unproject_raydir_0(_S1174, _S1165, _S1164);
                    float3  _S1176 = make_float3 (*&((&(&_S1153->value0_21)->value3_1)->w)) * _S1175.value0_19;
                    float2  _S1177 = (&_S1153->value1_3)->value8_0;
                    if(!(&_S1153->value1_3)->value9_0)
                    {
                        _runFlag_24 = false;
                    }
                    else
                    {
                        _runFlag_24 = _runFlag_23;
                    }
                    if(_runFlag_24)
                    {
                        Tuple_14 _S1178 = s_apply_unproject_raydir_0(_S1177, _S1165, _S1164);
                        _S1159 = int(1);
                        raydir_6 = _S1178.value0_19;
                    }
                    else
                    {
                        _S1159 = int(0);
                        raydir_6 = _S1175.value0_19;
                    }
                    points_9[int(0)] = _S1167;
                    points_9[int(1)] = _S1170;
                    points_9[int(2)] = _S1173;
                    points_9[int(3)] = _S1176;
                    points_9[int(4)] = _S1157;
                    _S1160 = _S1175.value0_19;
                }
                else
                {
                    _S1159 = int(0);
                    raydir_6 = _S1172.value0_19;
                    points_9[int(0)] = _S1167;
                    points_9[int(1)] = _S1170;
                    points_9[int(2)] = _S1173;
                    points_9[int(3)] = _S1157;
                    points_9[int(4)] = _S1157;
                    _S1160 = _S1157;
                }
                _S1161 = _S1172.value0_19;
            }
            else
            {
                _S1159 = int(0);
                raydir_6 = _S1169.value0_19;
                points_9[int(0)] = _S1167;
                points_9[int(1)] = _S1170;
                points_9[int(2)] = _S1157;
                points_9[int(3)] = _S1157;
                points_9[int(4)] = _S1157;
                _runFlag_23 = false;
                _S1160 = _S1157;
                _S1161 = _S1157;
            }
            _S1162 = _S1169.value0_19;
        }
        else
        {
            _S1159 = int(0);
            raydir_6 = _S1166.value0_19;
            points_9[int(0)] = _S1167;
            points_9[int(1)] = _S1157;
            points_9[int(2)] = _S1157;
            points_9[int(3)] = _S1157;
            points_9[int(4)] = _S1157;
            _runFlag_22 = false;
            _runFlag_23 = false;
            _S1160 = _S1157;
            _S1161 = _S1157;
            _S1162 = _S1157;
        }
        _S1163 = _S1166.value0_19;
    }
    else
    {
        _S1159 = int(0);
        points_9[int(0)] = _S1157;
        points_9[int(1)] = _S1157;
        points_9[int(2)] = _S1157;
        points_9[int(3)] = _S1157;
        points_9[int(4)] = _S1157;
        _runFlag_21 = false;
        _runFlag_22 = false;
        _runFlag_23 = false;
        _S1160 = _S1157;
        _S1161 = _S1157;
        _S1162 = _S1157;
        _S1163 = _S1157;
    }
    bool _S1179 = !(_S1159 != int(1));
    bool _S1180;
    float3  normal_7;
    float3  _S1181;
    s_bwdCallableCtx_normalize_0 _S1182;
    s_bwdCallableCtx_normalize_0 _S1183;
    float _S1184;
    float _S1185;
    float _S1186;
    s_bwdCallableCtx_max_0 _S1187;
    s_bwdCallableCtx_dot_0 _S1188;
    s_bwdCallableCtx_dot_0 _S1189;
    s_bwdCallableCtx_dot_0 _S1190;
    s_bwdCallableCtx_dot_0 _S1191;
    s_bwdCallableCtx_cross_0 _S1192;
    if(_S1179)
    {
        float3  dx_4 = points_9[int(1)] - points_9[int(0)];
        float3  _S1193 = - (points_9[int(3)] - points_9[int(2)]);
        Tuple_9 _S1194 = s_apply_cross_0(dx_4, _S1193);
        s_bwdCallableCtx_cross_0 _S1195;
        (&_S1195)->_S68 = dx_4;
        (&_S1195)->_S69 = _S1193;
        s_bwdCallableCtx_cross_0 _S1196 = _S1195;
        Tuple_10 _S1197 = s_apply_dot_0(_S1194.value0_13, _S1194.value0_13);
        s_bwdCallableCtx_dot_0 _S1198;
        (&_S1198)->_S81 = _S1194.value0_13;
        (&_S1198)->_S82 = _S1194.value0_13;
        s_bwdCallableCtx_dot_0 _S1199 = _S1198;
        bool _S1200 = (_S1197.value0_14) != 0.0f;
        if(_S1200)
        {
            Tuple_4 _S1201 = s_apply_normalize_0(_S1194.value0_13);
            s_bwdCallableCtx_normalize_0 _S1202;
            (&_S1202)->_S9 = _S1194.value0_13;
            normal_7 = _S1201.value0_4;
            _S1182 = _S1202;
        }
        else
        {
            normal_7 = _S1194.value0_13;
            (&_S1182)->_S9 = _S1157;
        }
        float3  _S1203 = (&_S1153->value0_21)->value4_1;
        Tuple_10 _S1204 = s_apply_dot_0((&_S1153->value0_21)->value4_1, (&_S1153->value0_21)->value4_1);
        s_bwdCallableCtx_dot_0 _S1205;
        (&_S1205)->_S81 = (&_S1153->value0_21)->value4_1;
        (&_S1205)->_S82 = (&_S1153->value0_21)->value4_1;
        s_bwdCallableCtx_dot_0 _S1206 = _S1205;
        bool _S1207 = (_S1204.value0_14) != 0.0f;
        if(_S1207)
        {
            Tuple_4 _S1208 = s_apply_normalize_0(_S1203);
            s_bwdCallableCtx_normalize_0 _S1209;
            (&_S1209)->_S9 = _S1203;
            _S1181 = _S1208.value0_4;
            _S1183 = _S1209;
        }
        else
        {
            _S1181 = _S1203;
            (&_S1183)->_S9 = _S1157;
        }
        Tuple_10 _S1210 = s_apply_dot_0(normal_7, _S1181);
        s_bwdCallableCtx_dot_0 _S1211;
        (&_S1211)->_S81 = normal_7;
        (&_S1211)->_S82 = _S1181;
        float num_2 = 1.0f - _S1210.value0_14;
        float3  _S1212 = - s_apply_normalize_0(raydir_6).value0_4;
        Tuple_10 _S1213 = s_apply_dot_0(normal_7, _S1212);
        s_bwdCallableCtx_dot_0 _S1214;
        (&_S1214)->_S81 = normal_7;
        (&_S1214)->_S82 = _S1212;
        float _S1215 = num_2 + 0.00100000004749745f;
        Tuple_12 _S1216 = s_apply_max_0(_S1213.value0_14, 0.0f);
        s_bwdCallableCtx_max_0 _S1217;
        (&_S1217)->_S94 = _S1213.value0_14;
        (&_S1217)->_S95 = 0.0f;
        float _S1218 = _S1216.value0_16 + 0.00100000004749745f;
        s_bwdCallableCtx_normalize_0 _S1219 = _S1182;
        _S1184 = _S1218 * _S1218;
        _S1185 = _S1215;
        _S1186 = _S1218;
        _S1187 = _S1217;
        _S1188 = _S1214;
        _S1189 = _S1211;
        _runFlag_24 = _S1207;
        _S1182 = _S1183;
        _S1190 = _S1206;
        _S1180 = _S1200;
        _S1183 = _S1219;
        _S1191 = _S1199;
        _S1192 = _S1196;
    }
    else
    {
        _S1184 = 0.0f;
        _S1185 = 0.0f;
        _S1186 = 0.0f;
        (&_S1187)->_S94 = 0.0f;
        (&_S1187)->_S95 = 0.0f;
        (&_S1188)->_S81 = _S1157;
        (&_S1188)->_S82 = _S1157;
        (&_S1189)->_S81 = _S1157;
        (&_S1189)->_S82 = _S1157;
        _runFlag_24 = false;
        (&_S1182)->_S9 = _S1157;
        (&_S1190)->_S81 = _S1157;
        (&_S1190)->_S82 = _S1157;
        _S1180 = false;
        (&_S1183)->_S9 = _S1157;
        (&_S1191)->_S81 = _S1157;
        (&_S1191)->_S82 = _S1157;
        (&_S1192)->_S68 = _S1157;
        (&_S1192)->_S69 = _S1157;
    }
    float4  _S1220 = make_float4 (0.0f);
    FixedArray<float3 , 5>  _S1221;
    Array_dzero_0(&_S1221);
    FixedArray<float3 , 5>  _S1222 = _S1221;
    if(_S1179)
    {
        float _S1223 = _S1156 / _S1184;
        float _S1224 = _S1185 * - _S1223;
        float s_diff_num_T_2 = _S1186 * _S1223;
        float _S1225 = 0.0f;
        float _S1226 = 0.0f;
        s_bwdCallableCtx_max_0 _S1227 = _S1187;
        s_bwdProp_max_0(&_S1227, &_S1225, &_S1226, _S1224);
        float3  _S1228 = _S1157;
        float3  _S1229 = _S1157;
        s_bwdCallableCtx_dot_0 _S1230 = _S1188;
        s_bwdProp_dot_0(&_S1230, &_S1228, &_S1229, _S1225);
        float _S1231 = - s_diff_num_T_2;
        float3  _S1232 = _S1157;
        float3  _S1233 = _S1157;
        s_bwdCallableCtx_dot_0 _S1234 = _S1189;
        s_bwdProp_dot_0(&_S1234, &_S1232, &_S1233, _S1231);
        float3  _S1235 = _S1233;
        float3  _S1236 = _S1228 + _S1232;
        if(_runFlag_24)
        {
            float3  _S1237 = _S1157;
            s_bwdCallableCtx_normalize_0 _S1238 = _S1182;
            s_bwdProp_normalize_0(&_S1238, &_S1237, _S1235);
            raydir_6 = _S1237;
        }
        else
        {
            raydir_6 = _S1235;
        }
        float3  _S1239 = _S1157;
        float3  _S1240 = _S1157;
        s_bwdCallableCtx_dot_0 _S1241 = _S1190;
        s_bwdProp_dot_0(&_S1241, &_S1239, &_S1240, 0.0f);
        float3  _S1242 = _S1239 + _S1240 + raydir_6;
        if(_S1180)
        {
            float3  _S1243 = _S1157;
            s_bwdCallableCtx_normalize_0 _S1244 = _S1183;
            s_bwdProp_normalize_0(&_S1244, &_S1243, _S1236);
            raydir_6 = _S1243;
        }
        else
        {
            raydir_6 = _S1236;
        }
        float3  _S1245 = _S1157;
        float3  _S1246 = _S1157;
        s_bwdCallableCtx_dot_0 _S1247 = _S1191;
        s_bwdProp_dot_0(&_S1247, &_S1245, &_S1246, 0.0f);
        float3  _S1248 = _S1245 + _S1246 + raydir_6;
        float3  _S1249 = _S1157;
        float3  _S1250 = _S1157;
        s_bwdCallableCtx_cross_0 _S1251 = _S1192;
        s_bwdProp_cross_0(&_S1251, &_S1249, &_S1250, _S1248);
        float3  s_diff_dy_T_4 = - _S1250;
        float3  _S1252 = - s_diff_dy_T_4;
        float3  _S1253 = - _S1249;
        FixedArray<float3 , 5>  _S1254 = _S1222;
        _S1254[int(2)] = _S1252;
        _S1254[int(3)] = s_diff_dy_T_4;
        _S1254[int(0)] = _S1253;
        _S1254[int(1)] = _S1249;
        FixedArray<float3 , 5>  _S1255 = _S1222;
        FixedArray<float3 , 5>  _S1256 = _S1254;
        FixedArray<float3 , 5>  _S1257;
        Array_dadd_0(&_S1255, &_S1256, &_S1257);
        points_9 = _S1257;
        raydir_6 = _S1242;
    }
    else
    {
        points_9 = _S1222;
        raydir_6 = _S1157;
    }
    float4  _S1258;
    if(_S1158)
    {
        if(_runFlag_21)
        {
            if(_runFlag_22)
            {
                if(_runFlag_23)
                {
                    FixedArray<float3 , 5>  _S1259 = points_9;
                    FixedArray<float3 , 5>  _S1260 = _S1222;
                    FixedArray<float3 , 5>  _S1261;
                    Array_dadd_0(&_S1259, &_S1260, &_S1261);
                    float3  _S1262 = _S1160 * _S1261[int(3)];
                    float _S1263 = _S1262.x + _S1262.y + _S1262.z;
                    float4  _S1264 = _S1220;
                    *&((&_S1264)->w) = _S1263;
                    points_9 = _S1222;
                    _S1160 = _S1261[int(2)];
                    normal_7 = _S1261[int(0)];
                    _S1181 = _S1261[int(1)];
                    _S1258 = _S1264;
                }
                else
                {
                    FixedArray<float3 , 5>  _S1265 = points_9;
                    FixedArray<float3 , 5>  _S1266 = _S1222;
                    FixedArray<float3 , 5>  _S1267;
                    Array_dadd_0(&_S1265, &_S1266, &_S1267);
                    points_9 = _S1267;
                    _S1160 = _S1157;
                    normal_7 = _S1157;
                    _S1181 = _S1157;
                    _S1258 = _S1220;
                }
                float3  _S1268 = _S1161 * (points_9[int(2)] + _S1160);
                float _S1269 = _S1268.x + _S1268.y + _S1268.z;
                float3  _S1270 = points_9[int(0)] + normal_7;
                float3  _S1271 = points_9[int(1)] + _S1181;
                float4  _S1272 = _S1220;
                *&((&_S1272)->z) = _S1269;
                float4  _S1273 = _S1258 + _S1272;
                points_9 = _S1222;
                _S1160 = _S1271;
                _S1161 = _S1270;
                _S1258 = _S1273;
            }
            else
            {
                FixedArray<float3 , 5>  _S1274 = points_9;
                FixedArray<float3 , 5>  _S1275 = _S1222;
                FixedArray<float3 , 5>  _S1276;
                Array_dadd_0(&_S1274, &_S1275, &_S1276);
                points_9 = _S1276;
                _S1160 = _S1157;
                _S1161 = _S1157;
                _S1258 = _S1220;
            }
            float3  _S1277 = _S1162 * (points_9[int(1)] + _S1160);
            float _S1278 = _S1277.x + _S1277.y + _S1277.z;
            float3  _S1279 = points_9[int(0)] + _S1161;
            float4  _S1280 = _S1220;
            *&((&_S1280)->y) = _S1278;
            float4  _S1281 = _S1258 + _S1280;
            points_9 = _S1222;
            _S1160 = _S1279;
            _S1258 = _S1281;
        }
        else
        {
            FixedArray<float3 , 5>  _S1282 = points_9;
            FixedArray<float3 , 5>  _S1283 = _S1222;
            FixedArray<float3 , 5>  _S1284;
            Array_dadd_0(&_S1282, &_S1283, &_S1284);
            points_9 = _S1284;
            _S1160 = _S1157;
            _S1258 = _S1220;
        }
        float3  _S1285 = _S1163 * (points_9[int(0)] + _S1160);
        float _S1286 = _S1285.x + _S1285.y + _S1285.z;
        float4  _S1287 = _S1220;
        *&((&_S1287)->x) = _S1286;
        _S1258 = _S1258 + _S1287;
    }
    else
    {
        _S1258 = _S1220;
    }
    *_S1154 = _S1258;
    *_S1155 = raydir_6;
    return;
}

inline __device__ void _S1288(float2  _S1289, float4  _S1290, FixedArray<float, 4>  * _S1291, int _S1292, bool _S1293, DiffPair_vectorx3Cfloatx2C4x3E_0 * _S1294, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1295, float _S1296)
{
    float4  _S1297 = _S1294->primal_0;
    float3  _S1298 = _S1295->primal_0;
    Tuple_13 _S1299 = s_apply_depth_normal_loss_2(_S1289, _S1290, _S1291, _S1292, _S1293, _S1294->primal_0, _S1295->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_normal_loss_0 _S1300;
    (&_S1300)->value1_2 = _S1292;
    (&_S1300)->value2_1 = _S1293;
    (&_S1300)->value3_1 = _S1297;
    (&_S1300)->value4_1 = _S1298;
    s_bwdCallableCtx_depth_normal_loss_0 _S1301;
    (&_S1301)->value0_21 = _S1300;
    (&_S1301)->value1_3 = _S1299.value1_1;
    s_bwdProp_depth_normal_loss_2(&_S1301, &_S1294->differential_0, &_S1295->differential_0, _S1296);
    return;
}

inline __device__ Tuple_16 s_apply_depth_to_normal_2(float2  pix_center_5, float4  intrins_7, FixedArray<float, 4>  * dist_coeffs_10, int camera_model_8, bool is_ray_depth_8, float4  _S1302)
{
    float2  _S1303 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_to_normal_0 _S1304;
    (&_S1304)->value0_22 = _S1303;
    (&_S1304)->value1_4 = false;
    (&_S1304)->value2_2 = _S1303;
    (&_S1304)->value3_2 = false;
    (&_S1304)->value4_2 = _S1303;
    (&_S1304)->value5_1 = false;
    (&_S1304)->value6_1 = _S1303;
    (&_S1304)->value7_1 = false;
    float3  _S1305 = make_float3 (0.0f);
    bool _runFlag_25;
    if((_S1302.x) == 0.0f)
    {
        _runFlag_25 = true;
    }
    else
    {
        _runFlag_25 = (_S1302.y) == 0.0f;
    }
    if(_runFlag_25)
    {
        _runFlag_25 = true;
    }
    else
    {
        _runFlag_25 = (_S1302.z) == 0.0f;
    }
    if(_runFlag_25)
    {
        _runFlag_25 = true;
    }
    else
    {
        _runFlag_25 = (_S1302.w) == 0.0f;
    }
    float3  normal_8;
    if(_runFlag_25)
    {
        normal_8 = make_float3 (0.0f);
    }
    bool _S1306 = !_runFlag_25;
    if(_S1306)
    {
        float2  _S1307 = float2 {intrins_7.z, intrins_7.w};
        float2  _S1308 = float2 {intrins_7.x, intrins_7.y};
        float2  uv_31 = (pix_center_5 + make_float2 (-1.0f, -0.0f) - _S1307) / _S1308;
        float2  _S1309 = _S1303;
        bool _S1310 = undistort_point_2(uv_31, dist_coeffs_10, int(12), &_S1309);
        (&_S1304)->value0_22 = _S1309;
        (&_S1304)->value1_4 = _S1310;
        float2  uv_u_25 = _S1309;
        bool _S1311 = !_S1310;
        if(_S1311)
        {
            normal_8 = make_float3 (0.0f);
        }
        bool _S1312 = !_S1311;
        int _S1313;
        FixedArray<float3 , 4>  points_10;
        if(_S1312)
        {
            float3  _S1314 = make_float3 (_S1302.x) * s_apply_unproject_raydir_0(uv_u_25, camera_model_8, is_ray_depth_8).value0_19;
            float2  uv_32 = (pix_center_5 + make_float2 (1.0f, -0.0f) - _S1307) / _S1308;
            float2  _S1315 = _S1303;
            bool _S1316 = undistort_point_2(uv_32, dist_coeffs_10, int(12), &_S1315);
            (&_S1304)->value2_2 = _S1315;
            (&_S1304)->value3_2 = _S1316;
            float2  uv_u_26 = _S1315;
            bool _S1317 = !_S1316;
            if(_S1317)
            {
                normal_8 = make_float3 (0.0f);
            }
            bool _S1318 = !_S1317;
            if(_S1318)
            {
                float3  _S1319 = make_float3 (_S1302.y) * s_apply_unproject_raydir_0(uv_u_26, camera_model_8, is_ray_depth_8).value0_19;
                _S1313 = int(2);
                points_10[int(0)] = _S1314;
                points_10[int(1)] = _S1319;
                points_10[int(2)] = _S1305;
                points_10[int(3)] = _S1305;
            }
            else
            {
                _S1313 = int(0);
                points_10[int(0)] = _S1314;
                points_10[int(1)] = _S1305;
                points_10[int(2)] = _S1305;
                points_10[int(3)] = _S1305;
            }
            if(_S1313 != int(2))
            {
                _runFlag_25 = false;
            }
            else
            {
                _runFlag_25 = _S1312;
                _S1313 = int(0);
            }
            if(_runFlag_25)
            {
                float2  uv_33 = (pix_center_5 + make_float2 (0.0f, -1.0f) - _S1307) / _S1308;
                float2  _S1320 = _S1303;
                bool _S1321 = undistort_point_2(uv_33, dist_coeffs_10, int(12), &_S1320);
                (&_S1304)->value4_2 = _S1320;
                (&_S1304)->value5_1 = _S1321;
                float2  uv_u_27 = _S1320;
                if(!_S1321)
                {
                    float3  _S1322 = make_float3 (0.0f);
                    _runFlag_25 = false;
                    _S1313 = int(0);
                    normal_8 = _S1322;
                }
                if(_runFlag_25)
                {
                    points_10[int(2)] = make_float3 (_S1302.z) * s_apply_unproject_raydir_0(uv_u_27, camera_model_8, is_ray_depth_8).value0_19;
                    float2  uv_34 = (pix_center_5 + make_float2 (0.0f, 1.0f) - _S1307) / _S1308;
                    float2  _S1323 = _S1303;
                    bool _S1324 = undistort_point_2(uv_34, dist_coeffs_10, int(12), &_S1323);
                    (&_S1304)->value6_1 = _S1323;
                    (&_S1304)->value7_1 = _S1324;
                    float2  uv_u_28 = _S1323;
                    bool _S1325 = !_S1324;
                    if(_S1325)
                    {
                        normal_8 = make_float3 (0.0f);
                    }
                    bool _S1326 = !_S1325;
                    int _S1327;
                    if(_S1326)
                    {
                        points_10[int(3)] = make_float3 (_S1302.w) * s_apply_unproject_raydir_0(uv_u_28, camera_model_8, is_ray_depth_8).value0_19;
                        _S1327 = int(2);
                    }
                    else
                    {
                        _S1327 = int(0);
                    }
                    if(_S1327 != int(2))
                    {
                        _runFlag_25 = false;
                        _S1313 = _S1327;
                    }
                    if(_runFlag_25)
                    {
                        _S1313 = int(1);
                    }
                }
            }
        }
        else
        {
            _S1313 = int(0);
            points_10[int(0)] = _S1305;
            points_10[int(1)] = _S1305;
            points_10[int(2)] = _S1305;
            points_10[int(3)] = _S1305;
        }
        if(_S1313 != int(1))
        {
            _runFlag_25 = false;
        }
        else
        {
            _runFlag_25 = _S1306;
        }
        if(_runFlag_25)
        {
            Tuple_9 _S1328 = s_apply_cross_0(points_10[int(1)] - points_10[int(0)], - (points_10[int(3)] - points_10[int(2)]));
            float3  _S1329 = _S1328.value0_13;
            if((s_apply_dot_0(_S1329, _S1329).value0_14) != 0.0f)
            {
                normal_8 = _S1328.value0_13 / make_float3 (s_apply_length_1(_S1328.value0_13).value0_7);
            }
            else
            {
                normal_8 = _S1328.value0_13;
            }
        }
    }
    Tuple_16 _S1330;
    (&_S1330)->value0_23 = normal_8;
    (&_S1330)->value1_5 = _S1304;
    return _S1330;
}

inline __device__ void s_bwdProp_depth_to_normal_2(s_bwdCallableCtx_depth_to_normal_0 * _S1331, float4  * _S1332, float3  _S1333)
{
    float3  _S1334 = make_float3 (0.0f);
    float4  _S1335 = (&_S1331->value0_24)->value3_3;
    bool _runFlag_26;
    if(((&_S1331->value0_24)->value3_3.x) == 0.0f)
    {
        _runFlag_26 = true;
    }
    else
    {
        _runFlag_26 = (_S1335.y) == 0.0f;
    }
    if(_runFlag_26)
    {
        _runFlag_26 = true;
    }
    else
    {
        _runFlag_26 = (_S1335.z) == 0.0f;
    }
    if(_runFlag_26)
    {
        _runFlag_26 = true;
    }
    else
    {
        _runFlag_26 = (_S1335.w) == 0.0f;
    }
    bool _S1336 = !_runFlag_26;
    bool _runFlag_27;
    bool _runFlag_28;
    bool _S1337;
    bool _runFlag_29;
    bool _S1338;
    bool _S1339;
    FixedArray<float3 , 4>  points_11;
    float3  _S1340;
    float3  _S1341;
    float3  _S1342;
    float3  _S1343;
    float3  _S1344;
    float3  _S1345;
    float3  _S1346;
    s_bwdCallableCtx_length_0 _S1347;
    s_bwdCallableCtx_dot_0 _S1348;
    s_bwdCallableCtx_cross_0 _S1349;
    if(_S1336)
    {
        float2  _S1350 = (&_S1331->value1_7)->value0_22;
        bool _S1351 = !!(&_S1331->value1_7)->value1_4;
        int _S1352;
        if(_S1351)
        {
            bool _S1353 = (&_S1331->value0_24)->value2_3;
            int _S1354 = (&_S1331->value0_24)->value1_6;
            Tuple_14 _S1355 = s_apply_unproject_raydir_0(_S1350, (&_S1331->value0_24)->value1_6, (&_S1331->value0_24)->value2_3);
            float3  _S1356 = make_float3 (*&((&(&_S1331->value0_24)->value3_3)->x)) * _S1355.value0_19;
            float2  _S1357 = (&_S1331->value1_7)->value2_2;
            bool _S1358 = !!(&_S1331->value1_7)->value3_2;
            if(_S1358)
            {
                Tuple_14 _S1359 = s_apply_unproject_raydir_0(_S1357, _S1354, _S1353);
                float3  _S1360 = make_float3 (*&((&(&_S1331->value0_24)->value3_3)->y)) * _S1359.value0_19;
                _S1352 = int(2);
                points_11[int(0)] = _S1356;
                points_11[int(1)] = _S1360;
                points_11[int(2)] = _S1334;
                points_11[int(3)] = _S1334;
                _S1340 = _S1359.value0_19;
            }
            else
            {
                _S1352 = int(0);
                points_11[int(0)] = _S1356;
                points_11[int(1)] = _S1334;
                points_11[int(2)] = _S1334;
                points_11[int(3)] = _S1334;
                _S1340 = _S1334;
            }
            if(_S1352 != int(2))
            {
                _runFlag_26 = false;
            }
            else
            {
                _runFlag_26 = _S1351;
                _S1352 = int(0);
            }
            if(_runFlag_26)
            {
                float2  _S1361 = (&_S1331->value1_7)->value4_2;
                if(!(&_S1331->value1_7)->value5_1)
                {
                    _runFlag_27 = false;
                    _S1352 = int(0);
                }
                else
                {
                    _runFlag_27 = _runFlag_26;
                }
                if(_runFlag_27)
                {
                    Tuple_14 _S1362 = s_apply_unproject_raydir_0(_S1361, _S1354, _S1353);
                    points_11[int(2)] = make_float3 (*&((&(&_S1331->value0_24)->value3_3)->z)) * _S1362.value0_19;
                    float2  _S1363 = (&_S1331->value1_7)->value6_1;
                    bool _S1364 = !!(&_S1331->value1_7)->value7_1;
                    int _S1365;
                    if(_S1364)
                    {
                        Tuple_14 _S1366 = s_apply_unproject_raydir_0(_S1363, _S1354, _S1353);
                        points_11[int(3)] = make_float3 (*&((&(&_S1331->value0_24)->value3_3)->w)) * _S1366.value0_19;
                        _S1365 = int(2);
                        _S1341 = _S1366.value0_19;
                    }
                    else
                    {
                        _S1365 = int(0);
                        _S1341 = _S1334;
                    }
                    if(_S1365 != int(2))
                    {
                        _runFlag_28 = false;
                        _S1352 = _S1365;
                    }
                    else
                    {
                        _runFlag_28 = _runFlag_27;
                    }
                    if(_runFlag_28)
                    {
                        _S1352 = int(1);
                    }
                    _runFlag_28 = _S1364;
                    _S1342 = _S1362.value0_19;
                }
                else
                {
                    _runFlag_28 = false;
                    _S1341 = _S1334;
                    _S1342 = _S1334;
                }
            }
            else
            {
                _runFlag_27 = false;
                _runFlag_28 = false;
                _S1341 = _S1334;
                _S1342 = _S1334;
            }
            float3  _S1367 = _S1340;
            _S1340 = _S1341;
            _S1341 = _S1342;
            _S1337 = _S1358;
            _S1342 = _S1367;
            _S1343 = _S1355.value0_19;
        }
        else
        {
            _S1352 = int(0);
            points_11[int(0)] = _S1334;
            points_11[int(1)] = _S1334;
            points_11[int(2)] = _S1334;
            points_11[int(3)] = _S1334;
            _runFlag_26 = false;
            _runFlag_27 = false;
            _runFlag_28 = false;
            _S1340 = _S1334;
            _S1341 = _S1334;
            _S1337 = false;
            _S1342 = _S1334;
            _S1343 = _S1334;
        }
        if(_S1352 != int(1))
        {
            _runFlag_29 = false;
        }
        else
        {
            _runFlag_29 = _S1336;
        }
        if(_runFlag_29)
        {
            float3  dx_5 = points_11[int(1)] - points_11[int(0)];
            float3  _S1368 = - (points_11[int(3)] - points_11[int(2)]);
            Tuple_9 _S1369 = s_apply_cross_0(dx_5, _S1368);
            s_bwdCallableCtx_cross_0 _S1370;
            (&_S1370)->_S68 = dx_5;
            (&_S1370)->_S69 = _S1368;
            s_bwdCallableCtx_cross_0 _S1371 = _S1370;
            Tuple_10 _S1372 = s_apply_dot_0(_S1369.value0_13, _S1369.value0_13);
            s_bwdCallableCtx_dot_0 _S1373;
            (&_S1373)->_S81 = _S1369.value0_13;
            (&_S1373)->_S82 = _S1369.value0_13;
            s_bwdCallableCtx_dot_0 _S1374 = _S1373;
            bool _S1375 = (_S1372.value0_14) != 0.0f;
            if(_S1375)
            {
                Tuple_5 _S1376 = s_apply_length_1(_S1369.value0_13);
                float3  _S1377 = make_float3 (_S1376.value0_7);
                s_bwdCallableCtx_length_0 _S1378;
                (&_S1378)->_S11 = _S1369.value0_13;
                _S1344 = make_float3 (_S1376.value0_7 * _S1376.value0_7);
                _S1345 = _S1377;
                _S1347 = _S1378;
            }
            else
            {
                _S1344 = _S1334;
                _S1345 = _S1334;
                (&_S1347)->_S11 = _S1334;
            }
            float3  _S1379 = _S1345;
            _S1338 = _S1375;
            _S1345 = _S1369.value0_13;
            _S1346 = _S1379;
            _S1348 = _S1374;
            _S1349 = _S1371;
        }
        else
        {
            _S1338 = false;
            _S1344 = _S1334;
            _S1345 = _S1334;
            _S1346 = _S1334;
            (&_S1347)->_S11 = _S1334;
            (&_S1348)->_S81 = _S1334;
            (&_S1348)->_S82 = _S1334;
            (&_S1349)->_S68 = _S1334;
            (&_S1349)->_S69 = _S1334;
        }
        bool _S1380 = _runFlag_26;
        bool _S1381 = _runFlag_27;
        bool _S1382 = _runFlag_28;
        float3  _S1383 = _S1340;
        float3  _S1384 = _S1341;
        bool _S1385 = _S1337;
        float3  _S1386 = _S1342;
        float3  _S1387 = _S1343;
        _runFlag_26 = _runFlag_29;
        _runFlag_27 = _S1338;
        _S1340 = _S1344;
        _S1341 = _S1345;
        _S1342 = _S1346;
        _runFlag_28 = _S1351;
        _S1337 = _S1380;
        _runFlag_29 = _S1381;
        _S1338 = _S1382;
        _S1343 = _S1383;
        _S1344 = _S1384;
        _S1339 = _S1385;
        _S1345 = _S1386;
        _S1346 = _S1387;
    }
    else
    {
        _runFlag_26 = false;
        _runFlag_27 = false;
        _S1340 = _S1334;
        _S1341 = _S1334;
        _S1342 = _S1334;
        (&_S1347)->_S11 = _S1334;
        (&_S1348)->_S81 = _S1334;
        (&_S1348)->_S82 = _S1334;
        (&_S1349)->_S68 = _S1334;
        (&_S1349)->_S69 = _S1334;
        _runFlag_28 = false;
        _S1337 = false;
        _runFlag_29 = false;
        _S1338 = false;
        _S1343 = _S1334;
        _S1344 = _S1334;
        _S1339 = false;
        _S1345 = _S1334;
        _S1346 = _S1334;
    }
    FixedArray<float3 , 4>  _S1388;
    Array_dzero_1(&_S1388);
    FixedArray<float3 , 4>  _S1389 = _S1388;
    float4  _S1390 = make_float4 (0.0f);
    float4  _S1391;
    if(_S1336)
    {
        if(_runFlag_26)
        {
            if(_runFlag_27)
            {
                float3  _S1392 = _S1333 / _S1340;
                float3  _S1393 = _S1341 * - _S1392;
                float3  _S1394 = _S1342 * _S1392;
                float _S1395 = _S1393.x + _S1393.y + _S1393.z;
                float3  _S1396 = _S1334;
                s_bwdCallableCtx_length_0 _S1397 = _S1347;
                s_bwdProp_length_0(&_S1397, &_S1396, _S1395);
                _S1340 = _S1394 + _S1396;
            }
            else
            {
                _S1340 = _S1333;
            }
            float3  _S1398 = _S1334;
            float3  _S1399 = _S1334;
            s_bwdCallableCtx_dot_0 _S1400 = _S1348;
            s_bwdProp_dot_0(&_S1400, &_S1398, &_S1399, 0.0f);
            float3  _S1401 = _S1398 + _S1399 + _S1340;
            float3  _S1402 = _S1334;
            float3  _S1403 = _S1334;
            s_bwdCallableCtx_cross_0 _S1404 = _S1349;
            s_bwdProp_cross_0(&_S1404, &_S1402, &_S1403, _S1401);
            float3  s_diff_dy_T_5 = - _S1403;
            float3  _S1405 = - s_diff_dy_T_5;
            float3  _S1406 = - _S1402;
            FixedArray<float3 , 4>  _S1407 = _S1389;
            _S1407[int(2)] = _S1405;
            _S1407[int(3)] = s_diff_dy_T_5;
            _S1407[int(0)] = _S1406;
            _S1407[int(1)] = _S1402;
            FixedArray<float3 , 4>  _S1408 = _S1389;
            FixedArray<float3 , 4>  _S1409 = _S1407;
            FixedArray<float3 , 4>  _S1410;
            Array_dadd_1(&_S1408, &_S1409, &_S1410);
            points_11 = _S1410;
        }
        else
        {
            points_11 = _S1389;
        }
        if(_runFlag_28)
        {
            if(_S1337)
            {
                if(_runFlag_29)
                {
                    FixedArray<float3 , 4>  _S1411 = points_11;
                    FixedArray<float3 , 4>  _S1412 = _S1389;
                    FixedArray<float3 , 4>  _S1413;
                    Array_dadd_1(&_S1411, &_S1412, &_S1413);
                    FixedArray<float3 , 4>  _S1414 = _S1413;
                    if(_S1338)
                    {
                        points_11 = _S1414;
                        points_11[int(3)] = _S1334;
                        float3  _S1415 = _S1343 * _S1414[int(3)];
                        float _S1416 = _S1415.x + _S1415.y + _S1415.z;
                        FixedArray<float3 , 4>  _S1417 = points_11;
                        FixedArray<float3 , 4>  _S1418 = _S1389;
                        FixedArray<float3 , 4>  _S1419;
                        Array_dadd_1(&_S1417, &_S1418, &_S1419);
                        float4  _S1420 = _S1390;
                        *&((&_S1420)->w) = _S1416;
                        points_11 = _S1419;
                        _S1391 = _S1420;
                    }
                    else
                    {
                        FixedArray<float3 , 4>  _S1421 = _S1414;
                        FixedArray<float3 , 4>  _S1422 = _S1389;
                        FixedArray<float3 , 4>  _S1423;
                        Array_dadd_1(&_S1421, &_S1422, &_S1423);
                        points_11 = _S1423;
                        _S1391 = _S1390;
                    }
                    FixedArray<float3 , 4>  _S1424 = points_11;
                    points_11[int(2)] = _S1334;
                    float3  _S1425 = _S1344 * _S1424[int(2)];
                    float _S1426 = _S1425.x + _S1425.y + _S1425.z;
                    FixedArray<float3 , 4>  _S1427 = points_11;
                    FixedArray<float3 , 4>  _S1428 = _S1389;
                    FixedArray<float3 , 4>  _S1429;
                    Array_dadd_1(&_S1427, &_S1428, &_S1429);
                    float4  _S1430 = _S1390;
                    *&((&_S1430)->z) = _S1426;
                    float4  _S1431 = _S1391 + _S1430;
                    points_11 = _S1429;
                    _S1391 = _S1431;
                }
                else
                {
                    FixedArray<float3 , 4>  _S1432 = points_11;
                    FixedArray<float3 , 4>  _S1433 = _S1389;
                    FixedArray<float3 , 4>  _S1434;
                    Array_dadd_1(&_S1432, &_S1433, &_S1434);
                    points_11 = _S1434;
                    _S1391 = _S1390;
                }
            }
            else
            {
                FixedArray<float3 , 4>  _S1435 = points_11;
                FixedArray<float3 , 4>  _S1436 = _S1389;
                FixedArray<float3 , 4>  _S1437;
                Array_dadd_1(&_S1435, &_S1436, &_S1437);
                points_11 = _S1437;
                _S1391 = _S1390;
            }
            if(_S1339)
            {
                FixedArray<float3 , 4>  _S1438 = points_11;
                float3  _S1439 = _S1345 * points_11[int(1)];
                float _S1440 = _S1439.x + _S1439.y + _S1439.z;
                float4  _S1441 = _S1390;
                *&((&_S1441)->y) = _S1440;
                float4  _S1442 = _S1391 + _S1441;
                points_11 = _S1389;
                _S1340 = _S1438[int(0)];
                _S1391 = _S1442;
            }
            else
            {
                FixedArray<float3 , 4>  _S1443 = points_11;
                FixedArray<float3 , 4>  _S1444 = _S1389;
                FixedArray<float3 , 4>  _S1445;
                Array_dadd_1(&_S1443, &_S1444, &_S1445);
                points_11 = _S1445;
                _S1340 = _S1334;
            }
            float3  _S1446 = _S1346 * (points_11[int(0)] + _S1340);
            float _S1447 = _S1446.x + _S1446.y + _S1446.z;
            float4  _S1448 = _S1390;
            *&((&_S1448)->x) = _S1447;
            _S1391 = _S1391 + _S1448;
        }
        else
        {
            _S1391 = _S1390;
        }
    }
    else
    {
        _S1391 = _S1390;
    }
    *_S1332 = _S1391;
    return;
}

inline __device__ void _S1449(float2  _S1450, float4  _S1451, FixedArray<float, 4>  * _S1452, int _S1453, bool _S1454, DiffPair_vectorx3Cfloatx2C4x3E_0 * _S1455, float3  _S1456)
{
    float4  _S1457 = _S1455->primal_0;
    Tuple_16 _S1458 = s_apply_depth_to_normal_2(_S1450, _S1451, _S1452, _S1453, _S1454, _S1455->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_to_normal_0 _S1459;
    (&_S1459)->value1_6 = _S1453;
    (&_S1459)->value2_3 = _S1454;
    (&_S1459)->value3_3 = _S1457;
    s_bwdCallableCtx_depth_to_normal_0 _S1460;
    (&_S1460)->value0_24 = _S1459;
    (&_S1460)->value1_7 = _S1458.value1_5;
    s_bwdProp_depth_to_normal_2(&_S1460, &_S1455->differential_0, _S1456);
    return;
}

inline __device__ Tuple_17 s_apply_depth_to_point_2(float2  pix_pos_2, float4  intrins_8, FixedArray<float, 4>  * dist_coeffs_11, int camera_model_9, bool is_ray_depth_9, float _S1461)
{
    float2  _S1462 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_to_point_0 _S1463;
    (&_S1463)->value0_25 = false;
    (&_S1463)->value1_8 = _S1462;
    float2  uv_35 = (pix_pos_2 - float2 {intrins_8.z, intrins_8.w}) / float2 {intrins_8.x, intrins_8.y};
    float2  _S1464 = _S1462;
    bool _S1465 = undistort_point_2(uv_35, dist_coeffs_11, int(12), &_S1464);
    (&_S1463)->value0_25 = _S1465;
    float2  uv_u_29 = _S1464;
    (&_S1463)->value1_8 = _S1464;
    bool _S1466 = !_S1465;
    float3  _S1467;
    if(_S1466)
    {
        _S1467 = make_float3 (0.0f);
    }
    bool _S1468 = !_S1466;
    if(_S1468)
    {
        _S1467 = make_float3 (_S1461) * s_apply_unproject_raydir_0(uv_u_29, camera_model_9, is_ray_depth_9).value0_19;
    }
    Tuple_17 _S1469;
    (&_S1469)->value0_26 = _S1467;
    (&_S1469)->value1_9 = _S1463;
    return _S1469;
}

inline __device__ void s_bwdProp_depth_to_point_2(s_bwdCallableCtx_depth_to_point_0 * _S1470, float * _S1471, float3  _S1472)
{
    float3  _S1473 = make_float3 (0.0f);
    bool _S1474 = !!(&_S1470->value1_11)->value0_25;
    float3  _S1475;
    if(_S1474)
    {
        _S1475 = s_apply_unproject_raydir_0((&_S1470->value1_11)->value1_8, (&_S1470->value0_28)->value0_27, (&_S1470->value0_28)->value1_10).value0_19;
    }
    else
    {
        _S1475 = _S1473;
    }
    if(_S1474)
    {
        _S1475 = _S1475 * _S1472;
    }
    else
    {
        _S1475 = _S1473;
    }
    *_S1471 = _S1475.x + _S1475.y + _S1475.z;
    return;
}

inline __device__ void _S1476(float2  _S1477, float4  _S1478, FixedArray<float, 4>  * _S1479, int _S1480, bool _S1481, DiffPair_float_0 * _S1482, float3  _S1483)
{
    Tuple_17 _S1484 = s_apply_depth_to_point_2(_S1477, _S1478, _S1479, _S1480, _S1481, _S1482->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_to_point_0 _S1485;
    (&_S1485)->value0_27 = _S1480;
    (&_S1485)->value1_10 = _S1481;
    s_bwdCallableCtx_depth_to_point_0 _S1486;
    (&_S1486)->value0_28 = _S1485;
    (&_S1486)->value1_11 = _S1484.value1_9;
    s_bwdProp_depth_to_point_2(&_S1486, &_S1482->differential_0, _S1483);
    return;
}

inline __device__ bool undistort_point_3(float2  uv_36, FixedArray<float, 1>  * dist_coeffs_12, int maxiter_3, float2  * uv_undist_3)
{
    *uv_undist_3 = uv_36;
    return true;
}

inline __device__ Tuple_13 s_apply_depth_normal_loss_3(float2  pix_center_6, float4  intrins_9, FixedArray<float, 1>  * dist_coeffs_13, int camera_model_10, bool is_ray_depth_10, float4  _S1487, float3  _S1488)
{
    float2  _S1489 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_normal_loss_0 _S1490;
    (&_S1490)->value0_17 = false;
    (&_S1490)->value1_0 = _S1489;
    (&_S1490)->value2_0 = _S1489;
    (&_S1490)->value3_0 = false;
    (&_S1490)->value4_0 = _S1489;
    (&_S1490)->value5_0 = false;
    (&_S1490)->value6_0 = _S1489;
    (&_S1490)->value7_0 = false;
    (&_S1490)->value8_0 = _S1489;
    (&_S1490)->value9_0 = false;
    float3  _S1491 = make_float3 (0.0f);
    float2  _S1492 = float2 {intrins_9.z, intrins_9.w};
    float2  _S1493 = float2 {intrins_9.x, intrins_9.y};
    float2  uv_37 = (pix_center_6 + make_float2 (-1.0f, -0.0f) - _S1492) / _S1493;
    float2  _S1494 = _S1489;
    bool _S1495 = undistort_point_3(uv_37, dist_coeffs_13, int(12), &_S1494);
    (&_S1490)->value0_17 = _S1495;
    float2  uv_u_30 = _S1494;
    (&_S1490)->value1_0 = _S1494;
    bool _S1496 = !!_S1495;
    int _S1497;
    float3  raydir_7;
    FixedArray<float3 , 5>  points_12;
    if(_S1496)
    {
        Tuple_14 _S1498 = s_apply_unproject_raydir_0(uv_u_30, camera_model_10, is_ray_depth_10);
        float3  _S1499 = make_float3 (_S1487.x) * _S1498.value0_19;
        float2  uv_38 = (pix_center_6 + make_float2 (1.0f, -0.0f) - _S1492) / _S1493;
        float2  _S1500 = _S1489;
        bool _S1501 = undistort_point_3(uv_38, dist_coeffs_13, int(12), &_S1500);
        (&_S1490)->value2_0 = _S1500;
        (&_S1490)->value3_0 = _S1501;
        float2  uv_u_31 = _S1500;
        bool _runFlag_30;
        if(!_S1501)
        {
            _runFlag_30 = false;
        }
        else
        {
            _runFlag_30 = _S1496;
        }
        if(_runFlag_30)
        {
            Tuple_14 _S1502 = s_apply_unproject_raydir_0(uv_u_31, camera_model_10, is_ray_depth_10);
            float3  _S1503 = make_float3 (_S1487.y) * _S1502.value0_19;
            float2  uv_39 = (pix_center_6 + make_float2 (0.0f, -1.0f) - _S1492) / _S1493;
            float2  _S1504 = _S1489;
            bool _S1505 = undistort_point_3(uv_39, dist_coeffs_13, int(12), &_S1504);
            (&_S1490)->value4_0 = _S1504;
            (&_S1490)->value5_0 = _S1505;
            float2  uv_u_32 = _S1504;
            if(!_S1505)
            {
                _runFlag_30 = false;
            }
            if(_runFlag_30)
            {
                Tuple_14 _S1506 = s_apply_unproject_raydir_0(uv_u_32, camera_model_10, is_ray_depth_10);
                float3  _S1507 = make_float3 (_S1487.z) * _S1506.value0_19;
                float2  uv_40 = (pix_center_6 + make_float2 (0.0f, 1.0f) - _S1492) / _S1493;
                float2  _S1508 = _S1489;
                bool _S1509 = undistort_point_3(uv_40, dist_coeffs_13, int(12), &_S1508);
                (&_S1490)->value6_0 = _S1508;
                (&_S1490)->value7_0 = _S1509;
                float2  uv_u_33 = _S1508;
                if(!_S1509)
                {
                    _runFlag_30 = false;
                }
                if(_runFlag_30)
                {
                    Tuple_14 _S1510 = s_apply_unproject_raydir_0(uv_u_33, camera_model_10, is_ray_depth_10);
                    float3  _S1511 = make_float3 (_S1487.w) * _S1510.value0_19;
                    float2  uv_41 = (pix_center_6 - _S1492) / _S1493;
                    float2  _S1512 = _S1489;
                    bool _S1513 = undistort_point_3(uv_41, dist_coeffs_13, int(12), &_S1512);
                    (&_S1490)->value8_0 = _S1512;
                    (&_S1490)->value9_0 = _S1513;
                    float2  uv_u_34 = _S1512;
                    if(!_S1513)
                    {
                        _runFlag_30 = false;
                    }
                    if(_runFlag_30)
                    {
                        Tuple_14 _S1514 = s_apply_unproject_raydir_0(uv_u_34, camera_model_10, is_ray_depth_10);
                        _S1497 = int(1);
                        raydir_7 = _S1514.value0_19;
                    }
                    else
                    {
                        _S1497 = int(0);
                        raydir_7 = _S1510.value0_19;
                    }
                    points_12[int(0)] = _S1499;
                    points_12[int(1)] = _S1503;
                    points_12[int(2)] = _S1507;
                    points_12[int(3)] = _S1511;
                    points_12[int(4)] = _S1491;
                }
                else
                {
                    _S1497 = int(0);
                    raydir_7 = _S1506.value0_19;
                    points_12[int(0)] = _S1499;
                    points_12[int(1)] = _S1503;
                    points_12[int(2)] = _S1507;
                    points_12[int(3)] = _S1491;
                    points_12[int(4)] = _S1491;
                }
            }
            else
            {
                _S1497 = int(0);
                raydir_7 = _S1502.value0_19;
                points_12[int(0)] = _S1499;
                points_12[int(1)] = _S1503;
                points_12[int(2)] = _S1491;
                points_12[int(3)] = _S1491;
                points_12[int(4)] = _S1491;
            }
        }
        else
        {
            _S1497 = int(0);
            raydir_7 = _S1498.value0_19;
            points_12[int(0)] = _S1499;
            points_12[int(1)] = _S1491;
            points_12[int(2)] = _S1491;
            points_12[int(3)] = _S1491;
            points_12[int(4)] = _S1491;
        }
    }
    else
    {
        _S1497 = int(0);
        points_12[int(0)] = _S1491;
        points_12[int(1)] = _S1491;
        points_12[int(2)] = _S1491;
        points_12[int(3)] = _S1491;
        points_12[int(4)] = _S1491;
    }
    float _S1515;
    if(!(_S1497 != int(1)))
    {
        Tuple_9 _S1516 = s_apply_cross_0(points_12[int(1)] - points_12[int(0)], - (points_12[int(3)] - points_12[int(2)]));
        float3  _S1517 = _S1516.value0_13;
        float3  normal_9;
        if((s_apply_dot_0(_S1517, _S1517).value0_14) != 0.0f)
        {
            normal_9 = s_apply_normalize_0(_S1516.value0_13).value0_4;
        }
        else
        {
            normal_9 = _S1516.value0_13;
        }
        float3  _S1518;
        if((s_apply_dot_0(_S1488, _S1488).value0_14) != 0.0f)
        {
            _S1518 = s_apply_normalize_0(_S1488).value0_4;
        }
        else
        {
            _S1518 = _S1488;
        }
        _S1515 = (1.0f - s_apply_dot_0(normal_9, _S1518).value0_14 + 0.00100000004749745f) / (s_apply_max_0(s_apply_dot_0(normal_9, - s_apply_normalize_0(raydir_7).value0_4).value0_14, 0.0f).value0_16 + 0.00100000004749745f);
    }
    else
    {
        _S1515 = 0.0f;
    }
    Tuple_13 _S1519;
    (&_S1519)->value0_18 = _S1515;
    (&_S1519)->value1_1 = _S1490;
    return _S1519;
}

inline __device__ void s_bwdProp_depth_normal_loss_3(s_bwdCallableCtx_depth_normal_loss_0 * _S1520, float4  * _S1521, float3  * _S1522, float _S1523)
{
    float3  _S1524 = make_float3 (0.0f);
    bool _S1525 = !!(&_S1520->value1_3)->value0_17;
    bool _runFlag_31;
    bool _runFlag_32;
    bool _runFlag_33;
    bool _runFlag_34;
    int _S1526;
    float3  raydir_8;
    float3  _S1527;
    float3  _S1528;
    float3  _S1529;
    float3  _S1530;
    FixedArray<float3 , 5>  points_13;
    if(_S1525)
    {
        bool _S1531 = (&_S1520->value0_21)->value2_1;
        int _S1532 = (&_S1520->value0_21)->value1_2;
        Tuple_14 _S1533 = s_apply_unproject_raydir_0((&_S1520->value1_3)->value1_0, (&_S1520->value0_21)->value1_2, (&_S1520->value0_21)->value2_1);
        float3  _S1534 = make_float3 (*&((&(&_S1520->value0_21)->value3_1)->x)) * _S1533.value0_19;
        float2  _S1535 = (&_S1520->value1_3)->value2_0;
        if(!(&_S1520->value1_3)->value3_0)
        {
            _runFlag_31 = false;
        }
        else
        {
            _runFlag_31 = _S1525;
        }
        if(_runFlag_31)
        {
            Tuple_14 _S1536 = s_apply_unproject_raydir_0(_S1535, _S1532, _S1531);
            float3  _S1537 = make_float3 (*&((&(&_S1520->value0_21)->value3_1)->y)) * _S1536.value0_19;
            float2  _S1538 = (&_S1520->value1_3)->value4_0;
            if(!(&_S1520->value1_3)->value5_0)
            {
                _runFlag_32 = false;
            }
            else
            {
                _runFlag_32 = _runFlag_31;
            }
            if(_runFlag_32)
            {
                Tuple_14 _S1539 = s_apply_unproject_raydir_0(_S1538, _S1532, _S1531);
                float3  _S1540 = make_float3 (*&((&(&_S1520->value0_21)->value3_1)->z)) * _S1539.value0_19;
                float2  _S1541 = (&_S1520->value1_3)->value6_0;
                if(!(&_S1520->value1_3)->value7_0)
                {
                    _runFlag_33 = false;
                }
                else
                {
                    _runFlag_33 = _runFlag_32;
                }
                if(_runFlag_33)
                {
                    Tuple_14 _S1542 = s_apply_unproject_raydir_0(_S1541, _S1532, _S1531);
                    float3  _S1543 = make_float3 (*&((&(&_S1520->value0_21)->value3_1)->w)) * _S1542.value0_19;
                    float2  _S1544 = (&_S1520->value1_3)->value8_0;
                    if(!(&_S1520->value1_3)->value9_0)
                    {
                        _runFlag_34 = false;
                    }
                    else
                    {
                        _runFlag_34 = _runFlag_33;
                    }
                    if(_runFlag_34)
                    {
                        Tuple_14 _S1545 = s_apply_unproject_raydir_0(_S1544, _S1532, _S1531);
                        _S1526 = int(1);
                        raydir_8 = _S1545.value0_19;
                    }
                    else
                    {
                        _S1526 = int(0);
                        raydir_8 = _S1542.value0_19;
                    }
                    points_13[int(0)] = _S1534;
                    points_13[int(1)] = _S1537;
                    points_13[int(2)] = _S1540;
                    points_13[int(3)] = _S1543;
                    points_13[int(4)] = _S1524;
                    _S1527 = _S1542.value0_19;
                }
                else
                {
                    _S1526 = int(0);
                    raydir_8 = _S1539.value0_19;
                    points_13[int(0)] = _S1534;
                    points_13[int(1)] = _S1537;
                    points_13[int(2)] = _S1540;
                    points_13[int(3)] = _S1524;
                    points_13[int(4)] = _S1524;
                    _S1527 = _S1524;
                }
                _S1528 = _S1539.value0_19;
            }
            else
            {
                _S1526 = int(0);
                raydir_8 = _S1536.value0_19;
                points_13[int(0)] = _S1534;
                points_13[int(1)] = _S1537;
                points_13[int(2)] = _S1524;
                points_13[int(3)] = _S1524;
                points_13[int(4)] = _S1524;
                _runFlag_33 = false;
                _S1527 = _S1524;
                _S1528 = _S1524;
            }
            _S1529 = _S1536.value0_19;
        }
        else
        {
            _S1526 = int(0);
            raydir_8 = _S1533.value0_19;
            points_13[int(0)] = _S1534;
            points_13[int(1)] = _S1524;
            points_13[int(2)] = _S1524;
            points_13[int(3)] = _S1524;
            points_13[int(4)] = _S1524;
            _runFlag_32 = false;
            _runFlag_33 = false;
            _S1527 = _S1524;
            _S1528 = _S1524;
            _S1529 = _S1524;
        }
        _S1530 = _S1533.value0_19;
    }
    else
    {
        _S1526 = int(0);
        points_13[int(0)] = _S1524;
        points_13[int(1)] = _S1524;
        points_13[int(2)] = _S1524;
        points_13[int(3)] = _S1524;
        points_13[int(4)] = _S1524;
        _runFlag_31 = false;
        _runFlag_32 = false;
        _runFlag_33 = false;
        _S1527 = _S1524;
        _S1528 = _S1524;
        _S1529 = _S1524;
        _S1530 = _S1524;
    }
    bool _S1546 = !(_S1526 != int(1));
    bool _S1547;
    float3  normal_10;
    float3  _S1548;
    s_bwdCallableCtx_normalize_0 _S1549;
    s_bwdCallableCtx_normalize_0 _S1550;
    float _S1551;
    float _S1552;
    float _S1553;
    s_bwdCallableCtx_max_0 _S1554;
    s_bwdCallableCtx_dot_0 _S1555;
    s_bwdCallableCtx_dot_0 _S1556;
    s_bwdCallableCtx_dot_0 _S1557;
    s_bwdCallableCtx_dot_0 _S1558;
    s_bwdCallableCtx_cross_0 _S1559;
    if(_S1546)
    {
        float3  dx_6 = points_13[int(1)] - points_13[int(0)];
        float3  _S1560 = - (points_13[int(3)] - points_13[int(2)]);
        Tuple_9 _S1561 = s_apply_cross_0(dx_6, _S1560);
        s_bwdCallableCtx_cross_0 _S1562;
        (&_S1562)->_S68 = dx_6;
        (&_S1562)->_S69 = _S1560;
        s_bwdCallableCtx_cross_0 _S1563 = _S1562;
        Tuple_10 _S1564 = s_apply_dot_0(_S1561.value0_13, _S1561.value0_13);
        s_bwdCallableCtx_dot_0 _S1565;
        (&_S1565)->_S81 = _S1561.value0_13;
        (&_S1565)->_S82 = _S1561.value0_13;
        s_bwdCallableCtx_dot_0 _S1566 = _S1565;
        bool _S1567 = (_S1564.value0_14) != 0.0f;
        if(_S1567)
        {
            Tuple_4 _S1568 = s_apply_normalize_0(_S1561.value0_13);
            s_bwdCallableCtx_normalize_0 _S1569;
            (&_S1569)->_S9 = _S1561.value0_13;
            normal_10 = _S1568.value0_4;
            _S1549 = _S1569;
        }
        else
        {
            normal_10 = _S1561.value0_13;
            (&_S1549)->_S9 = _S1524;
        }
        float3  _S1570 = (&_S1520->value0_21)->value4_1;
        Tuple_10 _S1571 = s_apply_dot_0((&_S1520->value0_21)->value4_1, (&_S1520->value0_21)->value4_1);
        s_bwdCallableCtx_dot_0 _S1572;
        (&_S1572)->_S81 = (&_S1520->value0_21)->value4_1;
        (&_S1572)->_S82 = (&_S1520->value0_21)->value4_1;
        s_bwdCallableCtx_dot_0 _S1573 = _S1572;
        bool _S1574 = (_S1571.value0_14) != 0.0f;
        if(_S1574)
        {
            Tuple_4 _S1575 = s_apply_normalize_0(_S1570);
            s_bwdCallableCtx_normalize_0 _S1576;
            (&_S1576)->_S9 = _S1570;
            _S1548 = _S1575.value0_4;
            _S1550 = _S1576;
        }
        else
        {
            _S1548 = _S1570;
            (&_S1550)->_S9 = _S1524;
        }
        Tuple_10 _S1577 = s_apply_dot_0(normal_10, _S1548);
        s_bwdCallableCtx_dot_0 _S1578;
        (&_S1578)->_S81 = normal_10;
        (&_S1578)->_S82 = _S1548;
        float num_3 = 1.0f - _S1577.value0_14;
        float3  _S1579 = - s_apply_normalize_0(raydir_8).value0_4;
        Tuple_10 _S1580 = s_apply_dot_0(normal_10, _S1579);
        s_bwdCallableCtx_dot_0 _S1581;
        (&_S1581)->_S81 = normal_10;
        (&_S1581)->_S82 = _S1579;
        float _S1582 = num_3 + 0.00100000004749745f;
        Tuple_12 _S1583 = s_apply_max_0(_S1580.value0_14, 0.0f);
        s_bwdCallableCtx_max_0 _S1584;
        (&_S1584)->_S94 = _S1580.value0_14;
        (&_S1584)->_S95 = 0.0f;
        float _S1585 = _S1583.value0_16 + 0.00100000004749745f;
        s_bwdCallableCtx_normalize_0 _S1586 = _S1549;
        _S1551 = _S1585 * _S1585;
        _S1552 = _S1582;
        _S1553 = _S1585;
        _S1554 = _S1584;
        _S1555 = _S1581;
        _S1556 = _S1578;
        _runFlag_34 = _S1574;
        _S1549 = _S1550;
        _S1557 = _S1573;
        _S1547 = _S1567;
        _S1550 = _S1586;
        _S1558 = _S1566;
        _S1559 = _S1563;
    }
    else
    {
        _S1551 = 0.0f;
        _S1552 = 0.0f;
        _S1553 = 0.0f;
        (&_S1554)->_S94 = 0.0f;
        (&_S1554)->_S95 = 0.0f;
        (&_S1555)->_S81 = _S1524;
        (&_S1555)->_S82 = _S1524;
        (&_S1556)->_S81 = _S1524;
        (&_S1556)->_S82 = _S1524;
        _runFlag_34 = false;
        (&_S1549)->_S9 = _S1524;
        (&_S1557)->_S81 = _S1524;
        (&_S1557)->_S82 = _S1524;
        _S1547 = false;
        (&_S1550)->_S9 = _S1524;
        (&_S1558)->_S81 = _S1524;
        (&_S1558)->_S82 = _S1524;
        (&_S1559)->_S68 = _S1524;
        (&_S1559)->_S69 = _S1524;
    }
    float4  _S1587 = make_float4 (0.0f);
    FixedArray<float3 , 5>  _S1588;
    Array_dzero_0(&_S1588);
    FixedArray<float3 , 5>  _S1589 = _S1588;
    if(_S1546)
    {
        float _S1590 = _S1523 / _S1551;
        float _S1591 = _S1552 * - _S1590;
        float s_diff_num_T_3 = _S1553 * _S1590;
        float _S1592 = 0.0f;
        float _S1593 = 0.0f;
        s_bwdCallableCtx_max_0 _S1594 = _S1554;
        s_bwdProp_max_0(&_S1594, &_S1592, &_S1593, _S1591);
        float3  _S1595 = _S1524;
        float3  _S1596 = _S1524;
        s_bwdCallableCtx_dot_0 _S1597 = _S1555;
        s_bwdProp_dot_0(&_S1597, &_S1595, &_S1596, _S1592);
        float _S1598 = - s_diff_num_T_3;
        float3  _S1599 = _S1524;
        float3  _S1600 = _S1524;
        s_bwdCallableCtx_dot_0 _S1601 = _S1556;
        s_bwdProp_dot_0(&_S1601, &_S1599, &_S1600, _S1598);
        float3  _S1602 = _S1600;
        float3  _S1603 = _S1595 + _S1599;
        if(_runFlag_34)
        {
            float3  _S1604 = _S1524;
            s_bwdCallableCtx_normalize_0 _S1605 = _S1549;
            s_bwdProp_normalize_0(&_S1605, &_S1604, _S1602);
            raydir_8 = _S1604;
        }
        else
        {
            raydir_8 = _S1602;
        }
        float3  _S1606 = _S1524;
        float3  _S1607 = _S1524;
        s_bwdCallableCtx_dot_0 _S1608 = _S1557;
        s_bwdProp_dot_0(&_S1608, &_S1606, &_S1607, 0.0f);
        float3  _S1609 = _S1606 + _S1607 + raydir_8;
        if(_S1547)
        {
            float3  _S1610 = _S1524;
            s_bwdCallableCtx_normalize_0 _S1611 = _S1550;
            s_bwdProp_normalize_0(&_S1611, &_S1610, _S1603);
            raydir_8 = _S1610;
        }
        else
        {
            raydir_8 = _S1603;
        }
        float3  _S1612 = _S1524;
        float3  _S1613 = _S1524;
        s_bwdCallableCtx_dot_0 _S1614 = _S1558;
        s_bwdProp_dot_0(&_S1614, &_S1612, &_S1613, 0.0f);
        float3  _S1615 = _S1612 + _S1613 + raydir_8;
        float3  _S1616 = _S1524;
        float3  _S1617 = _S1524;
        s_bwdCallableCtx_cross_0 _S1618 = _S1559;
        s_bwdProp_cross_0(&_S1618, &_S1616, &_S1617, _S1615);
        float3  s_diff_dy_T_6 = - _S1617;
        float3  _S1619 = - s_diff_dy_T_6;
        float3  _S1620 = - _S1616;
        FixedArray<float3 , 5>  _S1621 = _S1589;
        _S1621[int(2)] = _S1619;
        _S1621[int(3)] = s_diff_dy_T_6;
        _S1621[int(0)] = _S1620;
        _S1621[int(1)] = _S1616;
        FixedArray<float3 , 5>  _S1622 = _S1589;
        FixedArray<float3 , 5>  _S1623 = _S1621;
        FixedArray<float3 , 5>  _S1624;
        Array_dadd_0(&_S1622, &_S1623, &_S1624);
        points_13 = _S1624;
        raydir_8 = _S1609;
    }
    else
    {
        points_13 = _S1589;
        raydir_8 = _S1524;
    }
    float4  _S1625;
    if(_S1525)
    {
        if(_runFlag_31)
        {
            if(_runFlag_32)
            {
                if(_runFlag_33)
                {
                    FixedArray<float3 , 5>  _S1626 = points_13;
                    FixedArray<float3 , 5>  _S1627 = _S1589;
                    FixedArray<float3 , 5>  _S1628;
                    Array_dadd_0(&_S1626, &_S1627, &_S1628);
                    float3  _S1629 = _S1527 * _S1628[int(3)];
                    float _S1630 = _S1629.x + _S1629.y + _S1629.z;
                    float4  _S1631 = _S1587;
                    *&((&_S1631)->w) = _S1630;
                    points_13 = _S1589;
                    _S1527 = _S1628[int(2)];
                    normal_10 = _S1628[int(0)];
                    _S1548 = _S1628[int(1)];
                    _S1625 = _S1631;
                }
                else
                {
                    FixedArray<float3 , 5>  _S1632 = points_13;
                    FixedArray<float3 , 5>  _S1633 = _S1589;
                    FixedArray<float3 , 5>  _S1634;
                    Array_dadd_0(&_S1632, &_S1633, &_S1634);
                    points_13 = _S1634;
                    _S1527 = _S1524;
                    normal_10 = _S1524;
                    _S1548 = _S1524;
                    _S1625 = _S1587;
                }
                float3  _S1635 = _S1528 * (points_13[int(2)] + _S1527);
                float _S1636 = _S1635.x + _S1635.y + _S1635.z;
                float3  _S1637 = points_13[int(0)] + normal_10;
                float3  _S1638 = points_13[int(1)] + _S1548;
                float4  _S1639 = _S1587;
                *&((&_S1639)->z) = _S1636;
                float4  _S1640 = _S1625 + _S1639;
                points_13 = _S1589;
                _S1527 = _S1638;
                _S1528 = _S1637;
                _S1625 = _S1640;
            }
            else
            {
                FixedArray<float3 , 5>  _S1641 = points_13;
                FixedArray<float3 , 5>  _S1642 = _S1589;
                FixedArray<float3 , 5>  _S1643;
                Array_dadd_0(&_S1641, &_S1642, &_S1643);
                points_13 = _S1643;
                _S1527 = _S1524;
                _S1528 = _S1524;
                _S1625 = _S1587;
            }
            float3  _S1644 = _S1529 * (points_13[int(1)] + _S1527);
            float _S1645 = _S1644.x + _S1644.y + _S1644.z;
            float3  _S1646 = points_13[int(0)] + _S1528;
            float4  _S1647 = _S1587;
            *&((&_S1647)->y) = _S1645;
            float4  _S1648 = _S1625 + _S1647;
            points_13 = _S1589;
            _S1527 = _S1646;
            _S1625 = _S1648;
        }
        else
        {
            FixedArray<float3 , 5>  _S1649 = points_13;
            FixedArray<float3 , 5>  _S1650 = _S1589;
            FixedArray<float3 , 5>  _S1651;
            Array_dadd_0(&_S1649, &_S1650, &_S1651);
            points_13 = _S1651;
            _S1527 = _S1524;
            _S1625 = _S1587;
        }
        float3  _S1652 = _S1530 * (points_13[int(0)] + _S1527);
        float _S1653 = _S1652.x + _S1652.y + _S1652.z;
        float4  _S1654 = _S1587;
        *&((&_S1654)->x) = _S1653;
        _S1625 = _S1625 + _S1654;
    }
    else
    {
        _S1625 = _S1587;
    }
    *_S1521 = _S1625;
    *_S1522 = raydir_8;
    return;
}

inline __device__ void _S1655(float2  _S1656, float4  _S1657, FixedArray<float, 1>  * _S1658, int _S1659, bool _S1660, DiffPair_vectorx3Cfloatx2C4x3E_0 * _S1661, DiffPair_vectorx3Cfloatx2C3x3E_0 * _S1662, float _S1663)
{
    float4  _S1664 = _S1661->primal_0;
    float3  _S1665 = _S1662->primal_0;
    Tuple_13 _S1666 = s_apply_depth_normal_loss_3(_S1656, _S1657, _S1658, _S1659, _S1660, _S1661->primal_0, _S1662->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_normal_loss_0 _S1667;
    (&_S1667)->value1_2 = _S1659;
    (&_S1667)->value2_1 = _S1660;
    (&_S1667)->value3_1 = _S1664;
    (&_S1667)->value4_1 = _S1665;
    s_bwdCallableCtx_depth_normal_loss_0 _S1668;
    (&_S1668)->value0_21 = _S1667;
    (&_S1668)->value1_3 = _S1666.value1_1;
    s_bwdProp_depth_normal_loss_3(&_S1668, &_S1661->differential_0, &_S1662->differential_0, _S1663);
    return;
}

inline __device__ Tuple_16 s_apply_depth_to_normal_3(float2  pix_center_7, float4  intrins_10, FixedArray<float, 1>  * dist_coeffs_14, int camera_model_11, bool is_ray_depth_11, float4  _S1669)
{
    float2  _S1670 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_to_normal_0 _S1671;
    (&_S1671)->value0_22 = _S1670;
    (&_S1671)->value1_4 = false;
    (&_S1671)->value2_2 = _S1670;
    (&_S1671)->value3_2 = false;
    (&_S1671)->value4_2 = _S1670;
    (&_S1671)->value5_1 = false;
    (&_S1671)->value6_1 = _S1670;
    (&_S1671)->value7_1 = false;
    float3  _S1672 = make_float3 (0.0f);
    bool _runFlag_35;
    if((_S1669.x) == 0.0f)
    {
        _runFlag_35 = true;
    }
    else
    {
        _runFlag_35 = (_S1669.y) == 0.0f;
    }
    if(_runFlag_35)
    {
        _runFlag_35 = true;
    }
    else
    {
        _runFlag_35 = (_S1669.z) == 0.0f;
    }
    if(_runFlag_35)
    {
        _runFlag_35 = true;
    }
    else
    {
        _runFlag_35 = (_S1669.w) == 0.0f;
    }
    float3  normal_11;
    if(_runFlag_35)
    {
        normal_11 = make_float3 (0.0f);
    }
    bool _S1673 = !_runFlag_35;
    if(_S1673)
    {
        float2  _S1674 = float2 {intrins_10.z, intrins_10.w};
        float2  _S1675 = float2 {intrins_10.x, intrins_10.y};
        float2  uv_42 = (pix_center_7 + make_float2 (-1.0f, -0.0f) - _S1674) / _S1675;
        float2  _S1676 = _S1670;
        bool _S1677 = undistort_point_3(uv_42, dist_coeffs_14, int(12), &_S1676);
        (&_S1671)->value0_22 = _S1676;
        (&_S1671)->value1_4 = _S1677;
        float2  uv_u_35 = _S1676;
        bool _S1678 = !_S1677;
        if(_S1678)
        {
            normal_11 = make_float3 (0.0f);
        }
        bool _S1679 = !_S1678;
        int _S1680;
        FixedArray<float3 , 4>  points_14;
        if(_S1679)
        {
            float3  _S1681 = make_float3 (_S1669.x) * s_apply_unproject_raydir_0(uv_u_35, camera_model_11, is_ray_depth_11).value0_19;
            float2  uv_43 = (pix_center_7 + make_float2 (1.0f, -0.0f) - _S1674) / _S1675;
            float2  _S1682 = _S1670;
            bool _S1683 = undistort_point_3(uv_43, dist_coeffs_14, int(12), &_S1682);
            (&_S1671)->value2_2 = _S1682;
            (&_S1671)->value3_2 = _S1683;
            float2  uv_u_36 = _S1682;
            bool _S1684 = !_S1683;
            if(_S1684)
            {
                normal_11 = make_float3 (0.0f);
            }
            bool _S1685 = !_S1684;
            if(_S1685)
            {
                float3  _S1686 = make_float3 (_S1669.y) * s_apply_unproject_raydir_0(uv_u_36, camera_model_11, is_ray_depth_11).value0_19;
                _S1680 = int(2);
                points_14[int(0)] = _S1681;
                points_14[int(1)] = _S1686;
                points_14[int(2)] = _S1672;
                points_14[int(3)] = _S1672;
            }
            else
            {
                _S1680 = int(0);
                points_14[int(0)] = _S1681;
                points_14[int(1)] = _S1672;
                points_14[int(2)] = _S1672;
                points_14[int(3)] = _S1672;
            }
            if(_S1680 != int(2))
            {
                _runFlag_35 = false;
            }
            else
            {
                _runFlag_35 = _S1679;
                _S1680 = int(0);
            }
            if(_runFlag_35)
            {
                float2  uv_44 = (pix_center_7 + make_float2 (0.0f, -1.0f) - _S1674) / _S1675;
                float2  _S1687 = _S1670;
                bool _S1688 = undistort_point_3(uv_44, dist_coeffs_14, int(12), &_S1687);
                (&_S1671)->value4_2 = _S1687;
                (&_S1671)->value5_1 = _S1688;
                float2  uv_u_37 = _S1687;
                if(!_S1688)
                {
                    float3  _S1689 = make_float3 (0.0f);
                    _runFlag_35 = false;
                    _S1680 = int(0);
                    normal_11 = _S1689;
                }
                if(_runFlag_35)
                {
                    points_14[int(2)] = make_float3 (_S1669.z) * s_apply_unproject_raydir_0(uv_u_37, camera_model_11, is_ray_depth_11).value0_19;
                    float2  uv_45 = (pix_center_7 + make_float2 (0.0f, 1.0f) - _S1674) / _S1675;
                    float2  _S1690 = _S1670;
                    bool _S1691 = undistort_point_3(uv_45, dist_coeffs_14, int(12), &_S1690);
                    (&_S1671)->value6_1 = _S1690;
                    (&_S1671)->value7_1 = _S1691;
                    float2  uv_u_38 = _S1690;
                    bool _S1692 = !_S1691;
                    if(_S1692)
                    {
                        normal_11 = make_float3 (0.0f);
                    }
                    bool _S1693 = !_S1692;
                    int _S1694;
                    if(_S1693)
                    {
                        points_14[int(3)] = make_float3 (_S1669.w) * s_apply_unproject_raydir_0(uv_u_38, camera_model_11, is_ray_depth_11).value0_19;
                        _S1694 = int(2);
                    }
                    else
                    {
                        _S1694 = int(0);
                    }
                    if(_S1694 != int(2))
                    {
                        _runFlag_35 = false;
                        _S1680 = _S1694;
                    }
                    if(_runFlag_35)
                    {
                        _S1680 = int(1);
                    }
                }
            }
        }
        else
        {
            _S1680 = int(0);
            points_14[int(0)] = _S1672;
            points_14[int(1)] = _S1672;
            points_14[int(2)] = _S1672;
            points_14[int(3)] = _S1672;
        }
        if(_S1680 != int(1))
        {
            _runFlag_35 = false;
        }
        else
        {
            _runFlag_35 = _S1673;
        }
        if(_runFlag_35)
        {
            Tuple_9 _S1695 = s_apply_cross_0(points_14[int(1)] - points_14[int(0)], - (points_14[int(3)] - points_14[int(2)]));
            float3  _S1696 = _S1695.value0_13;
            if((s_apply_dot_0(_S1696, _S1696).value0_14) != 0.0f)
            {
                normal_11 = _S1695.value0_13 / make_float3 (s_apply_length_1(_S1695.value0_13).value0_7);
            }
            else
            {
                normal_11 = _S1695.value0_13;
            }
        }
    }
    Tuple_16 _S1697;
    (&_S1697)->value0_23 = normal_11;
    (&_S1697)->value1_5 = _S1671;
    return _S1697;
}

inline __device__ void s_bwdProp_depth_to_normal_3(s_bwdCallableCtx_depth_to_normal_0 * _S1698, float4  * _S1699, float3  _S1700)
{
    float3  _S1701 = make_float3 (0.0f);
    float4  _S1702 = (&_S1698->value0_24)->value3_3;
    bool _runFlag_36;
    if(((&_S1698->value0_24)->value3_3.x) == 0.0f)
    {
        _runFlag_36 = true;
    }
    else
    {
        _runFlag_36 = (_S1702.y) == 0.0f;
    }
    if(_runFlag_36)
    {
        _runFlag_36 = true;
    }
    else
    {
        _runFlag_36 = (_S1702.z) == 0.0f;
    }
    if(_runFlag_36)
    {
        _runFlag_36 = true;
    }
    else
    {
        _runFlag_36 = (_S1702.w) == 0.0f;
    }
    bool _S1703 = !_runFlag_36;
    bool _runFlag_37;
    bool _runFlag_38;
    bool _S1704;
    bool _runFlag_39;
    bool _S1705;
    bool _S1706;
    FixedArray<float3 , 4>  points_15;
    float3  _S1707;
    float3  _S1708;
    float3  _S1709;
    float3  _S1710;
    float3  _S1711;
    float3  _S1712;
    float3  _S1713;
    s_bwdCallableCtx_length_0 _S1714;
    s_bwdCallableCtx_dot_0 _S1715;
    s_bwdCallableCtx_cross_0 _S1716;
    if(_S1703)
    {
        float2  _S1717 = (&_S1698->value1_7)->value0_22;
        bool _S1718 = !!(&_S1698->value1_7)->value1_4;
        int _S1719;
        if(_S1718)
        {
            bool _S1720 = (&_S1698->value0_24)->value2_3;
            int _S1721 = (&_S1698->value0_24)->value1_6;
            Tuple_14 _S1722 = s_apply_unproject_raydir_0(_S1717, (&_S1698->value0_24)->value1_6, (&_S1698->value0_24)->value2_3);
            float3  _S1723 = make_float3 (*&((&(&_S1698->value0_24)->value3_3)->x)) * _S1722.value0_19;
            float2  _S1724 = (&_S1698->value1_7)->value2_2;
            bool _S1725 = !!(&_S1698->value1_7)->value3_2;
            if(_S1725)
            {
                Tuple_14 _S1726 = s_apply_unproject_raydir_0(_S1724, _S1721, _S1720);
                float3  _S1727 = make_float3 (*&((&(&_S1698->value0_24)->value3_3)->y)) * _S1726.value0_19;
                _S1719 = int(2);
                points_15[int(0)] = _S1723;
                points_15[int(1)] = _S1727;
                points_15[int(2)] = _S1701;
                points_15[int(3)] = _S1701;
                _S1707 = _S1726.value0_19;
            }
            else
            {
                _S1719 = int(0);
                points_15[int(0)] = _S1723;
                points_15[int(1)] = _S1701;
                points_15[int(2)] = _S1701;
                points_15[int(3)] = _S1701;
                _S1707 = _S1701;
            }
            if(_S1719 != int(2))
            {
                _runFlag_36 = false;
            }
            else
            {
                _runFlag_36 = _S1718;
                _S1719 = int(0);
            }
            if(_runFlag_36)
            {
                float2  _S1728 = (&_S1698->value1_7)->value4_2;
                if(!(&_S1698->value1_7)->value5_1)
                {
                    _runFlag_37 = false;
                    _S1719 = int(0);
                }
                else
                {
                    _runFlag_37 = _runFlag_36;
                }
                if(_runFlag_37)
                {
                    Tuple_14 _S1729 = s_apply_unproject_raydir_0(_S1728, _S1721, _S1720);
                    points_15[int(2)] = make_float3 (*&((&(&_S1698->value0_24)->value3_3)->z)) * _S1729.value0_19;
                    float2  _S1730 = (&_S1698->value1_7)->value6_1;
                    bool _S1731 = !!(&_S1698->value1_7)->value7_1;
                    int _S1732;
                    if(_S1731)
                    {
                        Tuple_14 _S1733 = s_apply_unproject_raydir_0(_S1730, _S1721, _S1720);
                        points_15[int(3)] = make_float3 (*&((&(&_S1698->value0_24)->value3_3)->w)) * _S1733.value0_19;
                        _S1732 = int(2);
                        _S1708 = _S1733.value0_19;
                    }
                    else
                    {
                        _S1732 = int(0);
                        _S1708 = _S1701;
                    }
                    if(_S1732 != int(2))
                    {
                        _runFlag_38 = false;
                        _S1719 = _S1732;
                    }
                    else
                    {
                        _runFlag_38 = _runFlag_37;
                    }
                    if(_runFlag_38)
                    {
                        _S1719 = int(1);
                    }
                    _runFlag_38 = _S1731;
                    _S1709 = _S1729.value0_19;
                }
                else
                {
                    _runFlag_38 = false;
                    _S1708 = _S1701;
                    _S1709 = _S1701;
                }
            }
            else
            {
                _runFlag_37 = false;
                _runFlag_38 = false;
                _S1708 = _S1701;
                _S1709 = _S1701;
            }
            float3  _S1734 = _S1707;
            _S1707 = _S1708;
            _S1708 = _S1709;
            _S1704 = _S1725;
            _S1709 = _S1734;
            _S1710 = _S1722.value0_19;
        }
        else
        {
            _S1719 = int(0);
            points_15[int(0)] = _S1701;
            points_15[int(1)] = _S1701;
            points_15[int(2)] = _S1701;
            points_15[int(3)] = _S1701;
            _runFlag_36 = false;
            _runFlag_37 = false;
            _runFlag_38 = false;
            _S1707 = _S1701;
            _S1708 = _S1701;
            _S1704 = false;
            _S1709 = _S1701;
            _S1710 = _S1701;
        }
        if(_S1719 != int(1))
        {
            _runFlag_39 = false;
        }
        else
        {
            _runFlag_39 = _S1703;
        }
        if(_runFlag_39)
        {
            float3  dx_7 = points_15[int(1)] - points_15[int(0)];
            float3  _S1735 = - (points_15[int(3)] - points_15[int(2)]);
            Tuple_9 _S1736 = s_apply_cross_0(dx_7, _S1735);
            s_bwdCallableCtx_cross_0 _S1737;
            (&_S1737)->_S68 = dx_7;
            (&_S1737)->_S69 = _S1735;
            s_bwdCallableCtx_cross_0 _S1738 = _S1737;
            Tuple_10 _S1739 = s_apply_dot_0(_S1736.value0_13, _S1736.value0_13);
            s_bwdCallableCtx_dot_0 _S1740;
            (&_S1740)->_S81 = _S1736.value0_13;
            (&_S1740)->_S82 = _S1736.value0_13;
            s_bwdCallableCtx_dot_0 _S1741 = _S1740;
            bool _S1742 = (_S1739.value0_14) != 0.0f;
            if(_S1742)
            {
                Tuple_5 _S1743 = s_apply_length_1(_S1736.value0_13);
                float3  _S1744 = make_float3 (_S1743.value0_7);
                s_bwdCallableCtx_length_0 _S1745;
                (&_S1745)->_S11 = _S1736.value0_13;
                _S1711 = make_float3 (_S1743.value0_7 * _S1743.value0_7);
                _S1712 = _S1744;
                _S1714 = _S1745;
            }
            else
            {
                _S1711 = _S1701;
                _S1712 = _S1701;
                (&_S1714)->_S11 = _S1701;
            }
            float3  _S1746 = _S1712;
            _S1705 = _S1742;
            _S1712 = _S1736.value0_13;
            _S1713 = _S1746;
            _S1715 = _S1741;
            _S1716 = _S1738;
        }
        else
        {
            _S1705 = false;
            _S1711 = _S1701;
            _S1712 = _S1701;
            _S1713 = _S1701;
            (&_S1714)->_S11 = _S1701;
            (&_S1715)->_S81 = _S1701;
            (&_S1715)->_S82 = _S1701;
            (&_S1716)->_S68 = _S1701;
            (&_S1716)->_S69 = _S1701;
        }
        bool _S1747 = _runFlag_36;
        bool _S1748 = _runFlag_37;
        bool _S1749 = _runFlag_38;
        float3  _S1750 = _S1707;
        float3  _S1751 = _S1708;
        bool _S1752 = _S1704;
        float3  _S1753 = _S1709;
        float3  _S1754 = _S1710;
        _runFlag_36 = _runFlag_39;
        _runFlag_37 = _S1705;
        _S1707 = _S1711;
        _S1708 = _S1712;
        _S1709 = _S1713;
        _runFlag_38 = _S1718;
        _S1704 = _S1747;
        _runFlag_39 = _S1748;
        _S1705 = _S1749;
        _S1710 = _S1750;
        _S1711 = _S1751;
        _S1706 = _S1752;
        _S1712 = _S1753;
        _S1713 = _S1754;
    }
    else
    {
        _runFlag_36 = false;
        _runFlag_37 = false;
        _S1707 = _S1701;
        _S1708 = _S1701;
        _S1709 = _S1701;
        (&_S1714)->_S11 = _S1701;
        (&_S1715)->_S81 = _S1701;
        (&_S1715)->_S82 = _S1701;
        (&_S1716)->_S68 = _S1701;
        (&_S1716)->_S69 = _S1701;
        _runFlag_38 = false;
        _S1704 = false;
        _runFlag_39 = false;
        _S1705 = false;
        _S1710 = _S1701;
        _S1711 = _S1701;
        _S1706 = false;
        _S1712 = _S1701;
        _S1713 = _S1701;
    }
    FixedArray<float3 , 4>  _S1755;
    Array_dzero_1(&_S1755);
    FixedArray<float3 , 4>  _S1756 = _S1755;
    float4  _S1757 = make_float4 (0.0f);
    float4  _S1758;
    if(_S1703)
    {
        if(_runFlag_36)
        {
            if(_runFlag_37)
            {
                float3  _S1759 = _S1700 / _S1707;
                float3  _S1760 = _S1708 * - _S1759;
                float3  _S1761 = _S1709 * _S1759;
                float _S1762 = _S1760.x + _S1760.y + _S1760.z;
                float3  _S1763 = _S1701;
                s_bwdCallableCtx_length_0 _S1764 = _S1714;
                s_bwdProp_length_0(&_S1764, &_S1763, _S1762);
                _S1707 = _S1761 + _S1763;
            }
            else
            {
                _S1707 = _S1700;
            }
            float3  _S1765 = _S1701;
            float3  _S1766 = _S1701;
            s_bwdCallableCtx_dot_0 _S1767 = _S1715;
            s_bwdProp_dot_0(&_S1767, &_S1765, &_S1766, 0.0f);
            float3  _S1768 = _S1765 + _S1766 + _S1707;
            float3  _S1769 = _S1701;
            float3  _S1770 = _S1701;
            s_bwdCallableCtx_cross_0 _S1771 = _S1716;
            s_bwdProp_cross_0(&_S1771, &_S1769, &_S1770, _S1768);
            float3  s_diff_dy_T_7 = - _S1770;
            float3  _S1772 = - s_diff_dy_T_7;
            float3  _S1773 = - _S1769;
            FixedArray<float3 , 4>  _S1774 = _S1756;
            _S1774[int(2)] = _S1772;
            _S1774[int(3)] = s_diff_dy_T_7;
            _S1774[int(0)] = _S1773;
            _S1774[int(1)] = _S1769;
            FixedArray<float3 , 4>  _S1775 = _S1756;
            FixedArray<float3 , 4>  _S1776 = _S1774;
            FixedArray<float3 , 4>  _S1777;
            Array_dadd_1(&_S1775, &_S1776, &_S1777);
            points_15 = _S1777;
        }
        else
        {
            points_15 = _S1756;
        }
        if(_runFlag_38)
        {
            if(_S1704)
            {
                if(_runFlag_39)
                {
                    FixedArray<float3 , 4>  _S1778 = points_15;
                    FixedArray<float3 , 4>  _S1779 = _S1756;
                    FixedArray<float3 , 4>  _S1780;
                    Array_dadd_1(&_S1778, &_S1779, &_S1780);
                    FixedArray<float3 , 4>  _S1781 = _S1780;
                    if(_S1705)
                    {
                        points_15 = _S1781;
                        points_15[int(3)] = _S1701;
                        float3  _S1782 = _S1710 * _S1781[int(3)];
                        float _S1783 = _S1782.x + _S1782.y + _S1782.z;
                        FixedArray<float3 , 4>  _S1784 = points_15;
                        FixedArray<float3 , 4>  _S1785 = _S1756;
                        FixedArray<float3 , 4>  _S1786;
                        Array_dadd_1(&_S1784, &_S1785, &_S1786);
                        float4  _S1787 = _S1757;
                        *&((&_S1787)->w) = _S1783;
                        points_15 = _S1786;
                        _S1758 = _S1787;
                    }
                    else
                    {
                        FixedArray<float3 , 4>  _S1788 = _S1781;
                        FixedArray<float3 , 4>  _S1789 = _S1756;
                        FixedArray<float3 , 4>  _S1790;
                        Array_dadd_1(&_S1788, &_S1789, &_S1790);
                        points_15 = _S1790;
                        _S1758 = _S1757;
                    }
                    FixedArray<float3 , 4>  _S1791 = points_15;
                    points_15[int(2)] = _S1701;
                    float3  _S1792 = _S1711 * _S1791[int(2)];
                    float _S1793 = _S1792.x + _S1792.y + _S1792.z;
                    FixedArray<float3 , 4>  _S1794 = points_15;
                    FixedArray<float3 , 4>  _S1795 = _S1756;
                    FixedArray<float3 , 4>  _S1796;
                    Array_dadd_1(&_S1794, &_S1795, &_S1796);
                    float4  _S1797 = _S1757;
                    *&((&_S1797)->z) = _S1793;
                    float4  _S1798 = _S1758 + _S1797;
                    points_15 = _S1796;
                    _S1758 = _S1798;
                }
                else
                {
                    FixedArray<float3 , 4>  _S1799 = points_15;
                    FixedArray<float3 , 4>  _S1800 = _S1756;
                    FixedArray<float3 , 4>  _S1801;
                    Array_dadd_1(&_S1799, &_S1800, &_S1801);
                    points_15 = _S1801;
                    _S1758 = _S1757;
                }
            }
            else
            {
                FixedArray<float3 , 4>  _S1802 = points_15;
                FixedArray<float3 , 4>  _S1803 = _S1756;
                FixedArray<float3 , 4>  _S1804;
                Array_dadd_1(&_S1802, &_S1803, &_S1804);
                points_15 = _S1804;
                _S1758 = _S1757;
            }
            if(_S1706)
            {
                FixedArray<float3 , 4>  _S1805 = points_15;
                float3  _S1806 = _S1712 * points_15[int(1)];
                float _S1807 = _S1806.x + _S1806.y + _S1806.z;
                float4  _S1808 = _S1757;
                *&((&_S1808)->y) = _S1807;
                float4  _S1809 = _S1758 + _S1808;
                points_15 = _S1756;
                _S1707 = _S1805[int(0)];
                _S1758 = _S1809;
            }
            else
            {
                FixedArray<float3 , 4>  _S1810 = points_15;
                FixedArray<float3 , 4>  _S1811 = _S1756;
                FixedArray<float3 , 4>  _S1812;
                Array_dadd_1(&_S1810, &_S1811, &_S1812);
                points_15 = _S1812;
                _S1707 = _S1701;
            }
            float3  _S1813 = _S1713 * (points_15[int(0)] + _S1707);
            float _S1814 = _S1813.x + _S1813.y + _S1813.z;
            float4  _S1815 = _S1757;
            *&((&_S1815)->x) = _S1814;
            _S1758 = _S1758 + _S1815;
        }
        else
        {
            _S1758 = _S1757;
        }
    }
    else
    {
        _S1758 = _S1757;
    }
    *_S1699 = _S1758;
    return;
}

inline __device__ void _S1816(float2  _S1817, float4  _S1818, FixedArray<float, 1>  * _S1819, int _S1820, bool _S1821, DiffPair_vectorx3Cfloatx2C4x3E_0 * _S1822, float3  _S1823)
{
    float4  _S1824 = _S1822->primal_0;
    Tuple_16 _S1825 = s_apply_depth_to_normal_3(_S1817, _S1818, _S1819, _S1820, _S1821, _S1822->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_to_normal_0 _S1826;
    (&_S1826)->value1_6 = _S1820;
    (&_S1826)->value2_3 = _S1821;
    (&_S1826)->value3_3 = _S1824;
    s_bwdCallableCtx_depth_to_normal_0 _S1827;
    (&_S1827)->value0_24 = _S1826;
    (&_S1827)->value1_7 = _S1825.value1_5;
    s_bwdProp_depth_to_normal_3(&_S1827, &_S1822->differential_0, _S1823);
    return;
}

inline __device__ Tuple_17 s_apply_depth_to_point_3(float2  pix_pos_3, float4  intrins_11, FixedArray<float, 1>  * dist_coeffs_15, int camera_model_12, bool is_ray_depth_12, float _S1828)
{
    float2  _S1829 = make_float2 (0.0f);
    s_minCtx_s_bwdCallableCtx_depth_to_point_0 _S1830;
    (&_S1830)->value0_25 = false;
    (&_S1830)->value1_8 = _S1829;
    float2  uv_46 = (pix_pos_3 - float2 {intrins_11.z, intrins_11.w}) / float2 {intrins_11.x, intrins_11.y};
    float2  _S1831 = _S1829;
    bool _S1832 = undistort_point_3(uv_46, dist_coeffs_15, int(12), &_S1831);
    (&_S1830)->value0_25 = _S1832;
    float2  uv_u_39 = _S1831;
    (&_S1830)->value1_8 = _S1831;
    bool _S1833 = !_S1832;
    float3  _S1834;
    if(_S1833)
    {
        _S1834 = make_float3 (0.0f);
    }
    bool _S1835 = !_S1833;
    if(_S1835)
    {
        _S1834 = make_float3 (_S1828) * s_apply_unproject_raydir_0(uv_u_39, camera_model_12, is_ray_depth_12).value0_19;
    }
    Tuple_17 _S1836;
    (&_S1836)->value0_26 = _S1834;
    (&_S1836)->value1_9 = _S1830;
    return _S1836;
}

inline __device__ void s_bwdProp_depth_to_point_3(s_bwdCallableCtx_depth_to_point_0 * _S1837, float * _S1838, float3  _S1839)
{
    float3  _S1840 = make_float3 (0.0f);
    bool _S1841 = !!(&_S1837->value1_11)->value0_25;
    float3  _S1842;
    if(_S1841)
    {
        _S1842 = s_apply_unproject_raydir_0((&_S1837->value1_11)->value1_8, (&_S1837->value0_28)->value0_27, (&_S1837->value0_28)->value1_10).value0_19;
    }
    else
    {
        _S1842 = _S1840;
    }
    if(_S1841)
    {
        _S1842 = _S1842 * _S1839;
    }
    else
    {
        _S1842 = _S1840;
    }
    *_S1838 = _S1842.x + _S1842.y + _S1842.z;
    return;
}

inline __device__ void _S1843(float2  _S1844, float4  _S1845, FixedArray<float, 1>  * _S1846, int _S1847, bool _S1848, DiffPair_float_0 * _S1849, float3  _S1850)
{
    Tuple_17 _S1851 = s_apply_depth_to_point_3(_S1844, _S1845, _S1846, _S1847, _S1848, _S1849->primal_0);
    s_paramCtx_s_bwdCallableCtx_depth_to_point_0 _S1852;
    (&_S1852)->value0_27 = _S1847;
    (&_S1852)->value1_10 = _S1848;
    s_bwdCallableCtx_depth_to_point_0 _S1853;
    (&_S1853)->value0_28 = _S1852;
    (&_S1853)->value1_11 = _S1851.value1_9;
    s_bwdProp_depth_to_point_3(&_S1853, &_S1849->differential_0, _S1850);
    return;
}

struct DiffPair_arrayx3Cvectorx3Cfloatx2C3x3Ex2C4x3E_0
{
    FixedArray<float3 , 4>  primal_0;
    FixedArray<float3 , 4>  differential_0;
};

struct s_paramCtx_s_bwdCallableCtx_points_to_normal_0
{
    FixedArray<float3 , 4>  value0_29;
};

struct s_bwdCallableCtx_points_to_normal_0
{
    s_paramCtx_s_bwdCallableCtx_points_to_normal_0 value0_30;
};

inline __device__ void s_bwdProp_points_to_normal_0(s_bwdCallableCtx_points_to_normal_0 * _S1854, FixedArray<float3 , 4>  * _S1855, float3  _S1856)
{
    float3  _S1857 = make_float3 (0.0f);
    float3  _S1858 = (&_S1854->value0_30)->value0_29[int(0)];
    Tuple_10 _S1859 = s_apply_dot_0((&_S1854->value0_30)->value0_29[int(0)], (&_S1854->value0_30)->value0_29[int(0)]);
    s_bwdCallableCtx_dot_0 _S1860;
    (&_S1860)->_S81 = (&_S1854->value0_30)->value0_29[int(0)];
    (&_S1860)->_S82 = (&_S1854->value0_30)->value0_29[int(0)];
    s_bwdCallableCtx_dot_0 _S1861 = _S1860;
    bool _S1862 = (_S1859.value0_14) == 0.0f;
    bool _S1863;
    s_bwdCallableCtx_dot_0 _S1864;
    if(_S1862)
    {
        _S1863 = true;
        (&_S1864)->_S81 = _S1857;
        (&_S1864)->_S82 = _S1857;
    }
    else
    {
        Tuple_10 _S1865 = s_apply_dot_0((&_S1854->value0_30)->value0_29[int(1)], (&_S1854->value0_30)->value0_29[int(1)]);
        s_bwdCallableCtx_dot_0 _S1866;
        (&_S1866)->_S81 = (&_S1854->value0_30)->value0_29[int(1)];
        (&_S1866)->_S82 = (&_S1854->value0_30)->value0_29[int(1)];
        _S1863 = (_S1865.value0_14) == 0.0f;
        _S1864 = _S1866;
    }
    bool _S1867;
    s_bwdCallableCtx_dot_0 _S1868;
    if(_S1863)
    {
        _S1867 = true;
        (&_S1868)->_S81 = _S1857;
        (&_S1868)->_S82 = _S1857;
    }
    else
    {
        Tuple_10 _S1869 = s_apply_dot_0((&_S1854->value0_30)->value0_29[int(2)], (&_S1854->value0_30)->value0_29[int(2)]);
        s_bwdCallableCtx_dot_0 _S1870;
        (&_S1870)->_S81 = (&_S1854->value0_30)->value0_29[int(2)];
        (&_S1870)->_S82 = (&_S1854->value0_30)->value0_29[int(2)];
        _S1867 = (_S1869.value0_14) == 0.0f;
        _S1868 = _S1870;
    }
    bool _S1871;
    s_bwdCallableCtx_dot_0 _S1872;
    if(_S1867)
    {
        _S1871 = true;
        (&_S1872)->_S81 = _S1857;
        (&_S1872)->_S82 = _S1857;
    }
    else
    {
        Tuple_10 _S1873 = s_apply_dot_0((&_S1854->value0_30)->value0_29[int(3)], (&_S1854->value0_30)->value0_29[int(3)]);
        s_bwdCallableCtx_dot_0 _S1874;
        (&_S1874)->_S81 = (&_S1854->value0_30)->value0_29[int(3)];
        (&_S1874)->_S82 = (&_S1854->value0_30)->value0_29[int(3)];
        _S1871 = (_S1873.value0_14) == 0.0f;
        _S1872 = _S1874;
    }
    bool _S1875 = !_S1871;
    s_bwdCallableCtx_dot_0 _S1876;
    float3  _S1877;
    float3  _S1878;
    float3  _S1879;
    s_bwdCallableCtx_length_0 _S1880;
    s_bwdCallableCtx_cross_0 _S1881;
    if(_S1875)
    {
        float3  dx_8 = (&_S1854->value0_30)->value0_29[int(1)] - _S1858;
        float3  _S1882 = - ((&_S1854->value0_30)->value0_29[int(3)] - (&_S1854->value0_30)->value0_29[int(2)]);
        Tuple_9 _S1883 = s_apply_cross_0(dx_8, _S1882);
        s_bwdCallableCtx_cross_0 _S1884;
        (&_S1884)->_S68 = dx_8;
        (&_S1884)->_S69 = _S1882;
        s_bwdCallableCtx_cross_0 _S1885 = _S1884;
        Tuple_10 _S1886 = s_apply_dot_0(_S1883.value0_13, _S1883.value0_13);
        s_bwdCallableCtx_dot_0 _S1887;
        (&_S1887)->_S81 = _S1883.value0_13;
        (&_S1887)->_S82 = _S1883.value0_13;
        s_bwdCallableCtx_dot_0 _S1888 = _S1887;
        bool _S1889 = (_S1886.value0_14) != 0.0f;
        if(_S1889)
        {
            Tuple_5 _S1890 = s_apply_length_1(_S1883.value0_13);
            float3  _S1891 = make_float3 (_S1890.value0_7);
            s_bwdCallableCtx_length_0 _S1892;
            (&_S1892)->_S11 = _S1883.value0_13;
            _S1877 = make_float3 (_S1890.value0_7 * _S1890.value0_7);
            _S1878 = _S1891;
            _S1880 = _S1892;
        }
        else
        {
            _S1877 = _S1857;
            _S1878 = _S1857;
            (&_S1880)->_S11 = _S1857;
        }
        float3  _S1893 = _S1878;
        _S1871 = _S1889;
        _S1878 = _S1883.value0_13;
        _S1879 = _S1893;
        _S1876 = _S1888;
        _S1881 = _S1885;
    }
    else
    {
        _S1871 = false;
        _S1877 = _S1857;
        _S1878 = _S1857;
        _S1879 = _S1857;
        (&_S1880)->_S11 = _S1857;
        (&_S1876)->_S81 = _S1857;
        (&_S1876)->_S82 = _S1857;
        (&_S1881)->_S68 = _S1857;
        (&_S1881)->_S69 = _S1857;
    }
    FixedArray<float3 , 4>  _S1894;
    Array_dzero_1(&_S1894);
    FixedArray<float3 , 4>  _S1895 = _S1894;
    FixedArray<float3 , 4>  _S1896;
    if(_S1875)
    {
        if(_S1871)
        {
            float3  _S1897 = _S1856 / _S1877;
            float3  _S1898 = _S1878 * - _S1897;
            float3  _S1899 = _S1879 * _S1897;
            float _S1900 = _S1898.x + _S1898.y + _S1898.z;
            float3  _S1901 = _S1857;
            s_bwdCallableCtx_length_0 _S1902 = _S1880;
            s_bwdProp_length_0(&_S1902, &_S1901, _S1900);
            _S1877 = _S1899 + _S1901;
        }
        else
        {
            _S1877 = _S1856;
        }
        float3  _S1903 = _S1857;
        float3  _S1904 = _S1857;
        s_bwdCallableCtx_dot_0 _S1905 = _S1876;
        s_bwdProp_dot_0(&_S1905, &_S1903, &_S1904, 0.0f);
        float3  _S1906 = _S1903 + _S1904 + _S1877;
        float3  _S1907 = _S1857;
        float3  _S1908 = _S1857;
        s_bwdCallableCtx_cross_0 _S1909 = _S1881;
        s_bwdProp_cross_0(&_S1909, &_S1907, &_S1908, _S1906);
        float3  s_diff_dy_T_8 = - _S1908;
        float3  _S1910 = - s_diff_dy_T_8;
        float3  _S1911 = - _S1907;
        FixedArray<float3 , 4>  _S1912 = _S1895;
        _S1912[int(2)] = _S1910;
        _S1912[int(3)] = s_diff_dy_T_8;
        _S1912[int(1)] = _S1907;
        FixedArray<float3 , 4>  _S1913 = _S1895;
        FixedArray<float3 , 4>  _S1914 = _S1912;
        FixedArray<float3 , 4>  _S1915;
        Array_dadd_1(&_S1913, &_S1914, &_S1915);
        _S1896 = _S1915;
        _S1877 = _S1911;
    }
    else
    {
        _S1896 = _S1895;
        _S1877 = _S1857;
    }
    if(_S1867)
    {
    }
    else
    {
        float3  _S1916 = _S1857;
        float3  _S1917 = _S1857;
        s_bwdCallableCtx_dot_0 _S1918 = _S1872;
        s_bwdProp_dot_0(&_S1918, &_S1916, &_S1917, 0.0f);
        float3  _S1919 = _S1916 + _S1917;
        FixedArray<float3 , 4>  _S1920 = _S1895;
        _S1920[int(3)] = _S1919;
        FixedArray<float3 , 4>  _S1921 = _S1896;
        FixedArray<float3 , 4>  _S1922 = _S1920;
        FixedArray<float3 , 4>  _S1923;
        Array_dadd_1(&_S1921, &_S1922, &_S1923);
        _S1896 = _S1923;
    }
    if(_S1863)
    {
    }
    else
    {
        float3  _S1924 = _S1857;
        float3  _S1925 = _S1857;
        s_bwdCallableCtx_dot_0 _S1926 = _S1868;
        s_bwdProp_dot_0(&_S1926, &_S1924, &_S1925, 0.0f);
        float3  _S1927 = _S1924 + _S1925;
        FixedArray<float3 , 4>  _S1928 = _S1895;
        _S1928[int(2)] = _S1927;
        FixedArray<float3 , 4>  _S1929 = _S1896;
        FixedArray<float3 , 4>  _S1930 = _S1928;
        FixedArray<float3 , 4>  _S1931;
        Array_dadd_1(&_S1929, &_S1930, &_S1931);
        _S1896 = _S1931;
    }
    if(_S1862)
    {
    }
    else
    {
        float3  _S1932 = _S1857;
        float3  _S1933 = _S1857;
        s_bwdCallableCtx_dot_0 _S1934 = _S1864;
        s_bwdProp_dot_0(&_S1934, &_S1932, &_S1933, 0.0f);
        float3  _S1935 = _S1932 + _S1933;
        FixedArray<float3 , 4>  _S1936 = _S1895;
        _S1936[int(1)] = _S1935;
        FixedArray<float3 , 4>  _S1937 = _S1896;
        FixedArray<float3 , 4>  _S1938 = _S1936;
        FixedArray<float3 , 4>  _S1939;
        Array_dadd_1(&_S1937, &_S1938, &_S1939);
        _S1896 = _S1939;
    }
    float3  _S1940 = _S1857;
    float3  _S1941 = _S1857;
    s_bwdCallableCtx_dot_0 _S1942 = _S1861;
    s_bwdProp_dot_0(&_S1942, &_S1940, &_S1941, 0.0f);
    float3  _S1943 = _S1940 + _S1941 + _S1877;
    FixedArray<float3 , 4>  _S1944 = _S1895;
    _S1944[int(0)] = _S1943;
    FixedArray<float3 , 4>  _S1945 = _S1896;
    FixedArray<float3 , 4>  _S1946 = _S1944;
    FixedArray<float3 , 4>  _S1947;
    Array_dadd_1(&_S1945, &_S1946, &_S1947);
    *_S1855 = _S1947;
    return;
}

inline __device__ void _S1948(DiffPair_arrayx3Cvectorx3Cfloatx2C3x3Ex2C4x3E_0 * _S1949, float3  _S1950)
{
    s_paramCtx_s_bwdCallableCtx_points_to_normal_0 _S1951;
    (&_S1951)->value0_29 = _S1949->primal_0;
    s_bwdCallableCtx_points_to_normal_0 _S1952;
    (&_S1952)->value0_30 = _S1951;
    s_bwdProp_points_to_normal_0(&_S1952, &_S1949->differential_0, _S1950);
    return;
}

struct s_paramCtx_s_bwdCallableCtx_working_to_display_0
{
    float3  value0_31;
    Matrix<float, 3, 3>  value1_12;
    int value2_4;
    bool value3_4;
};

struct s_bwdCallableCtx_working_to_display_0
{
    s_paramCtx_s_bwdCallableCtx_working_to_display_0 value0_32;
};

struct s_paramCtx_s_bwdCallableCtx_srgb_to_linear_rgb_0
{
    float value0_33;
};

struct s_bwdCallableCtx_srgb_to_linear_rgb_0
{
    s_paramCtx_s_bwdCallableCtx_srgb_to_linear_rgb_0 value0_34;
};

struct Tuple_18
{
    float value0_35;
};

inline __device__ Tuple_18 s_apply_srgb_to_linear_rgb_0(float _S1953)
{
    float _S1954;
    if(_S1953 < 0.04044999927282333f)
    {
        _S1954 = _S1953 * 0.07739938050508499f;
    }
    else
    {
        _S1954 = s_apply_pow_0(0.94786733388900757f * (_S1953 + 0.05499999970197678f), 2.40000009536743164f).value0_12;
    }
    Tuple_18 _S1955;
    (&_S1955)->value0_35 = _S1954;
    return _S1955;
}

struct s_paramCtx_s_bwdCallableCtx_tone_encode_0
{
    float value0_36;
    int value1_13;
};

struct s_bwdCallableCtx_tone_encode_0
{
    s_paramCtx_s_bwdCallableCtx_tone_encode_0 value0_37;
};

struct s_paramCtx_s_bwdCallableCtx_xfer_filmic_0
{
    float value0_38;
};

struct s_paramCtx_s_bwdCallableCtx_xfer_aces_0
{
    float value0_39;
};

struct s_paramCtx_s_bwdCallableCtx_linear_rgb_to_srgb_0
{
    float value0_40;
};

struct s_paramCtx_s_bwdCallableCtx_xfer_uncharted2_0
{
    float value0_41;
};

struct s_bwdCallableCtx_xfer_filmic_0
{
    s_paramCtx_s_bwdCallableCtx_xfer_filmic_0 value0_42;
};

struct s_bwdCallableCtx_linear_rgb_to_srgb_0
{
    s_paramCtx_s_bwdCallableCtx_linear_rgb_to_srgb_0 value0_43;
};

struct s_bwdCallableCtx_xfer_aces_0
{
    s_paramCtx_s_bwdCallableCtx_xfer_aces_0 value0_44;
};

struct s_bwdCallableCtx_xfer_uncharted2_0
{
    s_paramCtx_s_bwdCallableCtx_xfer_uncharted2_0 value0_45;
};

struct Tuple_19
{
    float value0_46;
};

inline __device__ Tuple_19 s_apply_xfer_aces_0(float _S1956)
{
    Tuple_19 _S1957;
    (&_S1957)->value0_46 = _S1956 * (2.50999999046325684f * _S1956 + 0.02999999932944775f) / (_S1956 * (2.43000006675720215f * _S1956 + 0.5899999737739563f) + 0.14000000059604645f);
    return _S1957;
}

struct Tuple_20
{
    float value0_47;
};

struct Tuple_21
{
    float value0_48;
};

inline __device__ Tuple_21 s_apply_xfer_hable_0(float _S1958)
{
    float _S1959 = 0.15000000596046448f * _S1958;
    Tuple_21 _S1960;
    (&_S1960)->value0_48 = (_S1958 * (_S1959 + 0.05000000074505806f) + 0.00400000018998981f) / (_S1958 * (_S1959 + 0.5f) + 0.06000000238418579f) - 0.06666666269302368f;
    return _S1960;
}

inline __device__ Tuple_20 s_apply_xfer_uncharted2_0(float _S1961)
{
    Tuple_20 _S1962;
    (&_S1962)->value0_47 = s_apply_xfer_hable_0(s_apply_xfer_max0_0(_S1961).value0_11).value0_48 / s_apply_xfer_hable_0(11.19999980926513672f).value0_48;
    return _S1962;
}

inline __device__ void s_bwdProp_linear_rgb_to_srgb_0(s_bwdCallableCtx_linear_rgb_to_srgb_0 * _S1963, float * _S1964, float _S1965)
{
    float _S1966 = (&_S1963->value0_43)->value0_40;
    bool _S1967 = ((&_S1963->value0_43)->value0_40) < 0.00313080009073019f;
    s_bwdCallableCtx_pow_0 _S1968;
    if(_S1967)
    {
        (&_S1968)->_S54 = 0.0f;
        (&_S1968)->_S55 = 0.0f;
    }
    else
    {
        s_bwdCallableCtx_pow_0 _S1969;
        (&_S1969)->_S54 = _S1966;
        (&_S1969)->_S55 = 0.4166666567325592f;
        _S1968 = _S1969;
    }
    float _S1970;
    if(_S1967)
    {
        _S1970 = 12.92000007629394531f * _S1965;
    }
    else
    {
        float _S1971 = 1.0549999475479126f * _S1965;
        float _S1972 = 0.0f;
        float _S1973 = 0.0f;
        s_bwdCallableCtx_pow_0 _S1974 = _S1968;
        s_bwdProp_pow_0(&_S1974, &_S1972, &_S1973, _S1971);
        _S1970 = _S1972;
    }
    *_S1964 = _S1970;
    return;
}

struct s_paramCtx_s_bwdCallableCtx_xfer_hable_0
{
    float value0_49;
};

struct s_bwdCallableCtx_xfer_hable_0
{
    s_paramCtx_s_bwdCallableCtx_xfer_hable_0 value0_50;
};

inline __device__ void s_bwdProp_xfer_hable_0(s_bwdCallableCtx_xfer_hable_0 * _S1975, float * _S1976, float _S1977)
{
    float _S1978 = 0.15000000596046448f * (&_S1975->value0_50)->value0_49;
    float _S1979 = _S1978 + 0.05000000074505806f;
    float _S1980 = _S1978 + 0.5f;
    float _S1981 = (&_S1975->value0_50)->value0_49 * _S1980 + 0.06000000238418579f;
    float _S1982 = _S1977 / (_S1981 * _S1981);
    float _S1983 = ((&_S1975->value0_50)->value0_49 * _S1979 + 0.00400000018998981f) * - _S1982;
    float _S1984 = _S1981 * _S1982;
    *_S1976 = _S1980 * _S1983 + _S1979 * _S1984 + 0.15000000596046448f * ((&_S1975->value0_50)->value0_49 * _S1983 + (&_S1975->value0_50)->value0_49 * _S1984);
    return;
}

inline __device__ void s_bwdProp_xfer_uncharted2_0(s_bwdCallableCtx_xfer_uncharted2_0 * _S1985, float * _S1986, float _S1987)
{
    Tuple_7 _S1988 = s_apply_xfer_max0_0((&_S1985->value0_45)->value0_41);
    s_bwdCallableCtx_xfer_max0_0 _S1989;
    (&_S1989)->_S51 = (&_S1985->value0_45)->value0_41;
    s_paramCtx_s_bwdCallableCtx_xfer_hable_0 _S1990;
    (&_S1990)->value0_49 = _S1988.value0_11;
    Tuple_21 _S1991 = s_apply_xfer_hable_0(11.19999980926513672f);
    float _S1992 = _S1991.value0_48;
    float _S1993 = _S1991.value0_48 * (_S1987 / (_S1992 * _S1992));
    float _S1994 = 0.0f;
    s_bwdCallableCtx_xfer_hable_0 _S1995;
    (&_S1995)->value0_50 = _S1990;
    s_bwdProp_xfer_hable_0(&_S1995, &_S1994, _S1993);
    float _S1996 = 0.0f;
    s_bwdCallableCtx_xfer_max0_0 _S1997 = _S1989;
    s_bwdProp_xfer_max0_0(&_S1997, &_S1996, _S1994);
    *_S1986 = _S1996;
    return;
}

inline __device__ void s_bwdProp_xfer_aces_0(s_bwdCallableCtx_xfer_aces_0 * _S1998, float * _S1999, float _S2000)
{
    float _S2001 = 2.50999999046325684f * (&_S1998->value0_44)->value0_39 + 0.02999999932944775f;
    float _S2002 = 2.43000006675720215f * (&_S1998->value0_44)->value0_39 + 0.5899999737739563f;
    float _S2003 = (&_S1998->value0_44)->value0_39 * _S2002 + 0.14000000059604645f;
    float _S2004 = _S2000 / (_S2003 * _S2003);
    float _S2005 = (&_S1998->value0_44)->value0_39 * _S2001 * - _S2004;
    float _S2006 = _S2003 * _S2004;
    *_S1999 = _S2002 * _S2005 + 2.43000006675720215f * ((&_S1998->value0_44)->value0_39 * _S2005) + _S2001 * _S2006 + 2.50999999046325684f * ((&_S1998->value0_44)->value0_39 * _S2006);
    return;
}

inline __device__ void s_bwdProp_xfer_filmic_0(s_bwdCallableCtx_xfer_filmic_0 * _S2007, float * _S2008, float _S2009)
{
    float _S2010 = (&_S2007->value0_42)->value0_38 - 0.00400000018998981f;
    Tuple_7 _S2011 = s_apply_xfer_max0_0(_S2010);
    s_bwdCallableCtx_xfer_max0_0 _S2012;
    (&_S2012)->_S51 = _S2010;
    float _S2013 = 6.19999980926513672f * _S2011.value0_11;
    float _S2014 = _S2013 + 0.5f;
    float _S2015 = _S2013 + 1.70000004768371582f;
    float _S2016 = _S2011.value0_11 * _S2015 + 0.05999999865889549f;
    float _S2017 = _S2009 / (_S2016 * _S2016);
    float _S2018 = _S2011.value0_11 * _S2014 * - _S2017;
    float _S2019 = _S2016 * _S2017;
    float _S2020 = _S2015 * _S2018 + _S2014 * _S2019 + 6.19999980926513672f * (_S2011.value0_11 * _S2018 + _S2011.value0_11 * _S2019);
    float _S2021 = 0.0f;
    s_bwdCallableCtx_xfer_max0_0 _S2022 = _S2012;
    s_bwdProp_xfer_max0_0(&_S2022, &_S2021, _S2020);
    *_S2008 = _S2021;
    return;
}

inline __device__ void s_bwdProp_tone_encode_0(s_bwdCallableCtx_tone_encode_0 * _S2023, float * _S2024, float _S2025)
{
    s_paramCtx_s_bwdCallableCtx_xfer_filmic_0 _S2026 = { 0.0f };
    s_paramCtx_s_bwdCallableCtx_xfer_aces_0 _S2027 = { 0.0f };
    s_paramCtx_s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2028 = { 0.0f };
    s_paramCtx_s_bwdCallableCtx_xfer_uncharted2_0 _S2029 = { 0.0f };
    int _S2030 = (&_S2023->value0_37)->value1_13;
    bool _S2031 = ((&_S2023->value0_37)->value1_13) == int(3);
    s_bwdCallableCtx_xfer_filmic_0 _S2032;
    if(_S2031)
    {
        s_paramCtx_s_bwdCallableCtx_xfer_filmic_0 _S2033;
        (&_S2033)->value0_38 = (&_S2023->value0_37)->value0_36;
        (&_S2032)->value0_42 = _S2033;
    }
    else
    {
        (&_S2032)->value0_42 = _S2026;
    }
    bool _S2034 = !_S2031;
    bool _runFlag_40;
    bool _runFlag_41;
    bool _runFlag_42;
    bool _S2035;
    bool _S2036;
    bool _S2037;
    s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2038;
    s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2039;
    s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2040;
    s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2041;
    s_bwdCallableCtx_xfer_clamp01_0 _S2042;
    s_bwdCallableCtx_xfer_clamp01_0 _S2043;
    s_bwdCallableCtx_xfer_clamp01_0 _S2044;
    s_bwdCallableCtx_xfer_aces_0 _S2045;
    s_bwdCallableCtx_xfer_max0_0 _S2046;
    s_bwdCallableCtx_xfer_max0_0 _S2047;
    s_bwdCallableCtx_xfer_uncharted2_0 _S2048;
    if(_S2034)
    {
        bool _S2049 = _S2030 == int(2);
        if(_S2049)
        {
            Tuple_7 _S2050 = s_apply_xfer_max0_0((&_S2023->value0_37)->value0_36);
            s_bwdCallableCtx_xfer_max0_0 _S2051;
            (&_S2051)->_S51 = (&_S2023->value0_37)->value0_36;
            Tuple_19 _S2052 = s_apply_xfer_aces_0(_S2050.value0_11);
            s_paramCtx_s_bwdCallableCtx_xfer_aces_0 _S2053;
            (&_S2053)->value0_39 = _S2050.value0_11;
            Tuple_6 _S2054 = s_apply_xfer_clamp01_0(_S2052.value0_46);
            s_bwdCallableCtx_xfer_clamp01_0 _S2055;
            (&_S2055)->_S48 = _S2052.value0_46;
            s_paramCtx_s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2056;
            (&_S2056)->value0_40 = _S2054.value0_10;
            _runFlag_40 = false;
            (&_S2038)->value0_43 = _S2056;
            _S2042 = _S2055;
            (&_S2045)->value0_44 = _S2053;
            _S2046 = _S2051;
        }
        else
        {
            _runFlag_40 = _S2034;
            (&_S2038)->value0_43 = _S2028;
            (&_S2042)->_S48 = 0.0f;
            (&_S2045)->value0_44 = _S2027;
            (&_S2046)->_S51 = 0.0f;
        }
        if(_runFlag_40)
        {
            bool _S2057 = _S2030 == int(4);
            if(_S2057)
            {
                Tuple_20 _S2058 = s_apply_xfer_uncharted2_0((&_S2023->value0_37)->value0_36);
                s_paramCtx_s_bwdCallableCtx_xfer_uncharted2_0 _S2059;
                (&_S2059)->value0_41 = (&_S2023->value0_37)->value0_36;
                Tuple_6 _S2060 = s_apply_xfer_clamp01_0(_S2058.value0_47);
                s_bwdCallableCtx_xfer_clamp01_0 _S2061;
                (&_S2061)->_S48 = _S2058.value0_47;
                s_paramCtx_s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2062;
                (&_S2062)->value0_40 = _S2060.value0_10;
                _runFlag_41 = false;
                (&_S2039)->value0_43 = _S2062;
                _S2043 = _S2061;
                (&_S2048)->value0_45 = _S2059;
            }
            else
            {
                _runFlag_41 = _runFlag_40;
                (&_S2039)->value0_43 = _S2028;
                (&_S2043)->_S48 = 0.0f;
                (&_S2048)->value0_45 = _S2029;
            }
            if(_runFlag_41)
            {
                bool _S2063 = _S2030 == int(1);
                if(_S2063)
                {
                    Tuple_6 _S2064 = s_apply_xfer_clamp01_0((&_S2023->value0_37)->value0_36);
                    s_bwdCallableCtx_xfer_clamp01_0 _S2065;
                    (&_S2065)->_S48 = (&_S2023->value0_37)->value0_36;
                    s_paramCtx_s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2066;
                    (&_S2066)->value0_40 = _S2064.value0_10;
                    _runFlag_42 = false;
                    (&_S2040)->value0_43 = _S2066;
                    _S2044 = _S2065;
                }
                else
                {
                    _runFlag_42 = _runFlag_41;
                    (&_S2040)->value0_43 = _S2028;
                    (&_S2044)->_S48 = 0.0f;
                }
                if(_runFlag_42)
                {
                    Tuple_7 _S2067 = s_apply_xfer_max0_0((&_S2023->value0_37)->value0_36);
                    s_bwdCallableCtx_xfer_max0_0 _S2068;
                    (&_S2068)->_S51 = (&_S2023->value0_37)->value0_36;
                    s_paramCtx_s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2069;
                    (&_S2069)->value0_40 = _S2067.value0_11;
                    (&_S2041)->value0_43 = _S2069;
                    _S2047 = _S2068;
                }
                else
                {
                    (&_S2041)->value0_43 = _S2028;
                    (&_S2047)->_S51 = 0.0f;
                }
                s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2070 = _S2040;
                _S2040 = _S2041;
                _S2035 = _S2063;
                _S2041 = _S2070;
            }
            else
            {
                _runFlag_42 = false;
                (&_S2040)->value0_43 = _S2028;
                (&_S2047)->_S51 = 0.0f;
                _S2035 = false;
                (&_S2041)->value0_43 = _S2028;
                (&_S2044)->_S48 = 0.0f;
            }
            s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2071 = _S2039;
            s_bwdCallableCtx_xfer_clamp01_0 _S2072 = _S2043;
            _S2039 = _S2040;
            _S2040 = _S2041;
            _S2043 = _S2044;
            _S2036 = _S2057;
            _S2041 = _S2071;
            _S2044 = _S2072;
        }
        else
        {
            _runFlag_41 = false;
            _runFlag_42 = false;
            (&_S2039)->value0_43 = _S2028;
            (&_S2047)->_S51 = 0.0f;
            _S2035 = false;
            (&_S2040)->value0_43 = _S2028;
            (&_S2043)->_S48 = 0.0f;
            _S2036 = false;
            (&_S2041)->value0_43 = _S2028;
            (&_S2044)->_S48 = 0.0f;
            (&_S2048)->value0_45 = _S2029;
        }
        s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2073 = _S2038;
        s_bwdCallableCtx_xfer_clamp01_0 _S2074 = _S2042;
        s_bwdCallableCtx_xfer_max0_0 _S2075 = _S2046;
        _S2038 = _S2039;
        _S2046 = _S2047;
        _S2039 = _S2040;
        _S2042 = _S2043;
        _S2040 = _S2041;
        _S2043 = _S2044;
        _S2037 = _S2049;
        _S2041 = _S2073;
        _S2044 = _S2074;
        _S2047 = _S2075;
    }
    else
    {
        _runFlag_40 = false;
        _runFlag_41 = false;
        _runFlag_42 = false;
        (&_S2038)->value0_43 = _S2028;
        (&_S2046)->_S51 = 0.0f;
        _S2035 = false;
        (&_S2039)->value0_43 = _S2028;
        (&_S2042)->_S48 = 0.0f;
        _S2036 = false;
        (&_S2040)->value0_43 = _S2028;
        (&_S2043)->_S48 = 0.0f;
        (&_S2048)->value0_45 = _S2029;
        _S2037 = false;
        (&_S2041)->value0_43 = _S2028;
        (&_S2044)->_S48 = 0.0f;
        (&_S2045)->value0_44 = _S2027;
        (&_S2047)->_S51 = 0.0f;
    }
    float _S2076;
    float _S2077;
    if(_S2034)
    {
        if(_runFlag_40)
        {
            if(_runFlag_41)
            {
                if(_runFlag_42)
                {
                    float _S2078 = 0.0f;
                    s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2079 = _S2038;
                    s_bwdProp_linear_rgb_to_srgb_0(&_S2079, &_S2078, _S2025);
                    float _S2080 = 0.0f;
                    s_bwdCallableCtx_xfer_max0_0 _S2081 = _S2046;
                    s_bwdProp_xfer_max0_0(&_S2081, &_S2080, _S2078);
                    _S2076 = 0.0f;
                    _S2077 = _S2080;
                }
                else
                {
                    _S2076 = _S2025;
                    _S2077 = 0.0f;
                }
                if(_S2035)
                {
                    float _S2082 = 0.0f;
                    s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2083 = _S2039;
                    s_bwdProp_linear_rgb_to_srgb_0(&_S2083, &_S2082, _S2076);
                    float _S2084 = 0.0f;
                    s_bwdCallableCtx_xfer_clamp01_0 _S2085 = _S2042;
                    s_bwdProp_xfer_clamp01_0(&_S2085, &_S2084, _S2082);
                    float _S2086 = _S2084 + _S2077;
                    _S2076 = 0.0f;
                    _S2077 = _S2086;
                }
            }
            else
            {
                _S2076 = _S2025;
                _S2077 = 0.0f;
            }
            if(_S2036)
            {
                float _S2087 = 0.0f;
                s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2088 = _S2040;
                s_bwdProp_linear_rgb_to_srgb_0(&_S2088, &_S2087, _S2076);
                float _S2089 = 0.0f;
                s_bwdCallableCtx_xfer_clamp01_0 _S2090 = _S2043;
                s_bwdProp_xfer_clamp01_0(&_S2090, &_S2089, _S2087);
                float _S2091 = 0.0f;
                s_bwdCallableCtx_xfer_uncharted2_0 _S2092 = _S2048;
                s_bwdProp_xfer_uncharted2_0(&_S2092, &_S2091, _S2089);
                float _S2093 = _S2091 + _S2077;
                _S2076 = 0.0f;
                _S2077 = _S2093;
            }
        }
        else
        {
            _S2076 = _S2025;
            _S2077 = 0.0f;
        }
        if(_S2037)
        {
            float _S2094 = 0.0f;
            s_bwdCallableCtx_linear_rgb_to_srgb_0 _S2095 = _S2041;
            s_bwdProp_linear_rgb_to_srgb_0(&_S2095, &_S2094, _S2076);
            float _S2096 = 0.0f;
            s_bwdCallableCtx_xfer_clamp01_0 _S2097 = _S2044;
            s_bwdProp_xfer_clamp01_0(&_S2097, &_S2096, _S2094);
            float _S2098 = 0.0f;
            s_bwdCallableCtx_xfer_aces_0 _S2099 = _S2045;
            s_bwdProp_xfer_aces_0(&_S2099, &_S2098, _S2096);
            float _S2100 = 0.0f;
            s_bwdCallableCtx_xfer_max0_0 _S2101 = _S2047;
            s_bwdProp_xfer_max0_0(&_S2101, &_S2100, _S2098);
            float _S2102 = _S2100 + _S2077;
            _S2076 = 0.0f;
            _S2077 = _S2102;
        }
    }
    else
    {
        _S2076 = _S2025;
        _S2077 = 0.0f;
    }
    if(_S2031)
    {
        float _S2103 = 0.0f;
        s_bwdCallableCtx_xfer_filmic_0 _S2104 = _S2032;
        s_bwdProp_xfer_filmic_0(&_S2104, &_S2103, _S2076);
        _S2076 = _S2103 + _S2077;
    }
    else
    {
        _S2076 = _S2077;
    }
    *_S2024 = _S2076;
    return;
}

inline __device__ void s_bwdProp_srgb_to_linear_rgb_0(s_bwdCallableCtx_srgb_to_linear_rgb_0 * _S2105, float * _S2106, float _S2107)
{
    float _S2108 = (&_S2105->value0_34)->value0_33;
    bool _S2109 = ((&_S2105->value0_34)->value0_33) < 0.04044999927282333f;
    s_bwdCallableCtx_pow_0 _S2110;
    if(_S2109)
    {
        (&_S2110)->_S54 = 0.0f;
        (&_S2110)->_S55 = 0.0f;
    }
    else
    {
        s_bwdCallableCtx_pow_0 _S2111;
        (&_S2111)->_S54 = 0.94786733388900757f * (_S2108 + 0.05499999970197678f);
        (&_S2111)->_S55 = 2.40000009536743164f;
        _S2110 = _S2111;
    }
    float _S2112;
    if(_S2109)
    {
        _S2112 = 0.07739938050508499f * _S2107;
    }
    else
    {
        float _S2113 = 0.0f;
        float _S2114 = 0.0f;
        s_bwdCallableCtx_pow_0 _S2115 = _S2110;
        s_bwdProp_pow_0(&_S2115, &_S2113, &_S2114, _S2107);
        _S2112 = 0.94786733388900757f * _S2113;
    }
    *_S2106 = _S2112;
    return;
}

inline __device__ void s_bwdProp_working_to_display_0(s_bwdCallableCtx_working_to_display_0 * _S2116, float3  * _S2117, float3  _S2118)
{
    s_paramCtx_s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2119 = { 0.0f };
    bool _S2120 = !(&_S2116->value0_32)->value3_4;
    float3  _S2121;
    s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2122;
    s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2123;
    s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2124;
    if(_S2120)
    {
        float _S2125 = (&_S2116->value0_32)->value0_31.x;
        Tuple_18 _S2126 = s_apply_srgb_to_linear_rgb_0(_S2125);
        s_paramCtx_s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2127;
        (&_S2127)->value0_33 = _S2125;
        float _S2128 = (&_S2116->value0_32)->value0_31.y;
        Tuple_18 _S2129 = s_apply_srgb_to_linear_rgb_0(_S2128);
        s_paramCtx_s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2130;
        (&_S2130)->value0_33 = _S2128;
        float _S2131 = (&_S2116->value0_32)->value0_31.z;
        Tuple_18 _S2132 = s_apply_srgb_to_linear_rgb_0(_S2131);
        s_paramCtx_s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2133;
        (&_S2133)->value0_33 = _S2131;
        _S2121 = make_float3 (_S2126.value0_35, _S2129.value0_35, _S2132.value0_35);
        (&_S2122)->value0_34 = _S2133;
        (&_S2123)->value0_34 = _S2130;
        (&_S2124)->value0_34 = _S2127;
    }
    else
    {
        _S2121 = (&_S2116->value0_32)->value0_31;
        (&_S2122)->value0_34 = _S2119;
        (&_S2123)->value0_34 = _S2119;
        (&_S2124)->value0_34 = _S2119;
    }
    Tuple_11 _S2134 = s_apply_mul_0((&_S2116->value0_32)->value1_12, _S2121);
    s_bwdCallableCtx_mul_0 _S2135;
    (&_S2135)->_S86 = (&_S2116->value0_32)->value1_12;
    (&_S2135)->_S87 = _S2121;
    s_bwdCallableCtx_mul_0 _S2136 = _S2135;
    s_paramCtx_s_bwdCallableCtx_tone_encode_0 _S2137;
    (&_S2137)->value0_36 = _S2134.value0_15.x;
    (&_S2137)->value1_13 = (&_S2116->value0_32)->value2_4;
    s_paramCtx_s_bwdCallableCtx_tone_encode_0 _S2138 = _S2137;
    s_paramCtx_s_bwdCallableCtx_tone_encode_0 _S2139;
    (&_S2139)->value0_36 = _S2134.value0_15.y;
    (&_S2139)->value1_13 = (&_S2116->value0_32)->value2_4;
    s_paramCtx_s_bwdCallableCtx_tone_encode_0 _S2140 = _S2139;
    s_paramCtx_s_bwdCallableCtx_tone_encode_0 _S2141;
    (&_S2141)->value0_36 = _S2134.value0_15.z;
    (&_S2141)->value1_13 = (&_S2116->value0_32)->value2_4;
    s_paramCtx_s_bwdCallableCtx_tone_encode_0 _S2142 = _S2141;
    float _S2143 = 0.0f;
    s_bwdCallableCtx_tone_encode_0 _S2144;
    (&_S2144)->value0_37 = _S2142;
    s_bwdProp_tone_encode_0(&_S2144, &_S2143, _S2118.z);
    float _S2145 = 0.0f;
    s_bwdCallableCtx_tone_encode_0 _S2146;
    (&_S2146)->value0_37 = _S2140;
    s_bwdProp_tone_encode_0(&_S2146, &_S2145, _S2118.y);
    float _S2147 = 0.0f;
    s_bwdCallableCtx_tone_encode_0 _S2148;
    (&_S2148)->value0_37 = _S2138;
    s_bwdProp_tone_encode_0(&_S2148, &_S2147, _S2118.x);
    float3  _S2149 = make_float3 (_S2147, _S2145, _S2143);
    Matrix<float, 3, 3>  _S2150 = makeMatrix<float, 3, 3> (0.0f);
    float3  _S2151 = make_float3 (0.0f);
    s_bwdCallableCtx_mul_0 _S2152 = _S2136;
    s_bwdProp_mul_0(&_S2152, &_S2150, &_S2151, _S2149);
    float3  _S2153 = _S2151;
    if(_S2120)
    {
        float _S2154 = 0.0f;
        s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2155 = _S2122;
        s_bwdProp_srgb_to_linear_rgb_0(&_S2155, &_S2154, _S2153.z);
        float _S2156 = 0.0f;
        s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2157 = _S2123;
        s_bwdProp_srgb_to_linear_rgb_0(&_S2157, &_S2156, _S2153.y);
        float _S2158 = 0.0f;
        s_bwdCallableCtx_srgb_to_linear_rgb_0 _S2159 = _S2124;
        s_bwdProp_srgb_to_linear_rgb_0(&_S2159, &_S2158, _S2153.x);
        _S2121 = make_float3 (_S2158, _S2156, _S2154);
    }
    else
    {
        _S2121 = _S2153;
    }
    *_S2117 = _S2121;
    return;
}

inline __device__ void _S2160(DiffPair_vectorx3Cfloatx2C3x3E_0 * _S2161, Matrix<float, 3, 3>  _S2162, int _S2163, bool _S2164, float3  _S2165)
{
    s_paramCtx_s_bwdCallableCtx_working_to_display_0 _S2166;
    (&_S2166)->value0_31 = _S2161->primal_0;
    (&_S2166)->value1_12 = _S2162;
    (&_S2166)->value2_4 = _S2163;
    (&_S2166)->value3_4 = _S2164;
    s_bwdCallableCtx_working_to_display_0 _S2167;
    (&_S2167)->value0_32 = _S2166;
    s_bwdProp_working_to_display_0(&_S2167, &_S2161->differential_0, _S2165);
    return;
}

inline __device__ DiffPair_float_0 _d_pow_1(DiffPair_float_0 * dpx_8, DiffPair_float_0 * dpy_5)
{
    float _S2168 = dpx_8->primal_0;
    if((dpx_8->primal_0) < 9.99999997475242708e-07f)
    {
        DiffPair_float_0 _S2169 = { 0.0f, 0.0f };
        return _S2169;
    }
    float val_1 = (F32_pow((_S2168), (dpy_5->primal_0)));
    DiffPair_float_0 _S2170 = { val_1, val_1 * (F32_log((_S2168))) * dpy_5->differential_0 + val_1 * dpy_5->primal_0 / _S2168 * dpx_8->differential_0 };
    return _S2170;
}

inline __device__ float3  max_0(float3  x_21, float3  y_5)
{
    float3  result_8;
    int i_6 = int(0);
    for(;;)
    {
        if(i_6 < int(3))
        {
        }
        else
        {
            break;
        }
        *_slang_vector_get_element_ptr(&result_8, i_6) = (F32_max((_slang_vector_get_element(x_21, i_6)), (_slang_vector_get_element(y_5, i_6))));
        i_6 = i_6 + int(1);
    }
    return result_8;
}

inline __device__ float3  min_0(float3  x_22, float3  y_6)
{
    float3  result_9;
    int i_7 = int(0);
    for(;;)
    {
        if(i_7 < int(3))
        {
        }
        else
        {
            break;
        }
        *_slang_vector_get_element_ptr(&result_9, i_7) = (F32_min((_slang_vector_get_element(x_22, i_7)), (_slang_vector_get_element(y_6, i_7))));
        i_7 = i_7 + int(1);
    }
    return result_9;
}

struct s_paramCtx_s_bwdCallableCtx_rendered_depth_to_expected_depth_0
{
    float value0_51;
    float value1_14;
};

struct s_bwdCallableCtx_rendered_depth_to_expected_depth_0
{
    s_paramCtx_s_bwdCallableCtx_rendered_depth_to_expected_depth_0 value0_52;
};

inline __device__ void s_bwdProp_rendered_depth_to_expected_depth_0(s_bwdCallableCtx_rendered_depth_to_expected_depth_0 * _S2171, float * _S2172, float * _S2173, float _S2174)
{
    float _S2175 = 1.0f - (&_S2171->value0_52)->value1_14;
    Tuple_12 _S2176 = s_apply_max_0(_S2175, 1.00000001335143196e-10f);
    s_bwdCallableCtx_max_0 _S2177;
    (&_S2177)->_S94 = _S2175;
    (&_S2177)->_S95 = 1.00000001335143196e-10f;
    float _S2178 = _S2174 / (_S2176.value0_16 * _S2176.value0_16);
    float _S2179 = (&_S2171->value0_52)->value0_51 * - _S2178;
    float _S2180 = _S2176.value0_16 * _S2178;
    float _S2181 = 0.0f;
    float _S2182 = 0.0f;
    s_bwdCallableCtx_max_0 _S2183 = _S2177;
    s_bwdProp_max_0(&_S2183, &_S2181, &_S2182, _S2179);
    float _S2184 = - _S2181;
    *_S2172 = _S2180;
    *_S2173 = _S2184;
    return;
}

inline __device__ void _S2185(DiffPair_float_0 * _S2186, DiffPair_float_0 * _S2187, float _S2188)
{
    s_paramCtx_s_bwdCallableCtx_rendered_depth_to_expected_depth_0 _S2189;
    (&_S2189)->value0_51 = _S2186->primal_0;
    (&_S2189)->value1_14 = _S2187->primal_0;
    s_bwdCallableCtx_rendered_depth_to_expected_depth_0 _S2190;
    (&_S2190)->value0_52 = _S2189;
    s_bwdProp_rendered_depth_to_expected_depth_0(&_S2190, &_S2186->differential_0, &_S2187->differential_0, _S2188);
    return;
}

inline __device__ float rendered_depth_to_expected_depth(float depth_0, float transmittance_0)
{
    return depth_0 / (F32_max((1.0f - transmittance_0), (1.00000001335143196e-10f)));
}

inline __device__ void rendered_depth_to_expected_depth_bwd(float depth_1, float transmittance_1, float v_out_depth_0, float * v_depth_0, float * v_transmittance_0)
{
    DiffPair_float_0 p_depth_0;
    (&p_depth_0)->primal_0 = depth_1;
    (&p_depth_0)->differential_0 = 0.0f;
    DiffPair_float_0 p_transmittance_0;
    (&p_transmittance_0)->primal_0 = transmittance_1;
    (&p_transmittance_0)->differential_0 = 0.0f;
    _S2185(&p_depth_0, &p_transmittance_0, v_out_depth_0);
    *v_depth_0 = p_depth_0.differential_0;
    *v_transmittance_0 = p_transmittance_0.differential_0;
    return;
}

inline __device__ float3  blend_background(float3  rgb_0, float transmittance_2, float3  background_0)
{
    return rgb_0 + make_float3 (transmittance_2) * background_0;
}

inline __device__ float3  overexposure_grad(float3  c_2, float scale_0)
{
    float3  _S2191 = make_float3 (0.0f);
    return make_float3 (scale_0) * (min_0(c_2, _S2191) + max_0(c_2 - make_float3 (1.0f), _S2191));
}

inline __device__ void blend_background_bwd_impl_0(DiffPair_vectorx3Cfloatx2C3x3E_0 * dp_rgb_0, DiffPair_float_0 * dp_transmittance_0, DiffPair_vectorx3Cfloatx2C3x3E_0 * dp_background_0, float3  v_out_1)
{
    DiffPair_float_0 _S2192 = *dp_transmittance_0;
    DiffPair_vectorx3Cfloatx2C3x3E_0 _S2193 = *dp_background_0;
    dp_rgb_0->primal_0 = (*dp_rgb_0).primal_0;
    dp_rgb_0->differential_0 = v_out_1;
    float _S2194 = dot_1(_S2193.primal_0, v_out_1);
    dp_transmittance_0->primal_0 = _S2192.primal_0;
    dp_transmittance_0->differential_0 = _S2194;
    float3  _S2195 = make_float3 (_S2192.primal_0) * v_out_1;
    dp_background_0->primal_0 = _S2193.primal_0;
    dp_background_0->differential_0 = _S2195;
    return;
}

inline __device__ void blend_background_bwd(float3  rgb_1, float transmittance_3, float3  background_1, float3  v_out_rgb_0, float overexposure_scale_0, float3  * v_rgb_0, float * v_transmittance_1, float3  * v_background_0)
{
    float3  _S2196;
    if(overexposure_scale_0 != 0.0f)
    {
        _S2196 = v_out_rgb_0 + overexposure_grad(rgb_1 + make_float3 (transmittance_3) * background_1, overexposure_scale_0);
    }
    else
    {
        _S2196 = v_out_rgb_0;
    }
    float3  _S2197 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 p_rgb_0;
    (&p_rgb_0)->primal_0 = rgb_1;
    (&p_rgb_0)->differential_0 = _S2197;
    DiffPair_float_0 p_transmittance_1;
    (&p_transmittance_1)->primal_0 = transmittance_3;
    (&p_transmittance_1)->differential_0 = 0.0f;
    DiffPair_vectorx3Cfloatx2C3x3E_0 p_background_0;
    (&p_background_0)->primal_0 = background_1;
    (&p_background_0)->differential_0 = _S2197;
    blend_background_bwd_impl_0(&p_rgb_0, &p_transmittance_1, &p_background_0, _S2196);
    *v_rgb_0 = p_rgb_0.differential_0;
    *v_transmittance_1 = p_transmittance_1.differential_0;
    *v_background_0 = p_background_0.differential_0;
    return;
}

inline __device__ float linear_rgb_to_srgb(float x_23)
{
    float _S2198;
    if(x_23 < 0.00313080009073019f)
    {
        _S2198 = x_23 * 12.92000007629394531f;
    }
    else
    {
        _S2198 = 1.0549999475479126f * (F32_pow((x_23), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    return _S2198;
}

inline __device__ float linear_rgb_to_srgb_grad(float x_24)
{
    float _S2199;
    if(x_24 < 0.00313080009073019f)
    {
        _S2199 = 12.92000007629394531f;
    }
    else
    {
        DiffPair_float_0 _S2200;
        (&_S2200)->primal_0 = x_24;
        (&_S2200)->differential_0 = 1.0f;
        DiffPair_float_0 _S2201;
        (&_S2201)->primal_0 = 0.4166666567325592f;
        (&_S2201)->differential_0 = 0.0f;
        DiffPair_float_0 _S2202 = _d_pow_1(&_S2200, &_S2201);
        _S2199 = _S2202.differential_0 * 1.0549999475479126f;
    }
    return _S2199;
}

inline __device__ float srgb_to_linear_rgb(float x_25)
{
    float _S2203;
    if(x_25 < 0.04044999927282333f)
    {
        _S2203 = x_25 * 0.07739938050508499f;
    }
    else
    {
        _S2203 = (F32_pow((0.94786733388900757f * (x_25 + 0.05499999970197678f)), (2.40000009536743164f)));
    }
    return _S2203;
}

inline __device__ float srgb_to_linear_rgb_grad(float x_26)
{
    float _S2204;
    if(x_26 < 0.04044999927282333f)
    {
        _S2204 = 0.07739938050508499f;
    }
    else
    {
        DiffPair_float_0 _S2205;
        (&_S2205)->primal_0 = 0.94786733388900757f * (x_26 + 0.05499999970197678f);
        (&_S2205)->differential_0 = 0.94786733388900757f;
        DiffPair_float_0 _S2206;
        (&_S2206)->primal_0 = 2.40000009536743164f;
        (&_S2206)->differential_0 = 0.0f;
        DiffPair_float_0 _S2207 = _d_pow_1(&_S2205, &_S2206);
        _S2204 = _S2207.differential_0;
    }
    return _S2204;
}

inline __device__ float splat_dc_encode(float dc_0)
{
    return 2.0f * (F32_log(((F32_max((0.564189612865448f * dc_0 + 1.0f), (9.999999960041972e-13f))))));
}

inline __device__ float splat_dc_decode(float x_27)
{
    return ((F32_exp((0.5f * x_27))) - 1.0f) * 1.77245378494262695f;
}

inline __device__ float xfer_filmic_0(float x_28)
{
    float t_1 = xfer_max0_0(x_28 - 0.00400000018998981f);
    float _S2208 = 6.19999980926513672f * t_1;
    return t_1 * (_S2208 + 0.5f) / (t_1 * (_S2208 + 1.70000004768371582f) + 0.05999999865889549f);
}

inline __device__ float xfer_aces_0(float x_29)
{
    return x_29 * (2.50999999046325684f * x_29 + 0.02999999932944775f) / (x_29 * (2.43000006675720215f * x_29 + 0.5899999737739563f) + 0.14000000059604645f);
}

inline __device__ float xfer_hable_0(float x_30)
{
    float _S2209 = 0.15000000596046448f * x_30;
    return (x_30 * (_S2209 + 0.05000000074505806f) + 0.00400000018998981f) / (x_30 * (_S2209 + 0.5f) + 0.06000000238418579f) - 0.06666666269302368f;
}

inline __device__ float xfer_uncharted2_0(float x_31)
{
    return xfer_hable_0(xfer_max0_0(x_31)) / xfer_hable_0(11.19999980926513672f);
}

inline __device__ float tone_encode_0(float x_32, int transfer_0)
{
    if(transfer_0 == int(3))
    {
        return xfer_filmic_0(x_32);
    }
    float _S2210;
    if(transfer_0 == int(2))
    {
        float _S2211 = xfer_clamp01_0(xfer_aces_0(xfer_max0_0(x_32)));
        if(_S2211 < 0.00313080009073019f)
        {
            _S2210 = _S2211 * 12.92000007629394531f;
        }
        else
        {
            _S2210 = 1.0549999475479126f * (F32_pow((_S2211), (0.4166666567325592f))) - 0.05499999970197678f;
        }
        return _S2210;
    }
    if(transfer_0 == int(4))
    {
        float _S2212 = xfer_clamp01_0(xfer_uncharted2_0(x_32));
        if(_S2212 < 0.00313080009073019f)
        {
            _S2210 = _S2212 * 12.92000007629394531f;
        }
        else
        {
            _S2210 = 1.0549999475479126f * (F32_pow((_S2212), (0.4166666567325592f))) - 0.05499999970197678f;
        }
        return _S2210;
    }
    if(transfer_0 == int(1))
    {
        float _S2213 = xfer_clamp01_0(x_32);
        if(_S2213 < 0.00313080009073019f)
        {
            _S2210 = _S2213 * 12.92000007629394531f;
        }
        else
        {
            _S2210 = 1.0549999475479126f * (F32_pow((_S2213), (0.4166666567325592f))) - 0.05499999970197678f;
        }
        return _S2210;
    }
    float _S2214 = xfer_max0_0(x_32);
    if(_S2214 < 0.00313080009073019f)
    {
        _S2210 = _S2214 * 12.92000007629394531f;
    }
    else
    {
        _S2210 = 1.0549999475479126f * (F32_pow((_S2214), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    return _S2210;
}

inline __device__ float3  working_to_display(float3  rgb_2, Matrix<float, 3, 3>  color_matrix_0, int transfer_1, bool is_linear_0)
{
    float3  _S2215;
    if(!is_linear_0)
    {
        float _S2216 = rgb_2.x;
        float _S2217;
        if(_S2216 < 0.04044999927282333f)
        {
            _S2217 = _S2216 * 0.07739938050508499f;
        }
        else
        {
            _S2217 = (F32_pow((0.94786733388900757f * (_S2216 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        float _S2218 = rgb_2.y;
        float _S2219;
        if(_S2218 < 0.04044999927282333f)
        {
            _S2219 = _S2218 * 0.07739938050508499f;
        }
        else
        {
            _S2219 = (F32_pow((0.94786733388900757f * (_S2218 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        float _S2220 = rgb_2.z;
        float _S2221;
        if(_S2220 < 0.04044999927282333f)
        {
            _S2221 = _S2220 * 0.07739938050508499f;
        }
        else
        {
            _S2221 = (F32_pow((0.94786733388900757f * (_S2220 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        _S2215 = make_float3 (_S2217, _S2219, _S2221);
    }
    else
    {
        _S2215 = rgb_2;
    }
    float3  _S2222 = mul_0(color_matrix_0, _S2215);
    return make_float3 (tone_encode_0(_S2222.x, transfer_1), tone_encode_0(_S2222.y, transfer_1), tone_encode_0(_S2222.z, transfer_1));
}

inline __device__ float3  working_to_display_bwd(float3  rgb_3, Matrix<float, 3, 3>  color_matrix_1, int transfer_2, bool is_linear_1, float3  v_out_rgb_1)
{
    float3  _S2223 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 p_rgb_1;
    (&p_rgb_1)->primal_0 = rgb_3;
    (&p_rgb_1)->differential_0 = _S2223;
    _S2160(&p_rgb_1, color_matrix_1, transfer_2, is_linear_1, v_out_rgb_1);
    return p_rgb_1.differential_0;
}

inline __device__ float xfer_filmic_inv_0(float y_7)
{
    float _S2224 = (F32_min((y_7), (xfer_filmic_0(11.19999980926513672f))));
    float a_4 = 6.19999980926513672f * (1.0f - _S2224);
    float b_4 = 0.5f - 1.70000004768371582f * _S2224;
    return (- b_4 + (F32_sqrt(((F32_max((b_4 * b_4 - 4.0f * a_4 * (-0.05999999865889549f * _S2224)), (0.0f))))))) / (2.0f * a_4) + 0.00400000018998981f;
}

inline __device__ float xfer_aces_inv_0(float y_8)
{
    float a_5 = 2.50999999046325684f - 2.43000006675720215f * y_8;
    float b_5 = 0.02999999932944775f - 0.5899999737739563f * y_8;
    return (- b_5 + (F32_sqrt(((F32_max((b_5 * b_5 - 4.0f * a_5 * (-0.14000000059604645f * y_8)), (0.0f))))))) / (2.0f * a_5);
}

inline __device__ float xfer_uncharted2_inv_0(float y_9)
{
    float r_4 = y_9 * xfer_hable_0(11.19999980926513672f) + 0.06666666269302368f;
    float a_6 = 0.15000000596046448f * (1.0f - r_4);
    float b_6 = 0.5f * (0.10000000149011612f - r_4);
    return (- b_6 + (F32_sqrt(((F32_max((b_6 * b_6 - 4.0f * a_6 * (0.20000000298023224f * (0.01999999955296516f - r_4 * 0.30000001192092896f))), (0.0f))))))) / (2.0f * a_6);
}

inline __device__ float tone_decode_0(float d_1, int transfer_3)
{
    if(transfer_3 == int(3))
    {
        return xfer_filmic_inv_0(d_1);
    }
    float _S2225;
    if(transfer_3 == int(2))
    {
        if(d_1 < 0.04044999927282333f)
        {
            _S2225 = d_1 * 0.07739938050508499f;
        }
        else
        {
            _S2225 = (F32_pow((0.94786733388900757f * (d_1 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        return xfer_aces_inv_0(_S2225);
    }
    if(transfer_3 == int(4))
    {
        if(d_1 < 0.04044999927282333f)
        {
            _S2225 = d_1 * 0.07739938050508499f;
        }
        else
        {
            _S2225 = (F32_pow((0.94786733388900757f * (d_1 + 0.05499999970197678f)), (2.40000009536743164f)));
        }
        return xfer_uncharted2_inv_0(_S2225);
    }
    if(d_1 < 0.04044999927282333f)
    {
        _S2225 = d_1 * 0.07739938050508499f;
    }
    else
    {
        _S2225 = (F32_pow((0.94786733388900757f * (d_1 + 0.05499999970197678f)), (2.40000009536743164f)));
    }
    return _S2225;
}

inline __device__ float3  display_to_working3(float3  rgb_4, int transfer_4, bool is_linear_2)
{
    float _S2226 = tone_decode_0(rgb_4.x, transfer_4);
    float _S2227 = tone_decode_0(rgb_4.y, transfer_4);
    float _S2228 = tone_decode_0(rgb_4.z, transfer_4);
    float3  lin_0 = make_float3 (_S2226, _S2227, _S2228);
    if(is_linear_2)
    {
        return lin_0;
    }
    float _S2229;
    if(_S2226 < 0.00313080009073019f)
    {
        _S2229 = _S2226 * 12.92000007629394531f;
    }
    else
    {
        _S2229 = 1.0549999475479126f * (F32_pow((_S2226), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    float _S2230;
    if(_S2227 < 0.00313080009073019f)
    {
        _S2230 = _S2227 * 12.92000007629394531f;
    }
    else
    {
        _S2230 = 1.0549999475479126f * (F32_pow((_S2227), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    float _S2231;
    if(_S2228 < 0.00313080009073019f)
    {
        _S2231 = _S2228 * 12.92000007629394531f;
    }
    else
    {
        _S2231 = 1.0549999475479126f * (F32_pow((_S2228), (0.4166666567325592f))) - 0.05499999970197678f;
    }
    return make_float3 (_S2229, _S2230, _S2231);
}

inline __device__ float3  background_apply_exponent(float3  display_0, float p_0)
{
    if(p_0 == 1.0f)
    {
        return display_0;
    }
    return make_float3 ((F32_pow(((F32_max((display_0.x), (0.0f)))), (p_0))), (F32_pow(((F32_max((display_0.y), (0.0f)))), (p_0))), (F32_pow(((F32_max((display_0.z), (0.0f)))), (p_0))));
}

inline __device__ float3  points_to_normal(FixedArray<float3 , 4>  points_16)
{
    float3  _S2232 = points_16[int(0)];
    bool _S2233;
    if((dot_1(_S2232, _S2232)) == 0.0f)
    {
        _S2233 = true;
    }
    else
    {
        float3  _S2234 = points_16[int(1)];
        _S2233 = (dot_1(_S2234, _S2234)) == 0.0f;
    }
    if(_S2233)
    {
        _S2233 = true;
    }
    else
    {
        float3  _S2235 = points_16[int(2)];
        _S2233 = (dot_1(_S2235, _S2235)) == 0.0f;
    }
    if(_S2233)
    {
        _S2233 = true;
    }
    else
    {
        float3  _S2236 = points_16[int(3)];
        _S2233 = (dot_1(_S2236, _S2236)) == 0.0f;
    }
    if(_S2233)
    {
        return make_float3 (0.0f);
    }
    float3  normal_12 = cross_0(points_16[int(1)] - points_16[int(0)], - (points_16[int(3)] - points_16[int(2)]));
    float3  normal_13;
    if((dot_1(normal_12, normal_12)) != 0.0f)
    {
        normal_13 = normal_12 / make_float3 (length_1(normal_12));
    }
    else
    {
        normal_13 = normal_12;
    }
    return normal_13;
}

inline __device__ void points_to_normal_vjp(FixedArray<float3 , 4>  points_17, float3  v_normal_0, FixedArray<float3 , 4>  * v_points_0)
{
    FixedArray<float3 , 4>  _S2237;
    Array_dzero_1(&_S2237);
    DiffPair_arrayx3Cvectorx3Cfloatx2C3x3Ex2C4x3E_0 dp_points_0;
    (&dp_points_0)->primal_0 = points_17;
    (&dp_points_0)->differential_0 = _S2237;
    _S1948(&dp_points_0, v_normal_0);
    *v_points_0 = (&dp_points_0)->differential_0;
    return;
}

inline __device__ float3  unproject_raydir_0(float2  uv_47, int camera_model_13, bool is_ray_depth_13)
{
    float3  raydir_9;
    bool is_unit_1;
    if(camera_model_13 == int(1))
    {
        float theta_4 = length_0(uv_47);
        float3  _S2238 = make_float3 ((uv_47 / make_float2 ((F32_max((theta_4), (1.00000001168609742e-07f)))) * make_float2 ((F32_sin((theta_4))))).x, (uv_47 / make_float2 ((F32_max((theta_4), (1.00000001168609742e-07f)))) * make_float2 ((F32_sin((theta_4))))).y, (F32_cos((theta_4))));
        is_unit_1 = true;
        raydir_9 = _S2238;
    }
    else
    {
        if(camera_model_13 == int(2))
        {
            float r_5 = length_0(uv_47);
            float3  _S2239 = make_float3 ((uv_47 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_5 * r_5)))))))).x, (uv_47 * make_float2 ((F32_sqrt(((F32_max((0.0f), (1.0f - 0.25f * r_5 * r_5)))))))).y, 1.0f - 0.5f * r_5 * r_5);
            is_unit_1 = true;
            raydir_9 = _S2239;
        }
        else
        {
            bool _S2240 = camera_model_13 == int(3);
            if(_S2240)
            {
                float lon_1 = uv_47.x;
                float lat_1 = uv_47.y;
                float cl_0 = (F32_cos((lat_1)));
                raydir_9 = make_float3 (cl_0 * (F32_sin((lon_1))), (F32_sin((lat_1))), cl_0 * (F32_cos((lon_1))));
            }
            else
            {
                raydir_9 = make_float3 (uv_47.x, uv_47.y, 1.0f);
            }
            is_unit_1 = _S2240;
        }
    }
    if(is_ray_depth_13)
    {
        if(is_unit_1)
        {
        }
        else
        {
            raydir_9 = normalize_0(raydir_9);
        }
    }
    else
    {
        raydir_9 = raydir_9 / make_float3 (raydir_9.z);
    }
    return raydir_9;
}

inline __device__ float3  generate_ray_d2n_none(float2  pix_pos_4, float4  intrins_12, FixedArray<float, 1>  dist_coeffs_16, int camera_model_14, bool is_ray_depth_14)
{
    float3  _S2241;
    for(;;)
    {
        float2  uv_48 = (pix_pos_4 - float2 {intrins_12.z, intrins_12.w}) / float2 {intrins_12.x, intrins_12.y};
        FixedArray<float, 1>  _S2242 = dist_coeffs_16;
        float2  uv_u_40;
        bool _S2243 = undistort_point_3(uv_48, &_S2242, int(12), &uv_u_40);
        if(!_S2243)
        {
            int3  _S2244 = make_int3 (int(0));
            float3  _S2245 = make_float3 ((float)_S2244.x, (float)_S2244.y, (float)_S2244.z);
            _S2241 = _S2245;
            break;
        }
        _S2241 = unproject_raydir_0(uv_u_40, camera_model_14, is_ray_depth_14);
        break;
    }
    return _S2241;
}

inline __device__ float3  depth_to_point_none(float2  pix_pos_5, float4  intrins_13, FixedArray<float, 1>  dist_coeffs_17, int camera_model_15, bool is_ray_depth_15, float depth_2)
{
    float3  _S2246;
    for(;;)
    {
        float2  uv_49 = (pix_pos_5 - float2 {intrins_13.z, intrins_13.w}) / float2 {intrins_13.x, intrins_13.y};
        FixedArray<float, 1>  _S2247 = dist_coeffs_17;
        float2  uv_u_41;
        bool _S2248 = undistort_point_3(uv_49, &_S2247, int(12), &uv_u_41);
        if(!_S2248)
        {
            _S2246 = make_float3 (0.0f);
            break;
        }
        _S2246 = make_float3 (depth_2) * unproject_raydir_0(uv_u_41, camera_model_15, is_ray_depth_15);
        break;
    }
    return _S2246;
}

inline __device__ float depth_to_point_vjp_none(float2  pix_pos_6, float4  intrins_14, FixedArray<float, 1>  dist_coeffs_18, int camera_model_16, bool is_ray_depth_16, float depth_3, float3  v_point_0)
{
    DiffPair_float_0 dp_depth_0;
    (&dp_depth_0)->primal_0 = depth_3;
    (&dp_depth_0)->differential_0 = 0.0f;
    FixedArray<float, 1>  _S2249 = dist_coeffs_18;
    _S1843(pix_pos_6, intrins_14, &_S2249, camera_model_16, is_ray_depth_16, &dp_depth_0, v_point_0);
    return dp_depth_0.differential_0;
}

inline __device__ float3  depth_to_normal_none(float2  pix_center_8, float4  intrins_15, FixedArray<float, 1>  dist_coeffs_19, int camera_model_17, bool is_ray_depth_17, float4  depths_0)
{
    float3  normal_14;
    int _S2250;
    float3  * _S2251;
    float3  * _S2252;
    float3  * _S2253;
    float3  * _S2254;
    for(;;)
    {
        bool _S2255;
        if((depths_0.x) == 0.0f)
        {
            _S2255 = true;
        }
        else
        {
            _S2255 = (depths_0.y) == 0.0f;
        }
        if(_S2255)
        {
            _S2255 = true;
        }
        else
        {
            _S2255 = (depths_0.z) == 0.0f;
        }
        if(_S2255)
        {
            _S2255 = true;
        }
        else
        {
            _S2255 = (depths_0.w) == 0.0f;
        }
        if(_S2255)
        {
            normal_14 = make_float3 (0.0f);
            break;
        }
        FixedArray<float3 , 4>  points_18;
        for(;;)
        {
            float2  _S2256 = float2 {intrins_15.z, intrins_15.w};
            float2  _S2257 = float2 {intrins_15.x, intrins_15.y};
            float2  uv_50 = (pix_center_8 + make_float2 (-1.0f, -0.0f) - _S2256) / _S2257;
            FixedArray<float, 1>  _S2258 = dist_coeffs_19;
            float2  uv_u_42;
            bool _S2259 = undistort_point_3(uv_50, &_S2258, int(12), &uv_u_42);
            if(!_S2259)
            {
                float3  _S2260 = make_float3 (0.0f);
                _S2250 = int(0);
                normal_14 = _S2260;
                break;
            }
            points_18[int(0)] = make_float3 (depths_0.x) * unproject_raydir_0(uv_u_42, camera_model_17, is_ray_depth_17);
            for(;;)
            {
                float2  uv_51 = (pix_center_8 + make_float2 (1.0f, -0.0f) - _S2256) / _S2257;
                FixedArray<float, 1>  _S2261 = dist_coeffs_19;
                float2  uv_u_43;
                bool _S2262 = undistort_point_3(uv_51, &_S2261, int(12), &uv_u_43);
                if(!_S2262)
                {
                    float3  _S2263 = make_float3 (0.0f);
                    _S2250 = int(0);
                    normal_14 = _S2263;
                    break;
                }
                points_18[int(1)] = make_float3 (depths_0.y) * unproject_raydir_0(uv_u_43, camera_model_17, is_ray_depth_17);
                _S2250 = int(2);
                _S2251 = &points_18[int(1)];
                break;
            }
            if(_S2250 != int(2))
            {
                _S2252 = &points_18[int(0)];
                break;
            }
            float2  uv_52 = (pix_center_8 + make_float2 (0.0f, -1.0f) - _S2256) / _S2257;
            FixedArray<float, 1>  _S2264 = dist_coeffs_19;
            float2  uv_u_44;
            bool _S2265 = undistort_point_3(uv_52, &_S2264, int(12), &uv_u_44);
            if(!_S2265)
            {
                float3  _S2266 = make_float3 (0.0f);
                _S2250 = int(0);
                _S2252 = &points_18[int(0)];
                normal_14 = _S2266;
                break;
            }
            points_18[int(2)] = make_float3 (depths_0.z) * unproject_raydir_0(uv_u_44, camera_model_17, is_ray_depth_17);
            for(;;)
            {
                float2  uv_53 = (pix_center_8 + make_float2 (0.0f, 1.0f) - _S2256) / _S2257;
                FixedArray<float, 1>  _S2267 = dist_coeffs_19;
                float2  uv_u_45;
                bool _S2268 = undistort_point_3(uv_53, &_S2267, int(12), &uv_u_45);
                if(!_S2268)
                {
                    float3  _S2269 = make_float3 (0.0f);
                    _S2250 = int(0);
                    normal_14 = _S2269;
                    break;
                }
                points_18[int(3)] = make_float3 (depths_0.w) * unproject_raydir_0(uv_u_45, camera_model_17, is_ray_depth_17);
                _S2250 = int(2);
                _S2252 = &points_18[int(3)];
                break;
            }
            if(_S2250 != int(2))
            {
                float3  * _S2270 = _S2252;
                _S2252 = &points_18[int(0)];
                _S2253 = _S2270;
                _S2254 = &points_18[int(2)];
                break;
            }
            float3  * _S2271 = _S2252;
            _S2250 = int(1);
            _S2252 = &points_18[int(0)];
            _S2253 = _S2271;
            _S2254 = &points_18[int(2)];
            break;
        }
        if(_S2250 != int(1))
        {
            break;
        }
        float3  normal_15 = cross_0(*_S2251 - *_S2252, - (*_S2253 - *_S2254));
        if((dot_1(normal_15, normal_15)) != 0.0f)
        {
            normal_14 = normal_15 / make_float3 (length_1(normal_15));
        }
        else
        {
            normal_14 = normal_15;
        }
        break;
    }
    return normal_14;
}

inline __device__ void depth_to_normal_vjp_none(float2  pix_center_9, float4  intrins_16, FixedArray<float, 1>  dist_coeffs_20, int camera_model_18, bool is_ray_depth_18, float4  depths_1, float3  v_normal_1, float4  * v_depths_0)
{
    float4  _S2272 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_depths_0;
    (&dp_depths_0)->primal_0 = depths_1;
    (&dp_depths_0)->differential_0 = _S2272;
    FixedArray<float, 1>  _S2273 = dist_coeffs_20;
    _S1816(pix_center_9, intrins_16, &_S2273, camera_model_18, is_ray_depth_18, &dp_depths_0, v_normal_1);
    *v_depths_0 = dp_depths_0.differential_0;
    return;
}

inline __device__ float ray_depth_to_linear_depth_factor_none(float2  pix_center_10, float4  intrins_17, FixedArray<float, 1>  dist_coeffs_21, int camera_model_19)
{
    float _S2274;
    for(;;)
    {
        float2  uv_54 = (pix_center_10 - float2 {intrins_17.z, intrins_17.w}) / float2 {intrins_17.x, intrins_17.y};
        FixedArray<float, 1>  _S2275 = dist_coeffs_21;
        float2  uv_u_46;
        bool _S2276 = undistort_point_3(uv_54, &_S2275, int(12), &uv_u_46);
        if(!_S2276)
        {
            _S2274 = 0.0f;
            break;
        }
        float3  raydir_10 = unproject_raydir_0(uv_u_46, camera_model_19, false);
        _S2274 = float((F32_sign((raydir_10.z)))) / length_1(raydir_10);
        break;
    }
    return _S2274;
}

inline __device__ float depth_normal_loss_none(float2  pix_center_11, float4  intrins_18, FixedArray<float, 1>  dist_coeffs_22, int camera_model_20, bool is_ray_depth_19, float4  depths_2, float3  gt_normal_0)
{
    int _S2277;
    float3  * _S2278;
    float3  * _S2279;
    float3  * _S2280;
    float3  * _S2281;
    float3  _S2282;
    float _S2283;
    for(;;)
    {
        FixedArray<float3 , 5>  points_19;
        for(;;)
        {
            float2  _S2284 = float2 {intrins_18.z, intrins_18.w};
            float2  _S2285 = float2 {intrins_18.x, intrins_18.y};
            float2  uv_55 = (pix_center_11 + make_float2 (-1.0f, -0.0f) - _S2284) / _S2285;
            FixedArray<float, 1>  _S2286 = dist_coeffs_22;
            float2  uv_u_47;
            bool _S2287 = undistort_point_3(uv_55, &_S2286, int(12), &uv_u_47);
            if(!_S2287)
            {
                _S2277 = int(0);
                break;
            }
            float3  raydir_11 = unproject_raydir_0(uv_u_47, camera_model_20, is_ray_depth_19);
            points_19[int(0)] = make_float3 (depths_2.x) * raydir_11;
            float2  uv_56 = (pix_center_11 + make_float2 (1.0f, -0.0f) - _S2284) / _S2285;
            FixedArray<float, 1>  _S2288 = dist_coeffs_22;
            float2  uv_u_48;
            bool _S2289 = undistort_point_3(uv_56, &_S2288, int(12), &uv_u_48);
            if(!_S2289)
            {
                _S2277 = int(0);
                _S2279 = &points_19[int(0)];
                break;
            }
            float3  raydir_12 = unproject_raydir_0(uv_u_48, camera_model_20, is_ray_depth_19);
            points_19[int(1)] = make_float3 (depths_2.y) * raydir_12;
            float2  uv_57 = (pix_center_11 + make_float2 (0.0f, -1.0f) - _S2284) / _S2285;
            FixedArray<float, 1>  _S2290 = dist_coeffs_22;
            float2  uv_u_49;
            bool _S2291 = undistort_point_3(uv_57, &_S2290, int(12), &uv_u_49);
            if(!_S2291)
            {
                _S2277 = int(0);
                _S2278 = &points_19[int(1)];
                _S2279 = &points_19[int(0)];
                break;
            }
            float3  raydir_13 = unproject_raydir_0(uv_u_49, camera_model_20, is_ray_depth_19);
            points_19[int(2)] = make_float3 (depths_2.z) * raydir_13;
            float2  uv_58 = (pix_center_11 + make_float2 (0.0f, 1.0f) - _S2284) / _S2285;
            FixedArray<float, 1>  _S2292 = dist_coeffs_22;
            float2  uv_u_50;
            bool _S2293 = undistort_point_3(uv_58, &_S2292, int(12), &uv_u_50);
            if(!_S2293)
            {
                _S2277 = int(0);
                _S2278 = &points_19[int(1)];
                _S2279 = &points_19[int(0)];
                _S2281 = &points_19[int(2)];
                break;
            }
            float3  raydir_14 = unproject_raydir_0(uv_u_50, camera_model_20, is_ray_depth_19);
            points_19[int(3)] = make_float3 (depths_2.w) * raydir_14;
            float2  uv_59 = (pix_center_11 - _S2284) / _S2285;
            FixedArray<float, 1>  _S2294 = dist_coeffs_22;
            float2  uv_u_51;
            bool _S2295 = undistort_point_3(uv_59, &_S2294, int(12), &uv_u_51);
            if(!_S2295)
            {
                _S2277 = int(0);
                _S2278 = &points_19[int(1)];
                _S2279 = &points_19[int(0)];
                _S2280 = &points_19[int(3)];
                _S2281 = &points_19[int(2)];
                break;
            }
            float3  raydir_15 = unproject_raydir_0(uv_u_51, camera_model_20, is_ray_depth_19);
            _S2277 = int(1);
            _S2278 = &points_19[int(1)];
            _S2279 = &points_19[int(0)];
            _S2280 = &points_19[int(3)];
            _S2281 = &points_19[int(2)];
            _S2282 = raydir_15;
            break;
        }
        if(_S2277 != int(1))
        {
            _S2283 = 0.0f;
            break;
        }
        float3  normal_16 = cross_0(*_S2278 - *_S2279, - (*_S2280 - *_S2281));
        float3  normal_17;
        if((dot_1(normal_16, normal_16)) != 0.0f)
        {
            normal_17 = normalize_0(normal_16);
        }
        else
        {
            normal_17 = normal_16;
        }
        float3  _S2296;
        if((dot_1(gt_normal_0, gt_normal_0)) != 0.0f)
        {
            _S2296 = normalize_0(gt_normal_0);
        }
        else
        {
            _S2296 = gt_normal_0;
        }
        _S2283 = (1.0f - dot_1(normal_17, _S2296) + 0.00100000004749745f) / ((F32_max((dot_1(normal_17, - normalize_0(_S2282))), (0.0f))) + 0.00100000004749745f);
        break;
    }
    return _S2283;
}

inline __device__ void depth_normal_loss_vjp_none(float2  pix_center_12, float4  intrins_19, FixedArray<float, 1>  dist_coeffs_23, int camera_model_21, bool is_ray_depth_20, float4  depths_3, float3  gt_normal_1, float v_loss_0, float4  * v_depths_1, float3  * v_gt_normal_0)
{
    float4  _S2297 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_depths_1;
    (&dp_depths_1)->primal_0 = depths_3;
    (&dp_depths_1)->differential_0 = _S2297;
    float3  _S2298 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_gt_normal_0;
    (&dp_gt_normal_0)->primal_0 = gt_normal_1;
    (&dp_gt_normal_0)->differential_0 = _S2298;
    FixedArray<float, 1>  _S2299 = dist_coeffs_23;
    _S1655(pix_center_12, intrins_19, &_S2299, camera_model_21, is_ray_depth_20, &dp_depths_1, &dp_gt_normal_0, v_loss_0);
    *v_depths_1 = dp_depths_1.differential_0;
    *v_gt_normal_0 = dp_gt_normal_0.differential_0;
    return;
}

inline __device__ float3  generate_ray_d2n_opencv(float2  pix_pos_7, float4  intrins_20, FixedArray<float, 4>  dist_coeffs_24, int camera_model_22, bool is_ray_depth_21)
{
    float3  _S2300;
    for(;;)
    {
        float2  uv_60 = (pix_pos_7 - float2 {intrins_20.z, intrins_20.w}) / float2 {intrins_20.x, intrins_20.y};
        FixedArray<float, 4>  _S2301 = dist_coeffs_24;
        float2  uv_u_52;
        bool _S2302 = undistort_point_2(uv_60, &_S2301, int(12), &uv_u_52);
        if(!_S2302)
        {
            int3  _S2303 = make_int3 (int(0));
            float3  _S2304 = make_float3 ((float)_S2303.x, (float)_S2303.y, (float)_S2303.z);
            _S2300 = _S2304;
            break;
        }
        _S2300 = unproject_raydir_0(uv_u_52, camera_model_22, is_ray_depth_21);
        break;
    }
    return _S2300;
}

inline __device__ float3  depth_to_point_opencv(float2  pix_pos_8, float4  intrins_21, FixedArray<float, 4>  dist_coeffs_25, int camera_model_23, bool is_ray_depth_22, float depth_4)
{
    float3  _S2305;
    for(;;)
    {
        float2  uv_61 = (pix_pos_8 - float2 {intrins_21.z, intrins_21.w}) / float2 {intrins_21.x, intrins_21.y};
        FixedArray<float, 4>  _S2306 = dist_coeffs_25;
        float2  uv_u_53;
        bool _S2307 = undistort_point_2(uv_61, &_S2306, int(12), &uv_u_53);
        if(!_S2307)
        {
            _S2305 = make_float3 (0.0f);
            break;
        }
        _S2305 = make_float3 (depth_4) * unproject_raydir_0(uv_u_53, camera_model_23, is_ray_depth_22);
        break;
    }
    return _S2305;
}

inline __device__ float depth_to_point_vjp_opencv(float2  pix_pos_9, float4  intrins_22, FixedArray<float, 4>  dist_coeffs_26, int camera_model_24, bool is_ray_depth_23, float depth_5, float3  v_point_1)
{
    DiffPair_float_0 dp_depth_1;
    (&dp_depth_1)->primal_0 = depth_5;
    (&dp_depth_1)->differential_0 = 0.0f;
    FixedArray<float, 4>  _S2308 = dist_coeffs_26;
    _S1476(pix_pos_9, intrins_22, &_S2308, camera_model_24, is_ray_depth_23, &dp_depth_1, v_point_1);
    return dp_depth_1.differential_0;
}

inline __device__ float3  depth_to_normal_opencv(float2  pix_center_13, float4  intrins_23, FixedArray<float, 4>  dist_coeffs_27, int camera_model_25, bool is_ray_depth_24, float4  depths_4)
{
    float3  normal_18;
    int _S2309;
    float3  * _S2310;
    float3  * _S2311;
    float3  * _S2312;
    float3  * _S2313;
    for(;;)
    {
        bool _S2314;
        if((depths_4.x) == 0.0f)
        {
            _S2314 = true;
        }
        else
        {
            _S2314 = (depths_4.y) == 0.0f;
        }
        if(_S2314)
        {
            _S2314 = true;
        }
        else
        {
            _S2314 = (depths_4.z) == 0.0f;
        }
        if(_S2314)
        {
            _S2314 = true;
        }
        else
        {
            _S2314 = (depths_4.w) == 0.0f;
        }
        if(_S2314)
        {
            normal_18 = make_float3 (0.0f);
            break;
        }
        FixedArray<float3 , 4>  points_20;
        for(;;)
        {
            float2  _S2315 = float2 {intrins_23.z, intrins_23.w};
            float2  _S2316 = float2 {intrins_23.x, intrins_23.y};
            float2  uv_62 = (pix_center_13 + make_float2 (-1.0f, -0.0f) - _S2315) / _S2316;
            FixedArray<float, 4>  _S2317 = dist_coeffs_27;
            float2  uv_u_54;
            bool _S2318 = undistort_point_2(uv_62, &_S2317, int(12), &uv_u_54);
            if(!_S2318)
            {
                float3  _S2319 = make_float3 (0.0f);
                _S2309 = int(0);
                normal_18 = _S2319;
                break;
            }
            points_20[int(0)] = make_float3 (depths_4.x) * unproject_raydir_0(uv_u_54, camera_model_25, is_ray_depth_24);
            for(;;)
            {
                float2  uv_63 = (pix_center_13 + make_float2 (1.0f, -0.0f) - _S2315) / _S2316;
                FixedArray<float, 4>  _S2320 = dist_coeffs_27;
                float2  uv_u_55;
                bool _S2321 = undistort_point_2(uv_63, &_S2320, int(12), &uv_u_55);
                if(!_S2321)
                {
                    float3  _S2322 = make_float3 (0.0f);
                    _S2309 = int(0);
                    normal_18 = _S2322;
                    break;
                }
                points_20[int(1)] = make_float3 (depths_4.y) * unproject_raydir_0(uv_u_55, camera_model_25, is_ray_depth_24);
                _S2309 = int(2);
                _S2310 = &points_20[int(1)];
                break;
            }
            if(_S2309 != int(2))
            {
                _S2311 = &points_20[int(0)];
                break;
            }
            float2  uv_64 = (pix_center_13 + make_float2 (0.0f, -1.0f) - _S2315) / _S2316;
            FixedArray<float, 4>  _S2323 = dist_coeffs_27;
            float2  uv_u_56;
            bool _S2324 = undistort_point_2(uv_64, &_S2323, int(12), &uv_u_56);
            if(!_S2324)
            {
                float3  _S2325 = make_float3 (0.0f);
                _S2309 = int(0);
                _S2311 = &points_20[int(0)];
                normal_18 = _S2325;
                break;
            }
            points_20[int(2)] = make_float3 (depths_4.z) * unproject_raydir_0(uv_u_56, camera_model_25, is_ray_depth_24);
            for(;;)
            {
                float2  uv_65 = (pix_center_13 + make_float2 (0.0f, 1.0f) - _S2315) / _S2316;
                FixedArray<float, 4>  _S2326 = dist_coeffs_27;
                float2  uv_u_57;
                bool _S2327 = undistort_point_2(uv_65, &_S2326, int(12), &uv_u_57);
                if(!_S2327)
                {
                    float3  _S2328 = make_float3 (0.0f);
                    _S2309 = int(0);
                    normal_18 = _S2328;
                    break;
                }
                points_20[int(3)] = make_float3 (depths_4.w) * unproject_raydir_0(uv_u_57, camera_model_25, is_ray_depth_24);
                _S2309 = int(2);
                _S2311 = &points_20[int(3)];
                break;
            }
            if(_S2309 != int(2))
            {
                float3  * _S2329 = _S2311;
                _S2311 = &points_20[int(0)];
                _S2312 = _S2329;
                _S2313 = &points_20[int(2)];
                break;
            }
            float3  * _S2330 = _S2311;
            _S2309 = int(1);
            _S2311 = &points_20[int(0)];
            _S2312 = _S2330;
            _S2313 = &points_20[int(2)];
            break;
        }
        if(_S2309 != int(1))
        {
            break;
        }
        float3  normal_19 = cross_0(*_S2310 - *_S2311, - (*_S2312 - *_S2313));
        if((dot_1(normal_19, normal_19)) != 0.0f)
        {
            normal_18 = normal_19 / make_float3 (length_1(normal_19));
        }
        else
        {
            normal_18 = normal_19;
        }
        break;
    }
    return normal_18;
}

inline __device__ void depth_to_normal_vjp_opencv(float2  pix_center_14, float4  intrins_24, FixedArray<float, 4>  dist_coeffs_28, int camera_model_26, bool is_ray_depth_25, float4  depths_5, float3  v_normal_2, float4  * v_depths_2)
{
    float4  _S2331 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_depths_2;
    (&dp_depths_2)->primal_0 = depths_5;
    (&dp_depths_2)->differential_0 = _S2331;
    FixedArray<float, 4>  _S2332 = dist_coeffs_28;
    _S1449(pix_center_14, intrins_24, &_S2332, camera_model_26, is_ray_depth_25, &dp_depths_2, v_normal_2);
    *v_depths_2 = dp_depths_2.differential_0;
    return;
}

inline __device__ float ray_depth_to_linear_depth_factor_opencv(float2  pix_center_15, float4  intrins_25, FixedArray<float, 4>  dist_coeffs_29, int camera_model_27)
{
    float _S2333;
    for(;;)
    {
        float2  uv_66 = (pix_center_15 - float2 {intrins_25.z, intrins_25.w}) / float2 {intrins_25.x, intrins_25.y};
        FixedArray<float, 4>  _S2334 = dist_coeffs_29;
        float2  uv_u_58;
        bool _S2335 = undistort_point_2(uv_66, &_S2334, int(12), &uv_u_58);
        if(!_S2335)
        {
            _S2333 = 0.0f;
            break;
        }
        float3  raydir_16 = unproject_raydir_0(uv_u_58, camera_model_27, false);
        _S2333 = float((F32_sign((raydir_16.z)))) / length_1(raydir_16);
        break;
    }
    return _S2333;
}

inline __device__ float depth_normal_loss_opencv(float2  pix_center_16, float4  intrins_26, FixedArray<float, 4>  dist_coeffs_30, int camera_model_28, bool is_ray_depth_26, float4  depths_6, float3  gt_normal_2)
{
    int _S2336;
    float3  * _S2337;
    float3  * _S2338;
    float3  * _S2339;
    float3  * _S2340;
    float3  _S2341;
    float _S2342;
    for(;;)
    {
        FixedArray<float3 , 5>  points_21;
        for(;;)
        {
            float2  _S2343 = float2 {intrins_26.z, intrins_26.w};
            float2  _S2344 = float2 {intrins_26.x, intrins_26.y};
            float2  uv_67 = (pix_center_16 + make_float2 (-1.0f, -0.0f) - _S2343) / _S2344;
            FixedArray<float, 4>  _S2345 = dist_coeffs_30;
            float2  uv_u_59;
            bool _S2346 = undistort_point_2(uv_67, &_S2345, int(12), &uv_u_59);
            if(!_S2346)
            {
                _S2336 = int(0);
                break;
            }
            float3  raydir_17 = unproject_raydir_0(uv_u_59, camera_model_28, is_ray_depth_26);
            points_21[int(0)] = make_float3 (depths_6.x) * raydir_17;
            float2  uv_68 = (pix_center_16 + make_float2 (1.0f, -0.0f) - _S2343) / _S2344;
            FixedArray<float, 4>  _S2347 = dist_coeffs_30;
            float2  uv_u_60;
            bool _S2348 = undistort_point_2(uv_68, &_S2347, int(12), &uv_u_60);
            if(!_S2348)
            {
                _S2336 = int(0);
                _S2338 = &points_21[int(0)];
                break;
            }
            float3  raydir_18 = unproject_raydir_0(uv_u_60, camera_model_28, is_ray_depth_26);
            points_21[int(1)] = make_float3 (depths_6.y) * raydir_18;
            float2  uv_69 = (pix_center_16 + make_float2 (0.0f, -1.0f) - _S2343) / _S2344;
            FixedArray<float, 4>  _S2349 = dist_coeffs_30;
            float2  uv_u_61;
            bool _S2350 = undistort_point_2(uv_69, &_S2349, int(12), &uv_u_61);
            if(!_S2350)
            {
                _S2336 = int(0);
                _S2337 = &points_21[int(1)];
                _S2338 = &points_21[int(0)];
                break;
            }
            float3  raydir_19 = unproject_raydir_0(uv_u_61, camera_model_28, is_ray_depth_26);
            points_21[int(2)] = make_float3 (depths_6.z) * raydir_19;
            float2  uv_70 = (pix_center_16 + make_float2 (0.0f, 1.0f) - _S2343) / _S2344;
            FixedArray<float, 4>  _S2351 = dist_coeffs_30;
            float2  uv_u_62;
            bool _S2352 = undistort_point_2(uv_70, &_S2351, int(12), &uv_u_62);
            if(!_S2352)
            {
                _S2336 = int(0);
                _S2337 = &points_21[int(1)];
                _S2338 = &points_21[int(0)];
                _S2340 = &points_21[int(2)];
                break;
            }
            float3  raydir_20 = unproject_raydir_0(uv_u_62, camera_model_28, is_ray_depth_26);
            points_21[int(3)] = make_float3 (depths_6.w) * raydir_20;
            float2  uv_71 = (pix_center_16 - _S2343) / _S2344;
            FixedArray<float, 4>  _S2353 = dist_coeffs_30;
            float2  uv_u_63;
            bool _S2354 = undistort_point_2(uv_71, &_S2353, int(12), &uv_u_63);
            if(!_S2354)
            {
                _S2336 = int(0);
                _S2337 = &points_21[int(1)];
                _S2338 = &points_21[int(0)];
                _S2339 = &points_21[int(3)];
                _S2340 = &points_21[int(2)];
                break;
            }
            float3  raydir_21 = unproject_raydir_0(uv_u_63, camera_model_28, is_ray_depth_26);
            _S2336 = int(1);
            _S2337 = &points_21[int(1)];
            _S2338 = &points_21[int(0)];
            _S2339 = &points_21[int(3)];
            _S2340 = &points_21[int(2)];
            _S2341 = raydir_21;
            break;
        }
        if(_S2336 != int(1))
        {
            _S2342 = 0.0f;
            break;
        }
        float3  normal_20 = cross_0(*_S2337 - *_S2338, - (*_S2339 - *_S2340));
        float3  normal_21;
        if((dot_1(normal_20, normal_20)) != 0.0f)
        {
            normal_21 = normalize_0(normal_20);
        }
        else
        {
            normal_21 = normal_20;
        }
        float3  _S2355;
        if((dot_1(gt_normal_2, gt_normal_2)) != 0.0f)
        {
            _S2355 = normalize_0(gt_normal_2);
        }
        else
        {
            _S2355 = gt_normal_2;
        }
        _S2342 = (1.0f - dot_1(normal_21, _S2355) + 0.00100000004749745f) / ((F32_max((dot_1(normal_21, - normalize_0(_S2341))), (0.0f))) + 0.00100000004749745f);
        break;
    }
    return _S2342;
}

inline __device__ void depth_normal_loss_vjp_opencv(float2  pix_center_17, float4  intrins_27, FixedArray<float, 4>  dist_coeffs_31, int camera_model_29, bool is_ray_depth_27, float4  depths_7, float3  gt_normal_3, float v_loss_1, float4  * v_depths_3, float3  * v_gt_normal_1)
{
    float4  _S2356 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_depths_3;
    (&dp_depths_3)->primal_0 = depths_7;
    (&dp_depths_3)->differential_0 = _S2356;
    float3  _S2357 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_gt_normal_1;
    (&dp_gt_normal_1)->primal_0 = gt_normal_3;
    (&dp_gt_normal_1)->differential_0 = _S2357;
    FixedArray<float, 4>  _S2358 = dist_coeffs_31;
    _S1288(pix_center_17, intrins_27, &_S2358, camera_model_29, is_ray_depth_27, &dp_depths_3, &dp_gt_normal_1, v_loss_1);
    *v_depths_3 = dp_depths_3.differential_0;
    *v_gt_normal_1 = dp_gt_normal_1.differential_0;
    return;
}

inline __device__ float3  generate_ray_d2n_prism(float2  pix_pos_10, float4  intrins_28, FixedArray<float, 8>  dist_coeffs_32, int camera_model_30, bool is_ray_depth_28)
{
    float3  _S2359;
    for(;;)
    {
        float2  uv_72 = (pix_pos_10 - float2 {intrins_28.z, intrins_28.w}) / float2 {intrins_28.x, intrins_28.y};
        FixedArray<float, 8>  _S2360 = dist_coeffs_32;
        float2  uv_u_64;
        bool _S2361 = undistort_point_1(uv_72, &_S2360, int(12), &uv_u_64);
        if(!_S2361)
        {
            int3  _S2362 = make_int3 (int(0));
            float3  _S2363 = make_float3 ((float)_S2362.x, (float)_S2362.y, (float)_S2362.z);
            _S2359 = _S2363;
            break;
        }
        _S2359 = unproject_raydir_0(uv_u_64, camera_model_30, is_ray_depth_28);
        break;
    }
    return _S2359;
}

inline __device__ float3  depth_to_point_prism(float2  pix_pos_11, float4  intrins_29, FixedArray<float, 8>  dist_coeffs_33, int camera_model_31, bool is_ray_depth_29, float depth_6)
{
    float3  _S2364;
    for(;;)
    {
        float2  uv_73 = (pix_pos_11 - float2 {intrins_29.z, intrins_29.w}) / float2 {intrins_29.x, intrins_29.y};
        FixedArray<float, 8>  _S2365 = dist_coeffs_33;
        float2  uv_u_65;
        bool _S2366 = undistort_point_1(uv_73, &_S2365, int(12), &uv_u_65);
        if(!_S2366)
        {
            _S2364 = make_float3 (0.0f);
            break;
        }
        _S2364 = make_float3 (depth_6) * unproject_raydir_0(uv_u_65, camera_model_31, is_ray_depth_29);
        break;
    }
    return _S2364;
}

inline __device__ float depth_to_point_vjp_prism(float2  pix_pos_12, float4  intrins_30, FixedArray<float, 8>  dist_coeffs_34, int camera_model_32, bool is_ray_depth_30, float depth_7, float3  v_point_2)
{
    DiffPair_float_0 dp_depth_2;
    (&dp_depth_2)->primal_0 = depth_7;
    (&dp_depth_2)->differential_0 = 0.0f;
    FixedArray<float, 8>  _S2367 = dist_coeffs_34;
    _S1078(pix_pos_12, intrins_30, &_S2367, camera_model_32, is_ray_depth_30, &dp_depth_2, v_point_2);
    return dp_depth_2.differential_0;
}

inline __device__ float3  depth_to_normal_prism(float2  pix_center_18, float4  intrins_31, FixedArray<float, 8>  dist_coeffs_35, int camera_model_33, bool is_ray_depth_31, float4  depths_8)
{
    float3  normal_22;
    int _S2368;
    float3  * _S2369;
    float3  * _S2370;
    float3  * _S2371;
    float3  * _S2372;
    for(;;)
    {
        bool _S2373;
        if((depths_8.x) == 0.0f)
        {
            _S2373 = true;
        }
        else
        {
            _S2373 = (depths_8.y) == 0.0f;
        }
        if(_S2373)
        {
            _S2373 = true;
        }
        else
        {
            _S2373 = (depths_8.z) == 0.0f;
        }
        if(_S2373)
        {
            _S2373 = true;
        }
        else
        {
            _S2373 = (depths_8.w) == 0.0f;
        }
        if(_S2373)
        {
            normal_22 = make_float3 (0.0f);
            break;
        }
        FixedArray<float3 , 4>  points_22;
        for(;;)
        {
            float2  _S2374 = float2 {intrins_31.z, intrins_31.w};
            float2  _S2375 = float2 {intrins_31.x, intrins_31.y};
            float2  uv_74 = (pix_center_18 + make_float2 (-1.0f, -0.0f) - _S2374) / _S2375;
            FixedArray<float, 8>  _S2376 = dist_coeffs_35;
            float2  uv_u_66;
            bool _S2377 = undistort_point_1(uv_74, &_S2376, int(12), &uv_u_66);
            if(!_S2377)
            {
                float3  _S2378 = make_float3 (0.0f);
                _S2368 = int(0);
                normal_22 = _S2378;
                break;
            }
            points_22[int(0)] = make_float3 (depths_8.x) * unproject_raydir_0(uv_u_66, camera_model_33, is_ray_depth_31);
            for(;;)
            {
                float2  uv_75 = (pix_center_18 + make_float2 (1.0f, -0.0f) - _S2374) / _S2375;
                FixedArray<float, 8>  _S2379 = dist_coeffs_35;
                float2  uv_u_67;
                bool _S2380 = undistort_point_1(uv_75, &_S2379, int(12), &uv_u_67);
                if(!_S2380)
                {
                    float3  _S2381 = make_float3 (0.0f);
                    _S2368 = int(0);
                    normal_22 = _S2381;
                    break;
                }
                points_22[int(1)] = make_float3 (depths_8.y) * unproject_raydir_0(uv_u_67, camera_model_33, is_ray_depth_31);
                _S2368 = int(2);
                _S2369 = &points_22[int(1)];
                break;
            }
            if(_S2368 != int(2))
            {
                _S2370 = &points_22[int(0)];
                break;
            }
            float2  uv_76 = (pix_center_18 + make_float2 (0.0f, -1.0f) - _S2374) / _S2375;
            FixedArray<float, 8>  _S2382 = dist_coeffs_35;
            float2  uv_u_68;
            bool _S2383 = undistort_point_1(uv_76, &_S2382, int(12), &uv_u_68);
            if(!_S2383)
            {
                float3  _S2384 = make_float3 (0.0f);
                _S2368 = int(0);
                _S2370 = &points_22[int(0)];
                normal_22 = _S2384;
                break;
            }
            points_22[int(2)] = make_float3 (depths_8.z) * unproject_raydir_0(uv_u_68, camera_model_33, is_ray_depth_31);
            for(;;)
            {
                float2  uv_77 = (pix_center_18 + make_float2 (0.0f, 1.0f) - _S2374) / _S2375;
                FixedArray<float, 8>  _S2385 = dist_coeffs_35;
                float2  uv_u_69;
                bool _S2386 = undistort_point_1(uv_77, &_S2385, int(12), &uv_u_69);
                if(!_S2386)
                {
                    float3  _S2387 = make_float3 (0.0f);
                    _S2368 = int(0);
                    normal_22 = _S2387;
                    break;
                }
                points_22[int(3)] = make_float3 (depths_8.w) * unproject_raydir_0(uv_u_69, camera_model_33, is_ray_depth_31);
                _S2368 = int(2);
                _S2370 = &points_22[int(3)];
                break;
            }
            if(_S2368 != int(2))
            {
                float3  * _S2388 = _S2370;
                _S2370 = &points_22[int(0)];
                _S2371 = _S2388;
                _S2372 = &points_22[int(2)];
                break;
            }
            float3  * _S2389 = _S2370;
            _S2368 = int(1);
            _S2370 = &points_22[int(0)];
            _S2371 = _S2389;
            _S2372 = &points_22[int(2)];
            break;
        }
        if(_S2368 != int(1))
        {
            break;
        }
        float3  normal_23 = cross_0(*_S2369 - *_S2370, - (*_S2371 - *_S2372));
        if((dot_1(normal_23, normal_23)) != 0.0f)
        {
            normal_22 = normal_23 / make_float3 (length_1(normal_23));
        }
        else
        {
            normal_22 = normal_23;
        }
        break;
    }
    return normal_22;
}

inline __device__ void depth_to_normal_vjp_prism(float2  pix_center_19, float4  intrins_32, FixedArray<float, 8>  dist_coeffs_36, int camera_model_34, bool is_ray_depth_32, float4  depths_9, float3  v_normal_3, float4  * v_depths_4)
{
    float4  _S2390 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_depths_4;
    (&dp_depths_4)->primal_0 = depths_9;
    (&dp_depths_4)->differential_0 = _S2390;
    FixedArray<float, 8>  _S2391 = dist_coeffs_36;
    _S1051(pix_center_19, intrins_32, &_S2391, camera_model_34, is_ray_depth_32, &dp_depths_4, v_normal_3);
    *v_depths_4 = dp_depths_4.differential_0;
    return;
}

inline __device__ float ray_depth_to_linear_depth_factor_prism(float2  pix_center_20, float4  intrins_33, FixedArray<float, 8>  dist_coeffs_37, int camera_model_35)
{
    float _S2392;
    for(;;)
    {
        float2  uv_78 = (pix_center_20 - float2 {intrins_33.z, intrins_33.w}) / float2 {intrins_33.x, intrins_33.y};
        FixedArray<float, 8>  _S2393 = dist_coeffs_37;
        float2  uv_u_70;
        bool _S2394 = undistort_point_1(uv_78, &_S2393, int(12), &uv_u_70);
        if(!_S2394)
        {
            _S2392 = 0.0f;
            break;
        }
        float3  raydir_22 = unproject_raydir_0(uv_u_70, camera_model_35, false);
        _S2392 = float((F32_sign((raydir_22.z)))) / length_1(raydir_22);
        break;
    }
    return _S2392;
}

inline __device__ float depth_normal_loss_prism(float2  pix_center_21, float4  intrins_34, FixedArray<float, 8>  dist_coeffs_38, int camera_model_36, bool is_ray_depth_33, float4  depths_10, float3  gt_normal_4)
{
    int _S2395;
    float3  * _S2396;
    float3  * _S2397;
    float3  * _S2398;
    float3  * _S2399;
    float3  _S2400;
    float _S2401;
    for(;;)
    {
        FixedArray<float3 , 5>  points_23;
        for(;;)
        {
            float2  _S2402 = float2 {intrins_34.z, intrins_34.w};
            float2  _S2403 = float2 {intrins_34.x, intrins_34.y};
            float2  uv_79 = (pix_center_21 + make_float2 (-1.0f, -0.0f) - _S2402) / _S2403;
            FixedArray<float, 8>  _S2404 = dist_coeffs_38;
            float2  uv_u_71;
            bool _S2405 = undistort_point_1(uv_79, &_S2404, int(12), &uv_u_71);
            if(!_S2405)
            {
                _S2395 = int(0);
                break;
            }
            float3  raydir_23 = unproject_raydir_0(uv_u_71, camera_model_36, is_ray_depth_33);
            points_23[int(0)] = make_float3 (depths_10.x) * raydir_23;
            float2  uv_80 = (pix_center_21 + make_float2 (1.0f, -0.0f) - _S2402) / _S2403;
            FixedArray<float, 8>  _S2406 = dist_coeffs_38;
            float2  uv_u_72;
            bool _S2407 = undistort_point_1(uv_80, &_S2406, int(12), &uv_u_72);
            if(!_S2407)
            {
                _S2395 = int(0);
                _S2397 = &points_23[int(0)];
                break;
            }
            float3  raydir_24 = unproject_raydir_0(uv_u_72, camera_model_36, is_ray_depth_33);
            points_23[int(1)] = make_float3 (depths_10.y) * raydir_24;
            float2  uv_81 = (pix_center_21 + make_float2 (0.0f, -1.0f) - _S2402) / _S2403;
            FixedArray<float, 8>  _S2408 = dist_coeffs_38;
            float2  uv_u_73;
            bool _S2409 = undistort_point_1(uv_81, &_S2408, int(12), &uv_u_73);
            if(!_S2409)
            {
                _S2395 = int(0);
                _S2396 = &points_23[int(1)];
                _S2397 = &points_23[int(0)];
                break;
            }
            float3  raydir_25 = unproject_raydir_0(uv_u_73, camera_model_36, is_ray_depth_33);
            points_23[int(2)] = make_float3 (depths_10.z) * raydir_25;
            float2  uv_82 = (pix_center_21 + make_float2 (0.0f, 1.0f) - _S2402) / _S2403;
            FixedArray<float, 8>  _S2410 = dist_coeffs_38;
            float2  uv_u_74;
            bool _S2411 = undistort_point_1(uv_82, &_S2410, int(12), &uv_u_74);
            if(!_S2411)
            {
                _S2395 = int(0);
                _S2396 = &points_23[int(1)];
                _S2397 = &points_23[int(0)];
                _S2399 = &points_23[int(2)];
                break;
            }
            float3  raydir_26 = unproject_raydir_0(uv_u_74, camera_model_36, is_ray_depth_33);
            points_23[int(3)] = make_float3 (depths_10.w) * raydir_26;
            float2  uv_83 = (pix_center_21 - _S2402) / _S2403;
            FixedArray<float, 8>  _S2412 = dist_coeffs_38;
            float2  uv_u_75;
            bool _S2413 = undistort_point_1(uv_83, &_S2412, int(12), &uv_u_75);
            if(!_S2413)
            {
                _S2395 = int(0);
                _S2396 = &points_23[int(1)];
                _S2397 = &points_23[int(0)];
                _S2398 = &points_23[int(3)];
                _S2399 = &points_23[int(2)];
                break;
            }
            float3  raydir_27 = unproject_raydir_0(uv_u_75, camera_model_36, is_ray_depth_33);
            _S2395 = int(1);
            _S2396 = &points_23[int(1)];
            _S2397 = &points_23[int(0)];
            _S2398 = &points_23[int(3)];
            _S2399 = &points_23[int(2)];
            _S2400 = raydir_27;
            break;
        }
        if(_S2395 != int(1))
        {
            _S2401 = 0.0f;
            break;
        }
        float3  normal_24 = cross_0(*_S2396 - *_S2397, - (*_S2398 - *_S2399));
        float3  normal_25;
        if((dot_1(normal_24, normal_24)) != 0.0f)
        {
            normal_25 = normalize_0(normal_24);
        }
        else
        {
            normal_25 = normal_24;
        }
        float3  _S2414;
        if((dot_1(gt_normal_4, gt_normal_4)) != 0.0f)
        {
            _S2414 = normalize_0(gt_normal_4);
        }
        else
        {
            _S2414 = gt_normal_4;
        }
        _S2401 = (1.0f - dot_1(normal_25, _S2414) + 0.00100000004749745f) / ((F32_max((dot_1(normal_25, - normalize_0(_S2400))), (0.0f))) + 0.00100000004749745f);
        break;
    }
    return _S2401;
}

inline __device__ void depth_normal_loss_vjp_prism(float2  pix_center_22, float4  intrins_35, FixedArray<float, 8>  dist_coeffs_39, int camera_model_37, bool is_ray_depth_34, float4  depths_11, float3  gt_normal_5, float v_loss_2, float4  * v_depths_5, float3  * v_gt_normal_2)
{
    float4  _S2415 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_depths_5;
    (&dp_depths_5)->primal_0 = depths_11;
    (&dp_depths_5)->differential_0 = _S2415;
    float3  _S2416 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_gt_normal_2;
    (&dp_gt_normal_2)->primal_0 = gt_normal_5;
    (&dp_gt_normal_2)->differential_0 = _S2416;
    FixedArray<float, 8>  _S2417 = dist_coeffs_39;
    _S890(pix_center_22, intrins_35, &_S2417, camera_model_37, is_ray_depth_34, &dp_depths_5, &dp_gt_normal_2, v_loss_2);
    *v_depths_5 = dp_depths_5.differential_0;
    *v_gt_normal_2 = dp_gt_normal_2.differential_0;
    return;
}

inline __device__ float3  generate_ray_d2n_polar(float2  pix_pos_13, float4  intrins_36, FixedArray<float, 58>  dist_coeffs_40, int camera_model_38, bool is_ray_depth_35)
{
    float3  _S2418;
    for(;;)
    {
        float2  uv_84 = (pix_pos_13 - float2 {intrins_36.z, intrins_36.w}) / float2 {intrins_36.x, intrins_36.y};
        FixedArray<float, 58>  _S2419 = dist_coeffs_40;
        float2  uv_u_76;
        bool _S2420 = undistort_point_0(uv_84, &_S2419, int(12), &uv_u_76);
        if(!_S2420)
        {
            int3  _S2421 = make_int3 (int(0));
            float3  _S2422 = make_float3 ((float)_S2421.x, (float)_S2421.y, (float)_S2421.z);
            _S2418 = _S2422;
            break;
        }
        _S2418 = unproject_raydir_0(uv_u_76, camera_model_38, is_ray_depth_35);
        break;
    }
    return _S2418;
}

inline __device__ float3  depth_to_point_polar(float2  pix_pos_14, float4  intrins_37, FixedArray<float, 58>  dist_coeffs_41, int camera_model_39, bool is_ray_depth_36, float depth_8)
{
    float3  _S2423;
    for(;;)
    {
        float2  uv_85 = (pix_pos_14 - float2 {intrins_37.z, intrins_37.w}) / float2 {intrins_37.x, intrins_37.y};
        FixedArray<float, 58>  _S2424 = dist_coeffs_41;
        float2  uv_u_77;
        bool _S2425 = undistort_point_0(uv_85, &_S2424, int(12), &uv_u_77);
        if(!_S2425)
        {
            _S2423 = make_float3 (0.0f);
            break;
        }
        _S2423 = make_float3 (depth_8) * unproject_raydir_0(uv_u_77, camera_model_39, is_ray_depth_36);
        break;
    }
    return _S2423;
}

inline __device__ float depth_to_point_vjp_polar(float2  pix_pos_15, float4  intrins_38, FixedArray<float, 58>  dist_coeffs_42, int camera_model_40, bool is_ray_depth_37, float depth_9, float3  v_point_3)
{
    DiffPair_float_0 dp_depth_3;
    (&dp_depth_3)->primal_0 = depth_9;
    (&dp_depth_3)->differential_0 = 0.0f;
    FixedArray<float, 58>  _S2426 = dist_coeffs_42;
    _S678(pix_pos_15, intrins_38, &_S2426, camera_model_40, is_ray_depth_37, &dp_depth_3, v_point_3);
    return dp_depth_3.differential_0;
}

inline __device__ float3  depth_to_normal_polar(float2  pix_center_23, float4  intrins_39, FixedArray<float, 58>  dist_coeffs_43, int camera_model_41, bool is_ray_depth_38, float4  depths_12)
{
    float3  normal_26;
    int _S2427;
    float3  * _S2428;
    float3  * _S2429;
    float3  * _S2430;
    float3  * _S2431;
    for(;;)
    {
        bool _S2432;
        if((depths_12.x) == 0.0f)
        {
            _S2432 = true;
        }
        else
        {
            _S2432 = (depths_12.y) == 0.0f;
        }
        if(_S2432)
        {
            _S2432 = true;
        }
        else
        {
            _S2432 = (depths_12.z) == 0.0f;
        }
        if(_S2432)
        {
            _S2432 = true;
        }
        else
        {
            _S2432 = (depths_12.w) == 0.0f;
        }
        if(_S2432)
        {
            normal_26 = make_float3 (0.0f);
            break;
        }
        FixedArray<float3 , 4>  points_24;
        for(;;)
        {
            float2  _S2433 = float2 {intrins_39.z, intrins_39.w};
            float2  _S2434 = float2 {intrins_39.x, intrins_39.y};
            float2  uv_86 = (pix_center_23 + make_float2 (-1.0f, -0.0f) - _S2433) / _S2434;
            FixedArray<float, 58>  _S2435 = dist_coeffs_43;
            float2  uv_u_78;
            bool _S2436 = undistort_point_0(uv_86, &_S2435, int(12), &uv_u_78);
            if(!_S2436)
            {
                float3  _S2437 = make_float3 (0.0f);
                _S2427 = int(0);
                normal_26 = _S2437;
                break;
            }
            points_24[int(0)] = make_float3 (depths_12.x) * unproject_raydir_0(uv_u_78, camera_model_41, is_ray_depth_38);
            for(;;)
            {
                float2  uv_87 = (pix_center_23 + make_float2 (1.0f, -0.0f) - _S2433) / _S2434;
                FixedArray<float, 58>  _S2438 = dist_coeffs_43;
                float2  uv_u_79;
                bool _S2439 = undistort_point_0(uv_87, &_S2438, int(12), &uv_u_79);
                if(!_S2439)
                {
                    float3  _S2440 = make_float3 (0.0f);
                    _S2427 = int(0);
                    normal_26 = _S2440;
                    break;
                }
                points_24[int(1)] = make_float3 (depths_12.y) * unproject_raydir_0(uv_u_79, camera_model_41, is_ray_depth_38);
                _S2427 = int(2);
                _S2428 = &points_24[int(1)];
                break;
            }
            if(_S2427 != int(2))
            {
                _S2429 = &points_24[int(0)];
                break;
            }
            float2  uv_88 = (pix_center_23 + make_float2 (0.0f, -1.0f) - _S2433) / _S2434;
            FixedArray<float, 58>  _S2441 = dist_coeffs_43;
            float2  uv_u_80;
            bool _S2442 = undistort_point_0(uv_88, &_S2441, int(12), &uv_u_80);
            if(!_S2442)
            {
                float3  _S2443 = make_float3 (0.0f);
                _S2427 = int(0);
                _S2429 = &points_24[int(0)];
                normal_26 = _S2443;
                break;
            }
            points_24[int(2)] = make_float3 (depths_12.z) * unproject_raydir_0(uv_u_80, camera_model_41, is_ray_depth_38);
            for(;;)
            {
                float2  uv_89 = (pix_center_23 + make_float2 (0.0f, 1.0f) - _S2433) / _S2434;
                FixedArray<float, 58>  _S2444 = dist_coeffs_43;
                float2  uv_u_81;
                bool _S2445 = undistort_point_0(uv_89, &_S2444, int(12), &uv_u_81);
                if(!_S2445)
                {
                    float3  _S2446 = make_float3 (0.0f);
                    _S2427 = int(0);
                    normal_26 = _S2446;
                    break;
                }
                points_24[int(3)] = make_float3 (depths_12.w) * unproject_raydir_0(uv_u_81, camera_model_41, is_ray_depth_38);
                _S2427 = int(2);
                _S2429 = &points_24[int(3)];
                break;
            }
            if(_S2427 != int(2))
            {
                float3  * _S2447 = _S2429;
                _S2429 = &points_24[int(0)];
                _S2430 = _S2447;
                _S2431 = &points_24[int(2)];
                break;
            }
            float3  * _S2448 = _S2429;
            _S2427 = int(1);
            _S2429 = &points_24[int(0)];
            _S2430 = _S2448;
            _S2431 = &points_24[int(2)];
            break;
        }
        if(_S2427 != int(1))
        {
            break;
        }
        float3  normal_27 = cross_0(*_S2428 - *_S2429, - (*_S2430 - *_S2431));
        if((dot_1(normal_27, normal_27)) != 0.0f)
        {
            normal_26 = normal_27 / make_float3 (length_1(normal_27));
        }
        else
        {
            normal_26 = normal_27;
        }
        break;
    }
    return normal_26;
}

inline __device__ void depth_to_normal_vjp_polar(float2  pix_center_24, float4  intrins_40, FixedArray<float, 58>  dist_coeffs_44, int camera_model_42, bool is_ray_depth_39, float4  depths_13, float3  v_normal_4, float4  * v_depths_6)
{
    float4  _S2449 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_depths_6;
    (&dp_depths_6)->primal_0 = depths_13;
    (&dp_depths_6)->differential_0 = _S2449;
    FixedArray<float, 58>  _S2450 = dist_coeffs_44;
    _S651(pix_center_24, intrins_40, &_S2450, camera_model_42, is_ray_depth_39, &dp_depths_6, v_normal_4);
    *v_depths_6 = dp_depths_6.differential_0;
    return;
}

inline __device__ float ray_depth_to_linear_depth_factor_polar(float2  pix_center_25, float4  intrins_41, FixedArray<float, 58>  dist_coeffs_45, int camera_model_43)
{
    float _S2451;
    for(;;)
    {
        float2  uv_90 = (pix_center_25 - float2 {intrins_41.z, intrins_41.w}) / float2 {intrins_41.x, intrins_41.y};
        FixedArray<float, 58>  _S2452 = dist_coeffs_45;
        float2  uv_u_82;
        bool _S2453 = undistort_point_0(uv_90, &_S2452, int(12), &uv_u_82);
        if(!_S2453)
        {
            _S2451 = 0.0f;
            break;
        }
        float3  raydir_28 = unproject_raydir_0(uv_u_82, camera_model_43, false);
        _S2451 = float((F32_sign((raydir_28.z)))) / length_1(raydir_28);
        break;
    }
    return _S2451;
}

inline __device__ float depth_normal_loss_polar(float2  pix_center_26, float4  intrins_42, FixedArray<float, 58>  dist_coeffs_46, int camera_model_44, bool is_ray_depth_40, float4  depths_14, float3  gt_normal_6)
{
    int _S2454;
    float3  * _S2455;
    float3  * _S2456;
    float3  * _S2457;
    float3  * _S2458;
    float3  _S2459;
    float _S2460;
    for(;;)
    {
        FixedArray<float3 , 5>  points_25;
        for(;;)
        {
            float2  _S2461 = float2 {intrins_42.z, intrins_42.w};
            float2  _S2462 = float2 {intrins_42.x, intrins_42.y};
            float2  uv_91 = (pix_center_26 + make_float2 (-1.0f, -0.0f) - _S2461) / _S2462;
            FixedArray<float, 58>  _S2463 = dist_coeffs_46;
            float2  uv_u_83;
            bool _S2464 = undistort_point_0(uv_91, &_S2463, int(12), &uv_u_83);
            if(!_S2464)
            {
                _S2454 = int(0);
                break;
            }
            float3  raydir_29 = unproject_raydir_0(uv_u_83, camera_model_44, is_ray_depth_40);
            points_25[int(0)] = make_float3 (depths_14.x) * raydir_29;
            float2  uv_92 = (pix_center_26 + make_float2 (1.0f, -0.0f) - _S2461) / _S2462;
            FixedArray<float, 58>  _S2465 = dist_coeffs_46;
            float2  uv_u_84;
            bool _S2466 = undistort_point_0(uv_92, &_S2465, int(12), &uv_u_84);
            if(!_S2466)
            {
                _S2454 = int(0);
                _S2456 = &points_25[int(0)];
                break;
            }
            float3  raydir_30 = unproject_raydir_0(uv_u_84, camera_model_44, is_ray_depth_40);
            points_25[int(1)] = make_float3 (depths_14.y) * raydir_30;
            float2  uv_93 = (pix_center_26 + make_float2 (0.0f, -1.0f) - _S2461) / _S2462;
            FixedArray<float, 58>  _S2467 = dist_coeffs_46;
            float2  uv_u_85;
            bool _S2468 = undistort_point_0(uv_93, &_S2467, int(12), &uv_u_85);
            if(!_S2468)
            {
                _S2454 = int(0);
                _S2455 = &points_25[int(1)];
                _S2456 = &points_25[int(0)];
                break;
            }
            float3  raydir_31 = unproject_raydir_0(uv_u_85, camera_model_44, is_ray_depth_40);
            points_25[int(2)] = make_float3 (depths_14.z) * raydir_31;
            float2  uv_94 = (pix_center_26 + make_float2 (0.0f, 1.0f) - _S2461) / _S2462;
            FixedArray<float, 58>  _S2469 = dist_coeffs_46;
            float2  uv_u_86;
            bool _S2470 = undistort_point_0(uv_94, &_S2469, int(12), &uv_u_86);
            if(!_S2470)
            {
                _S2454 = int(0);
                _S2455 = &points_25[int(1)];
                _S2456 = &points_25[int(0)];
                _S2458 = &points_25[int(2)];
                break;
            }
            float3  raydir_32 = unproject_raydir_0(uv_u_86, camera_model_44, is_ray_depth_40);
            points_25[int(3)] = make_float3 (depths_14.w) * raydir_32;
            float2  uv_95 = (pix_center_26 - _S2461) / _S2462;
            FixedArray<float, 58>  _S2471 = dist_coeffs_46;
            float2  uv_u_87;
            bool _S2472 = undistort_point_0(uv_95, &_S2471, int(12), &uv_u_87);
            if(!_S2472)
            {
                _S2454 = int(0);
                _S2455 = &points_25[int(1)];
                _S2456 = &points_25[int(0)];
                _S2457 = &points_25[int(3)];
                _S2458 = &points_25[int(2)];
                break;
            }
            float3  raydir_33 = unproject_raydir_0(uv_u_87, camera_model_44, is_ray_depth_40);
            _S2454 = int(1);
            _S2455 = &points_25[int(1)];
            _S2456 = &points_25[int(0)];
            _S2457 = &points_25[int(3)];
            _S2458 = &points_25[int(2)];
            _S2459 = raydir_33;
            break;
        }
        if(_S2454 != int(1))
        {
            _S2460 = 0.0f;
            break;
        }
        float3  normal_28 = cross_0(*_S2455 - *_S2456, - (*_S2457 - *_S2458));
        float3  normal_29;
        if((dot_1(normal_28, normal_28)) != 0.0f)
        {
            normal_29 = normalize_0(normal_28);
        }
        else
        {
            normal_29 = normal_28;
        }
        float3  _S2473;
        if((dot_1(gt_normal_6, gt_normal_6)) != 0.0f)
        {
            _S2473 = normalize_0(gt_normal_6);
        }
        else
        {
            _S2473 = gt_normal_6;
        }
        _S2460 = (1.0f - dot_1(normal_29, _S2473) + 0.00100000004749745f) / ((F32_max((dot_1(normal_29, - normalize_0(_S2459))), (0.0f))) + 0.00100000004749745f);
        break;
    }
    return _S2460;
}

inline __device__ void depth_normal_loss_vjp_polar(float2  pix_center_27, float4  intrins_43, FixedArray<float, 58>  dist_coeffs_47, int camera_model_45, bool is_ray_depth_41, float4  depths_15, float3  gt_normal_7, float v_loss_3, float4  * v_depths_7, float3  * v_gt_normal_3)
{
    float4  _S2474 = make_float4 (0.0f);
    DiffPair_vectorx3Cfloatx2C4x3E_0 dp_depths_7;
    (&dp_depths_7)->primal_0 = depths_15;
    (&dp_depths_7)->differential_0 = _S2474;
    float3  _S2475 = make_float3 (0.0f);
    DiffPair_vectorx3Cfloatx2C3x3E_0 dp_gt_normal_3;
    (&dp_gt_normal_3)->primal_0 = gt_normal_7;
    (&dp_gt_normal_3)->differential_0 = _S2475;
    FixedArray<float, 58>  _S2476 = dist_coeffs_47;
    _S487(pix_center_27, intrins_43, &_S2476, camera_model_45, is_ray_depth_41, &dp_depths_7, &dp_gt_normal_3, v_loss_3);
    *v_depths_7 = dp_depths_7.differential_0;
    *v_gt_normal_3 = dp_gt_normal_3.differential_0;
    return;
}

