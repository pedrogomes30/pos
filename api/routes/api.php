<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/**
 * @OA\Get(
 *     path="/api/users",
 *     tags={"Users"},
 *     summary="Get all users",
 *     @OA\Response(response="200", description="List of users")
 * )
 */
Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
